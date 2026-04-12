function mkc -d "Make directory (with parents) and cd into it"
    mkdir -p $argv[-1]; and cd $argv[-1]
end
