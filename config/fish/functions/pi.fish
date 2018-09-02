# Stolen from @keith https://github.com/keith/dotfiles/blob/master/functions/pi
function pi -d "Pod Install using bundler if available"
  if test -e "Gemfile" 
    bundle exec pod install; or bundle exec pod install --repo-update
  else
    pod install; or pod install --repo-update
  end
end
