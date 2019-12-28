function get_file_age -a file
    if command -s perl >/dev/null
        command perl -e "printf(\"%s\n\", time - (stat ('$file'))[9])"
    else if command -s python >/dev/null
        command python -c "from __future__ import print_function; import os, time; print(int(time.time() - os.path.getmtime('$file')))"
    else if command -s node >/dev/null
        command node -e "console.log(~~((new Date().getTime() - new Date(fs.statSync('$file').mtime).getTime()) / 1000))"
    else
        math (command date +%s) - (command date +%s -r $file)
    end
end
