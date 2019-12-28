function __cache_dir --argument ns
	set -l cache_dir
  if [ -z $XDG_CACHE_HOME ]
    set cache_dir "$HOME/.cache/fish/cached_files/$ns"
  else
    set cache_dir "$XDG_CACHE_HOME/fish/cached_files/$ns"
  end
  mkdir -p $cache_dir

  echo $cache_dir
end
