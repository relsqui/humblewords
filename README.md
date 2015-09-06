## Humble Words
A simple bash word game. Guess what word the game has chosen; it will tell you whether each guess precedes or follows the target word, alphabetically.

## Usage
```
cd humblewords
./humble.sh
```

## Configuration
You can change the word lists in use, if you wish, by editing the first two variables in humble.sh.

## What are the two word lists?
`word_list.txt` is the list from which the game will select words. These are selected from COCA's 5000 most frequent American English words, omitting any with non-ASCII or uppercase. `valid_guesses.txt` is based on /usr/share/dict/words, with the same filters. They're separate to ensure that the game will only choose well-known words but you can guess more obscure ones if you wish.

## Why "Humble"?
On the valid guess list, it's halfway between "binary" and "search."
