#!/usr/bin/python
# -*- coding: utf-8 -*-

# Tom Porter (@porterhau5)

from imposm.parser import OSMParser
from unidecode import unidecode
import optparse
import os

# simple class that handles the parsed OSM data.
class States(object):
    counties = set()
    cities = set()
    colleges = set()
    roads = set()

    #cityvals = ['city','borough','town','village','hamlet','isolated_dwelling','township']
    cityvals = ['city','borough','town','township','village']
    collegevals = ['college','university']
    countyvals = ['county','municipality','district','region']
    roadvals = ['motorway','trunk','primary','secondary','tertiary','unclassified','residential','service','motorway_link','trunk_link','primary_link','secondary_link','tertiary_link','living_street','pedestrian','track','bus_guideway','raceway','road']

    def __init__(self, state):
        self.state = state

    def curate(self, string):
        return unidecode(string).lstrip().rstrip()

    def addto(self, collection, tags):
        if 'name:en' in tags:
            collection.add(self.curate(tags['name:en']))
        elif 'int_name' in tags:
            collection.add(self.curate(tags['int_name']))
        else:
            collection.add(self.curate(tags['name']))
        if 'alt_name' in tags:
            for ele in tags['alt_name'].split(';'):
                collection.add(self.curate(ele))

    def ways(self, ways):
        for osmid, tags, refs in ways:
            # US state counties
            if self.state != None:
                if 'gnis:County' in tags and 'gnis:ST_alpha' in tags and tags['gnis:ST_alpha'] == self.state:
                    self.counties.add(self.curate(tags['gnis:County']))
            # other counties
            else:
                if 'INEGI:MUNID' in tags and 'name' in tags:
                    self.addto(self.counties, tags)
                if 'gnis:County' in tags:
                    self.counties.add(self.curate(tags['gnis:County']))
                if 'place' in tags and tags['place'] in self.countyvals and 'name' in tags:
                    self.addto(self.counties, tags)
            # cities
            if 'place' in tags and tags['place'] in self.cityvals and 'name' in tags:
                self.addto(self.cities, tags)
            # colleges
            if 'amenity' in tags and tags['amenity'] in self.collegevals and 'name' in tags:
                self.addto(self.colleges, tags)
            # roads
            if 'highway' in tags and tags['highway'] in self.roadvals and 'name' in tags:
                self.addto(self.roads, tags)

    def nodes(self, nodes):
        for osmid, tags, coordstuple in nodes:
            # US state counties
            if self.state != None:
                if 'gnis:County' in tags and 'gnis:ST_alpha' in tags and tags['gnis:ST_alpha'] == self.state:
                    self.counties.add(self.curate(tags['gnis:County']))
            # other counties
            else:
                if 'INEGI:MUNID' in tags and 'name' in tags:
                    self.addto(self.counties, tags)
                if 'gnis:County' in tags:
                    self.counties.add(self.curate(tags['gnis:County']))
                if 'place' in tags and tags['place'] in self.countyvals and 'name' in tags:
                    self.addto(self.counties, tags)
            # cities
            if 'place' in tags and tags['place'] in self.cityvals and 'name' in tags:
                self.addto(self.cities, tags)
            # colleges
            if 'amenity' in tags and tags['amenity'] in self.collegevals and 'name' in tags:
                self.addto(self.colleges, tags)
            # roads
            if 'highway' in tags and tags['highway'] in self.roadvals and 'name' in tags:
                self.addto(self.roads, tags)

    def relations(self, relations):
        for osmid, tags, memberstuples in relations:
            # US state counties
            if self.state != None:
                if 'gnis:County' in tags and 'gnis:ST_alpha' in tags and tags['gnis:ST_alpha'] == self.state:
                    self.counties.add(self.curate(tags['gnis:County']))
            # other counties
            else:
                if 'INEGI:MUNID' in tags and 'name' in tags:
                    self.addto(self.counties, tags)
                if 'gnis:County' in tags:
                    self.counties.add(self.curate(tags['gnis:County']))
                if 'place' in tags and tags['place'] in self.countyvals and 'name' in tags:
                    self.addto(self.counties, tags)
            # cities
            if 'place' in tags and tags['place'] in self.cityvals and 'name' in tags:
                self.addto(self.cities, tags)
            # colleges
            if 'amenity' in tags and tags['amenity'] in self.collegevals and 'name' in tags:
                self.addto(self.colleges, tags)
            # roads
            if 'highway' in tags and tags['highway'] in self.roadvals and 'name' in tags:
                self.addto(self.roads, tags)

