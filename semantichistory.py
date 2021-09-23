#!/usr/bin/env python

# this is meant to be a "coprocess" for "semantic history" in iTerm2 settings
# in plain English, it returns a string the shell should execute when you cmd+click on a file or path
import os, sys

logging = False
fp = None

if not sys.argv[1:]:
    sys.exit(-1)

path = sys.argv[1]

if logging:
    fp = open('/tmp/semantichistory.log', 'w')
    fp.write('type(path): %s\n' % type(path))
    fp.write('path: -%s-\n' % path)

if path.startswith("'") and path.endswith("'"):
    path = path[1:-1]

cmd = 'default'

if os.path.isdir(path):
    cmd = 'pushd %s' % path.replace(' ', '\\ ')
elif os.path.isfile(path):
    cmd = 'open %s' % path.replace(' ', '\\ ')
else:
    raise Exception('do not know how to handle: %s' % path)

if logging:
    fp.write('cmd: %s\n' % cmd)
    fp.close()

print(cmd)
