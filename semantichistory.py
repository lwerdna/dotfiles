#!/usr/bin/env python

# this is meant to be a "coprocess" for "semantic history" in iTerm2 settings
# in plain English, it returns a string the shell should execute when you cmd+click on a file or path
import os, sys

if not sys.argv[1:]:
    sys.exit(-1)

path = sys.argv[1]

if os.path.isdir(path):
    print('pushd %s' % path)
elif os.path.isfile(path):
    print('open %s' % path)