def main():
    usage = ("Usage: %prog INFILE [-o OUTFILE]"
          "\n\nAn XML parser for output generated by python-evtx. Parses input "
          "XML file and pulls fields related to Logon events (EventID 4624)."
          "\nSorts and removes duplicates records. By default writes output to "
          "\'logons.csv\' in current working directory unless -o option is "
          "specified."
          "\n\nOutput format:"
          "\n  IpAddress,TargetDomainName,TargetUserName,WorkstationName"
          "\n\nExamples:\n  %prog CORP-dump.xml"
          "\n  %prog CORP-dump.xml -o CORP-logons.csv"
          "\n\nType -h or --help for a full listing of options.")
    parser = optparse.OptionParser(usage=usage)
    parser.add_option('-s',
                      dest='state',
                      type='string',
                      help="state abbrev - NC, SC, VA, etc.")
    parser.add_option('-f',
                      dest='filename',
                      type='string',
                      help="file to parse")

    (options, args) = parser.parse_args()

    state = options.state
    filename = options.filename

    # verify positional argument is set (INFILE)
    #if len(args) == 0:
    #    parser.error("XML input file not set")
    #    exit(1)
    #else:
    #    file_path = args[0]
        # verify input file exists
    #    if not os.path.isfile(file_path):
    #        parser.error("%s - file does not exist" % file_path)
    #        exit(1)

    files = []

    if filename != None:
        if not os.path.isfile(filename):
            parser.error("%s - file does not exist" % filename)
            exit(1)
        files.append(filename)
    else:
        for root, directories, filenames in os.walk('gisgraphy/'):
            for f in filenames: 
                files.append(os.path.join(root,f))

        #parser.error("No input file (-f) specified")
        #exit(1)

    for filename in files: 
        if filename.split('.')[0].split('gisgraphy/')[-1].split('/')[0] == "usa":
            state = filename.split('.')[0].split('gisgraphy/')[-1].split('/')[1].upper()

        # instantiate counter and parser and start parsing
        collector = States(state)
        p = OSMParser(concurrency=4, nodes_callback=collector.nodes, ways_callback=collector.ways,
                      relations_callback=collector.relations)
        #p = OSMParser(concurrency=4, nodes_callback=collector.nodes)
        p.parse(filename)

        path = "data/" + filename.split('.')[0].split('gisgraphy/')[-1]

        try: 
            os.makedirs(path)
        except OSError:
            if not os.path.isdir(path):
                raise

        # counties / municipalities (mex)
        outfile = path + '/counties.txt'
        count = len(collector.counties)
        if count != 0:
            with open(outfile, "w") as f:
                f.write("\n".join(sorted(collector.counties)))
                f.write("\n")
            print outfile + ": " + str(count)
        else:
            print outfile + ": 0"

        # cities
        outfile = path + '/cities.txt'
        count = len(collector.cities)
        if count != 0:
            with open(outfile, "w") as f:
                f.write("\n".join(sorted(collector.cities)))
                f.write("\n")
            print outfile + ": " + str(count)
        else:
            print outfile + ": 0"

        # roads
        outfile = path + '/roads.txt'
        count = len(collector.roads)
        if count != 0:
            with open(outfile, "w") as f:
                f.write("\n".join(sorted(collector.roads)))
                f.write("\n")
            print outfile + ": " + str(count)
        else:
            print outfile + ": 0"

        # zero out sets
        collector.counties.clear()
        collector.cities.clear()
        collector.roads.clear()


        #print "\n".join(sorted(collector.colleges))

if __name__ == '__main__':
    main()
