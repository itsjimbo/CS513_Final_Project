#!/bin/sh
# build yesworkflow svg for our setup
source ~/.bash_profile
yw graph -config graph.layout=LR setup.sh  > svg/wf.tmp; dot -Tsvg svg/wf.tmp -o svg/setup.svg; rm svg/wf.tmp;
# convert svg to png
rsvg-convert  -h 500 svg/setup.svg > svg/setup.png
