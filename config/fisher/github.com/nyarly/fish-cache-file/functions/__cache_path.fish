function __cache_path --argument ns anchor
	set -l hashed_pwd (__cache_key $anchor); or return 1
  echo (__cache_dir $ns)"/$hashed_pwd"
end
