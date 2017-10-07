

## Get current time in Epoch seconds
START=$(date +%s)

## End time in Epoch seconds (Epoch - use https://www.epochconverter.com/ to convert from human date)
END=1507608000

## Calculate time remaining until the end 
TIME_REM=$(echo "$END - $START" | bc)

## Calculate hours remaining until the end (round up)
FULL_HRS_REM=$(echo "$TIME_REM / 3600" | bc)

## Calculate remainder seconds in that hour 
REM_SEC_REM=$(echo "$TIME_REM % 3600" | bc)

if [ "$REM_SEC_REM" -lt 3600 ]; then
    FULL_HRS_REM=$(echo "$FULL_HRS_REM + 1" | bc)
fi

## Get number of lines from pre-populated text file
NUM_DJS=$(wc -l < upcoming-djs.txt)

## Get line number for pre-populated text file based on total hours and number of DJs (1 per hour per line)
LINE_NUM=$(echo "$NUM_DJS - $FULL_HRS_REM" | bc)

## Format line number for `sed` command
LINE_NUM_LOOKUP="$LINE_NUM""p"

## Get current playing DJ by looking up the line number in the pre-populated text file
NOWPLAYING_DJ=$(sed -n $LINE_NUM_LOOKUP upcoming-djs.txt)

## Update hours remaining text file (read from source on OBS)
echo $FULL_HRS_REM > hours-remaining.txt

## Update now playing DJ text file (read from source on OBS)
echo $NOWPLAYING_DJ > nowplaying-dj.txt