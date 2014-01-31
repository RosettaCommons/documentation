#!/usr/bin/env python2

import os
import sys
import shutil
import re

# Note the use of the non-greedy '.*?' pattern - this allows for multiple blocks on same page.
pattern = re.compile( r'''[<][!]---*\s*BEGIN_INTERNAL\s*-*--[>].*?[<][!]---*\s*END_INTERNAL\s*-*--[>]''',re.DOTALL)

def strip_internal( filename ):
    f = open(filename,'r')
    contents = f.read()
    f.close()
    if pattern.search(contents) is None:
        return #Don't touch file if we don't have to.
    contents = pattern.sub('',contents)
    f = open(filename,'w')
    f.write(contents)
    f.close()

if __name__ == "__main__":
    if os.path.exists( "./internal_documentation" ):
        shutil.rmtree( "./internal_documentation" )
    if os.path.exists( "Internal-Documentation.md" ):
        os.remove( "Internal-Documentation.md" )

    for path, subdirs, files in os.walk('.'):
        for filename in files:
            if filename.endswith(".md"):
                strip_internal(os.path.join(path,filename))

