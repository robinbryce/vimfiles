import os
from os.path import isfile, isdir, join, dirname, abspath, realpath

def find_nearest(markerfile, startdir=None):

    """Find the first directory which contains markerfile

    Search includes current directory then each successive ancestor.

    """

    if startdir is None:
        startdir = realpath(abspath(os.getcwd()))

    if not isdir(startdir):
        return None

    prevdir = None
    curdir = startdir
    while curdir != prevdir:
        if isfile(join(curdir, markerfile)):
            return curdir
        prevdir = curdir
        curdir = dirname(curdir)
    return None


def find_furthest(markerfile, startdir=None):

    """Find the oldest ancestor directory which contains markerfile

    In the unbroken lineage starting from the *first* ancestor directory.

    """

    firstdir = find_nearest(markerfile, startdir=startdir)
    if firstdir is None:
        return None

    curdir = firstdir
    nextdir = dirname(firstdir)
    while nextdir != curdir and isfile(join(nextdir, markerfile)):
        curdir = nextdir
        nextdir = dirname(nextdir)

    assert isdir(curdir)
    return curdir

#:END
