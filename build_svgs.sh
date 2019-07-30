#!/bin/sh
# build yesworkflow svg for our setup
source ~/.bash_profile
yw graph setup.sh  > svg/wf.tmp; dot -Tsvg svg/wf.tmp -o svg/setup.svg; rm svg/wf.tmp;
# convert svg to png
rsvg-convert  -h 150 svg/setup.svg > svg/setup.png
