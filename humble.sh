#!/bin/bash

WORD_LIST="word_list.txt"
VALID_GUESSES="valid_guesses.txt"
WRAP_WIDTH=80

end_game() {
    echo
    if [[ "$GUESS" == "$TARGET" ]]; then
        echo "You got it in $GUESSES guesses!"
    else
        echo
        let GUESSES=$GUESSES-1
        echo "The word was: $TARGET"
        echo "You used $GUESSES guesses."
    fi
    # Exit explicitly, in case we're inside a trap.
    exit 0
}

plural() {
    if [ "$1" -eq 1 ]; then
        echo "y"
    else
        echo "ies"
    fi
}

# Show the word when the player gives up.
trap end_game exit

TARGET=`sort -R $WORD_LIST | head -n 1`
LOWER=`head -n 1 $WORD_LIST`
UPPER=`tail -n 1 $WORD_LIST`
GUESSES=1

echo
cat << EOF | fmt -$WRAP_WIDTH
I'm thinking of a word. Guess what it is, and I'll tell you whether my word
comes before or after your guess, alphabetically. (The possibility count is the
number of words I could have chosen in the range you've narrowed it down to so
far.) To quit, type Ctrl-C or Ctrl-D.
EOF
echo

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
    IES=`plural $POSSIBILITIES`
    echo "Range: $LOWER to $UPPER ($POSSIBILITIES possibilit$IES)."
    echo
done
