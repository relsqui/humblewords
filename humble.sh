#!/bin/bash

# Configure command line arguments.

ARGS=`getopt -o f:g:h -l file:,guesses:,help -- "$@"`
eval set -- "$ARGS"

# Set defaults.

WORD_LIST="word_list.txt"
VALID_GUESSES="valid_guesses.txt"

# Process arguments.

while [ "$1" != "--" ]; do
    case "$1" in
        -f|--file)
            WORD_LIST="$2"
            shift 2
        ;;
        -g|--guesses)
            VALID_GUESSES="$2"
            shift 2
        ;;
        -h|--help)
            cat <<EOF
usage: $(basename $0) [-f WORD_FILE] [-g GUESS_FILE] [-h]

Humble Words, a simple guessing game. Try to guess the target word based on
clues of whether it comes before or after your previous guesses alphabetically.
A running total of guesses includes only the ones that gave you new information
(not the ones that weren't recognized or didn't narrow your search space. You
can also see the number of words the game might have chosen that are in the
current range after each guess.

The default word file is adapted from the top 5000 most frequent words list
published by the Corpus of Contemporary American English.

Source: https://github.com/relsqui/humblewords

Options:
        -f, --file      Specify the location of a list of words to use as
                        potential targets. It should have one word per line.
        -g, --guesses   Specify the location of a list of words to recognize
                        as valid guesses. It should have one word per line.
                        This selection can be sketchier than the above list,
                        since they won't be chosen as targets.
        -h, --help      Display help.

EOF
            exit 0
        ;;
        --)
            shift
            break
        ;;
        *)
            echo "Unrecognized option: '$1'" >&2
            echo "$(basename $0) -h for help." >&2
            exit 1
    esac
done

shift
if [ "$1" ]; then
    echo "Unrecognized option: '$1'" >&2
    echo "$(basename $0) -h for help." >&2
    exit 1
fi

# Make sure word lists are valid.

if [[ ! -r "$WORD_LIST" ]]; then
    echo "Can't find or read word file: $WORD_LIST" >&2
    exit 2
fi

if [[ ! -r "$VALID_GUESSES" ]]; then
    echo "Can't find or read word file: $VALID_GUESSES" >&2
    exit 2
fi


# Utility functions for string output.

plural_ies() {
    if [ "$1" -eq 1 ]; then
        echo "y"
    else
        echo "ies"
    fi
}

plural_es() {
    if [ "$1" -ne 1 ]; then
        echo "es"
    fi
}

# Clean up when the game ends, no matter how.

trap end_game exit

end_game() {
    echo
    if [[ "$GUESS" == "$TARGET" ]]; then
        ES=`plural_es $GUESSES`
        echo "You got it in $GUESSES guess$ES!"
    else
        echo
        let GUESSES=$GUESSES-1
        ES=`plural_es $GUESSES`
        echo "The word was: $TARGET"
        echo "You used $GUESSES guess$ES."
    fi
    exit 0
}

# Initialize game state and explain the game.

TARGET=`sort -R $WORD_LIST | head -n 1`
LOWER=`head -n 1 $WORD_LIST`
UPPER=`tail -n 1 $WORD_LIST`
GUESSES=1

echo
cat << EOF
I'm thinking of a word. Guess what it is, and I'll tell you whether my word
comes before or after your guess, alphabetically. (The possibility count is the
number of words I could have chosen in the range you've narrowed it down to so
far.) To quit, type Ctrl-C or Ctrl-D.
EOF
echo

# Main loop.

while read -p "Guess $GUESSES: " GUESS && [[ "$GUESS" != "$TARGET" ]]; do
    GUESS=`echo "$GUESS" | tr A-Z a-z`
    if grep -q "$GUESS" $VALID_GUESSES; then
        if [[ "$GUESS" < "$TARGET" ]]; then
            if [[ "$GUESS" > "$LOWER" ]]; then
                let GUESSES=$GUESSES+1
                LOWER="$GUESS"
            fi
            echo "It's after $GUESS."
        else
            if [[ "$GUESS" < "$UPPER" ]]; then
                let GUESSES=$GUESSES+1
                UPPER="$GUESS"
            fi
            echo "It's before $GUESS."
        fi
    else
        echo "Sorry, I don't know that word."
        if echo "$GUESS" | grep -q '[^a-z]'; then
            echo "(I don't know any words with non-letters or capitals.)"
        fi
    fi
    LOWER_NO=`(cat $WORD_LIST; echo $LOWER) | sort | uniq | grep -n "^$LOWER$" | cut -d: -f1`
    UPPER_NO=`(cat $WORD_LIST; echo $UPPER) | sort | uniq | grep -n "^$UPPER$" | cut -d: -f1`
    if grep -q "^$LOWER$" $WORD_LIST; then
        let POSSIBILITIES=$UPPER_NO-$LOWER_NO-1
    else
        let POSSIBILITIES=$UPPER_NO-$LOWER_NO
    fi
    IES=`plural_ies $POSSIBILITIES`
    echo "Range: $LOWER to $UPPER ($POSSIBILITIES possibilit$IES)."
    echo
done
