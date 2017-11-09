function cug -d 'Install/Update a Carthage framework'
  carthage update --platform ios --cache-builds $argv
end
