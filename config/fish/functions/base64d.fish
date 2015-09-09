function base64d -d "Base64 Decodes a string and pretty prints it"
  echo $argv | base64 -D - | jq .
end
