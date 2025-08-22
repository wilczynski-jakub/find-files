#!/bin/bash

if [ $# -lt 1 ] || [ $# -gt 3 ]; then
    echo "Usage: $0 STRING (1-3) (LOCATION)"
    exit
fi

if [[ "$2" =~ ^(1|1w|2|2w|3|3d)$ ]]; then
    option="$2"
    if [ -n "$3" ]; then
        location="$3"
    fi
elif [ -n "$2" ]; then
    location="$2"
else
    echo "1(w) - search for a file(w = whole path) named '$1' (by default in /)"
    echo "2(w) - search for a file(w = whole path) containing '$1' in its name (by default in /)"
    echo "3(d) - search for a file(d = display the content) containing '$1' in its content (by default in .)"
    read option
fi

if [[ "$option" =~ ^(1|1w|2|2w)$ ]]; then
    : "${location:=/}"
    case "$option" in
        1)
            name="$1"
            ;;
        1w)
            name="*$1"
            ;;
        2|2w)
            name="*$1*"
            ;;
        *)
            ;;
    esac
    command="find $location -i"
    if [[ "$option" == *"w" ]]; then command+="whole"; fi
    command+="name $name"
elif [ "$option" = "3" ]; then
    : "${location:=.}"
    command="grep -rli $1 $location"
elif [ "$option" = "3d" ]; then
    : "${location:=.}"
    command="grep -rnI --color=always $1 $location 2>/dev/null"
fi

# uncomment if sudo permission needed for files not in ~
# if [[ "$(pwd)" != "$HOME"* ]]; then
#     command="sudo $command"
# fi

echo -n " $command 2>/dev/null"
sleep 0.5 && echo
sleep 0.5 && echo
$command 2>/dev/null

read -p "Open files? (yes=Enter, no=Ctrl+C) "

if [ "$option" = "3d" ]; then
    command="grep -rli $1 $location"
fi

for file in $($command 2>/dev/null); do
    xdg-open $(realpath $file)
done

