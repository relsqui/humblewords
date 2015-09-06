#!/bin/bash

WORD_LIST="word_list.txt"
VALID_GUESSES="valid_guesses.txt"

end_game() {
    echo
    if [[ "$GUESS" == "$TARGET" ]]; then
        echo "You got it in $GUESSES guesses!"
    else
        let GUESSES=$GUESSES-1
        echo "The word was: $TARGET"
        echo "You used $GUESSES guesses."
    fi
    # Exit explicitly, in case we're inside a trap.
    exit 0
}

# Show the word when the player gives up with ctrl-c.
trap end_game exit

TARGET=`sort -R $WORD_LIST | head -n 1`
LOWER=`head -n 1 $WORD_LIST`
UPPER=`tail -n 1 $WORD_LIST`
GUESSES=1

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
    fi
    echo "Range: $LOWER to $UPPER"
    echo
done
