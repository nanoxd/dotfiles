function android-method-count -d "Count number of methods in an APK"
  unzip -p $argv classes.dex | head -c 92 | tail -c 4 | hexdump -e '1/4 "%d\n"'
end
