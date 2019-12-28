function __cache_zap --description 'Deletes cache files for the current directory under <ns>' --argument ns anchor extra_find
	set -l constraints ""
  if [ (count $argv) -gt 2 ]
    set contraints $argv[3..-1]
  end
	for f in (eval find (__cache_dir $ns) -name (__cache_key $anchor) $contraints -print)
    rm $f
  end
end
