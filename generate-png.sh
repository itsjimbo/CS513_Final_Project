#!/bin/sh
# pip install or2yw
FILENAME=$1
or2yw -i openrefine/$FILENAME.json  -o images/$FILENAME.yw.png -ot png -t parallel; open images/$FILENAME.yw.png;
