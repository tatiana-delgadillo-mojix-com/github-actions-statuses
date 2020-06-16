#!/usr/bin/python

import sys
import os
print("Received arguments: "+str(len(sys.argv)))
print("Printing arguments: "+str(sys.argv))
print("Printing env variables: ")

for item, value in os.environ.items():
    print('{}: {}'.format(item, value))