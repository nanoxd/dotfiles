function pbssh -d "Copy SSH key to Clipboard"
  if test -d "$HOME/.ssh"
    cat ~/.ssh/id_ed25519.pub | clipboard
  else
    echo "No SSH Key found"
  end
end
