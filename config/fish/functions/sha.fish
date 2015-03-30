function sha -d "Generate SHA256 and copy to clipboard"
  shasum -a 256 $argv | cut -s -d' ' -f1 | tr -d '\n' | pbcopy
end
