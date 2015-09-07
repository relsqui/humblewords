# Humble Words

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

## Configuration
You can change the word lists in use and the word wrap width by editing the variables in humble.sh.

## What are the two word lists?
`word_list.txt` is the list from which the game will select words. These are selected from COCA's 5000 most frequent American English words, omitting any with non-ASCII or uppercase. `valid_guesses.txt` is based on /usr/share/dict/words, with the same filters. They're separate to ensure that the game will only choose well-known words but you can guess more obscure ones if you wish.

## Why "Humble"?
On the valid guess list, it's halfway between "binary" and "search."
