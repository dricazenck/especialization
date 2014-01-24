#/bin/python

from os import listdir
from os.path import isfile, join
import sys

mypath = '/mnt/dados/diarias/utf-8/'
onlyfiles = [ f for f in listdir(mypath) if isfile(join(mypath,f)) ]
i = 1
for f in onlyfiles:
    f=mypath+f
    if f[-3:] == "csv":
    	with open(f) as infile:
            first = True
            for line in infile:
                if first == False:
                    # print str(i)+"\t"+line
                    sys.stdout.write(str(i)+"\t"+line)
                    i = i + 1
                first = False
