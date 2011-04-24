# ERV 20101205

import sys
import json
import string
from types import *

def sanitize(s):
	return s.replace("&", "&amp;")

def print_object(obj):

	if type(obj) is ListType:

		print ("<array>")
		for thing in obj:
			print_object(thing)
		print ("</array>")
	
	elif type(obj) is DictType:

		print ("<dict>")
		for key in obj.keys():
			print ("<key>%s</key>" % sanitize(key))
			print_object(obj[key])
		print ("</dict>")
		
	elif type(obj) is StringType:
	
		print ("<string>%s</string>" % sanitize(obj))
	
	elif type(obj) is UnicodeType:
	
		print ("<string>%s</string>" % sanitize(obj))
	
	elif type(obj) is IntType:
	
		print ("<integer>%d</integer>" % obj)
	
	elif type(obj) is FloatType:
	
		print ("<real>%g</real>" % obj)
	
	elif type(obj) is BooleanType:
	
		if obj:
			print ("<true />")
		else:
			print ("<false />")
	
	#else:
	
	#	print (type(obj))
	
		
jsfile = open(sys.argv[1], "r").read()
jsobj = json.loads(jsfile)

print """
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN"
   "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
"""

print_object(jsobj)

print """
</plist>
"""
