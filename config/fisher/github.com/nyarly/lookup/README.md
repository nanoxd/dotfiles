# lookup

Simple function that takes a single argument: the name of a file. 
It outputs the path (if any) a path above the current working directory which contains a file or directory with that name.

For instance `lookup .git` will return the path of the closest enclosing git workspace.

This is basically a complete theft of https://github.com/silentbicycle/lookup which should be a part of any reasonable operating system.

Since we live in an imperfect world, this function stands in for it.
