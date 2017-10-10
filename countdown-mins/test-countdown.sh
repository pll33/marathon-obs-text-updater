MINS=$(<countdown-mins.txt)
MINSM1=$(echo "$MINS - 1" | bc)
echo $MINSM1 > countdown-mins.txt