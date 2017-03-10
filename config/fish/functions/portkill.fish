function portkill -d "Kill process on port"
  kill -9 (lsof -t -i :$argv)
end
