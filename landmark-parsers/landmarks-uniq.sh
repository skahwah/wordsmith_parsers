#!/bin/bash
# Written by Sanjiv Kawa
# Twitter @hackerjiv
# 10/6/17

for i in $(ls); do echo "[+] Uniquing $i"; cat $i | sort | uniq > 1; mv 1 $i; done
for i in $(ls); do echo "[+] Removing Hyperlinks $i"; cat $i | grep -v "http://" | grep -v "https://" > 1; mv 1 $i; done
