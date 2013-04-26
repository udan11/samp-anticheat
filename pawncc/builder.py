#!/usr/bin/env python
#
# Copyright (c) 2013, Dan
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met: 
#
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer. 
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution. 
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import os
import sys
import time

start = time.clock()

# Checks if a string matches a wildcard pattern.
# @param string string
# @param string pattern
# @return bool
def is_wc_match(string, pattern):
	# Appending special character at the end of string and pattern.
	string += '\1'
	pattern += '\1'
	last_idx = -1
	# Splitting the pattern and searching the fragments in original string.
	for i in pattern.split('*'):
		if (len(i) > 0):
			last_idx = string.find(i, last_idx + 1)
			if (last_idx == -1):
				# Fragment not found.
				return 0
	return 1

# Joins two elements of a path (safely) and makes it UNIX-like.
# @param string a
# @param string b
# @returns string
def join_path(a, b):
	return os.path.join(a, b).replace('\\', '/')

print("Pawn builder 1.0                        Copyright (c) 2012-2013 Dan")

# Checking if parameters are valid.
if (len(sys.argv) != 3):
	sys.exit("  USAGE: builder.py <project folder> <output file>")

# Reading configuration.
project_folder = sys.argv[1]
output_filename = sys.argv[2]
structure_filename = os.path.join(project_folder, ".structure").replace('\\','/')

# Reading structure.
if (not os.path.isfile(structure_filename)):
	sys.exit("  ERROR: No .structure file found in project's folder.")
file = open(structure_filename)
structure = file.read().split("\n")
file.close()

# Building file list.
file_list = []
for root, sub_folders, files in os.walk(project_folder):
	for file in files:
		file_list.append(join_path(root, file)[len(project_folder):])
		
# Ordering the file list.
ordered_file_list = []
for s in structure:
	for f in file_list:
		if ((is_wc_match(f, s)) and (f not in ordered_file_list)):
			ordered_file_list.append(f)
			
# Writing the output file.
output_file = open(output_filename, 'w')
for f in ordered_file_list:
	tmp = open(project_folder + f)
	output_file.write("#file \"" + f + "\"\n#line 0\n")
	output_file.write(tmp.read())
	output_file.write("\n")
	tmp.close()
output_file.write("#file \"" + output_filename + "\"\n#line 0")
output_file.close()

# Done. :)	
print("")
print("Files found: {0:14d} files".format(len(ordered_file_list)))
print("Bytes written: {0:12d} bytes".format(os.path.getsize(output_filename)))
print("")
print("Execution time: {0:11.2f} seconds".format(time.clock() - start))