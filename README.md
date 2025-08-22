# [find-files.sh](find-files.sh)
Bash commands to quickly find files.
<br/><br/>
## Example usages:
```bash
# My prompt
$ ./find.sh

# Output
Usage: ./find.sh STRING (1-3) (LOCATION)
```

### Finding a file by its name
```bash
# My prompt
$ ./find.sh firefox

# Help text
1(w) - search for a file(w = whole path) named 'firefox' (by default in /)
2(w) - search for a file(w = whole path) containing 'firefox' in its name (by default in /)
3(d) - search for a file(d = display the content) containing 'firefox' in its content (by default in .)

# My input
1

# Output
find / -iname firefox 2>/dev/null # actual command used
/home/kuba/.local/share/Trash/files/firefox-141.0 (2)/firefox
/home/kuba/.local/share/Trash/files/firefox-141.0 (2)/firefox/firefox
/home/kuba/.local/share/Trash/files/bin2/firefox
/home/kuba/.local/share/Trash/files/bin2.2/firefox
/home/kuba/.local/share/Trash/files/bin2.3/bin/firefox
```

### Finding a file by its partial path
```bash
# My prompt
$ ./find.sh folder*test 2w

# Output
find / -iwholename *folder*test* 2>/dev/null # actual command used
/home/kuba/Desktop/folder/test.txt
```

### Finding a file by its content
```bash
# My prompt
$ ./find.sh "test string to search" 3d folder

# Output
grep -rnI --color=always test string to search folder 2>/dev/null # actual command used
folder/test.txt:1:the test string to search is in this file
Open files? (yes=Enter, no=Ctrl+C)
```
