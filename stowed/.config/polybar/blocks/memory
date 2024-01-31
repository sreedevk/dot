#!/bin/sh

echo "$(free --giga --human | awk 'NR==2 {printf "%.2f/%.2f G\n", $3, $2}')"

exit 0
