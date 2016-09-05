function pbssh -d "Copy SSH key to Clipboard"
  if test -d "$HOME/.ssh"
    cat ~/.ssh/.id_rsa.pub | pbcopy
  else
    echo "No SSH Key found"
  end
end
