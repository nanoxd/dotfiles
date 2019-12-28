function __cache_or_get -a ns anchor get_cmd
  set -l cache_file (__cache_path $ns $anchor)

  if not test -f "$cache_file"
    eval $get_cmd > "$cache_file"
  end
  cat "$cache_file"
end
