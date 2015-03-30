# Add homebrew to path
if uname -s | grep Darwin
then
  export PATH="/usr/local/bin:$PATH"
fi
