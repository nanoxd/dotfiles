function calibre-search -d "Search Calibre's DB for eBooks"
  calibredb list -s $argv | grep -i "$argv"
end
