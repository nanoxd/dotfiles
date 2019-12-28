# Cache-file

It can be useful to build cache files for various purposes in Fish

This plugin provides utility functions for managing cache files.

Chief among them are `__cache_or_get <namespace> <anchorfile> <cmd>` and `__cache_zap <ns> <anchor> [find args]*`

`__cache_or_get` will look up the path for `<anchorfile>` 
(which much simply exist - file or directory are both okay)
and produce a cache file for that path under the indicated `<namespace>`.
Effectively, this just means that a path like 
`$XDG_CACHE_HOME/$namespace/(hash of $anchored_path)` 
gets assembled.

If a file at that path exists, it's contents are read and used.
Otherwise, the `<command>` is executed, and its stdout are recorded into the file.

`__cache_zap` finds the `hash of path` under the indicated namespace,
passing any extra arguments to find,
and deletes the found files.

What this means is that you can do something like: 
```
function __cached_remote_list
  __cache_zap service/list .git -atime +1h
  __cache_or_get service/list .git 'get-list-from-service.sh'
end
```
and retain the results of the (presumably) slow `get-list-from-service.sh` call
for an hour before calling it again.

This was designed primarily to be used for completion scripts where the source for the completion is unacceptably slow.
