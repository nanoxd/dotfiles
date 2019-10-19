function __get_rake_completion -d "Prints rake completions"
  rake -AT 2>&1 | sed -e 's/^rake \([a-z:_0-9!\-]*\).*#\(.*\)/\1'\t'\2/'
end

function __run_rake_completion
  test -f rakefile; or test -f Rakefile; or test -f rakefile.rb; or test -f Rakefile.rb
end

complete -x -c rake -a "(__get_rake_completion)" -f -n __run_rake_completion
