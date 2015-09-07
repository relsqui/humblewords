# Humble Words

## Description and Usage
```
relsqui@albatross:~/humblewords$ ./humble.sh -h
usage: humble.sh [-f WORD_FILE] [-g GUESS_FILE] [-h]

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
```

## Example
```
relsqui@albatross:~$ git clone git@github.com:relsqui/humblewords.git
[...]
relsqui@albatross:~$ cd humblewords/
relsqui@albatross:~/humblewords$ ./humble.sh 

I'm thinking of a word. Guess what it is, and I'll tell you whether my word
comes before or after your guess, alphabetically. (The possibility count is
the number of words I could have chosen in the range you've narrowed it down
to so far.) To quit, type Ctrl-C or Ctrl-D.

Guess 1: late
It's after late.
Range: late to zone (2136 possibilities).

Guess 2: sear
It's after sear.
Range: sear to zone (956 possibilities).

[...]

Guess 6: sour
It's before sour.
Range: sear to sour (224 possibilities).

Guess 7: sire
It's after sire.
Range: sire to sour (82 possibilities).

[...]

Guess 17: skill
It's after skill.
Range: skill to skit (4 possibilities).

Guess 18: skin
It's after skin.
Range: skin to skit (2 possibilities).

Guess 19: skip

You got it in 19 guesses!
```

## Why "Humble"?
On the valid guess list, it's halfway between "binary" and "search."
