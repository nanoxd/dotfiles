function __cache_key --argument anchor
	set -l anchored_dir (lookup $anchor); or return 1
  echo $anchored_dir | md5sum --text - | awk '{ print $1 }'
end
