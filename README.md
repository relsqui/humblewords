# Humble Words

## Example
```
relsqui@albatross:~$ cd humblewords/
relsqui@albatross:~/humblewords$ ./humble.sh 

I'm thinking of a word. Guess what it is, and I'll tell you whether your guess
comes before or after my word, alphabetically. To quit, type Ctrl-C or Ctrl-D.

Guess 1: moose
It's before moose.
Range: a to moose

Guess 2: fact
It's before fact.
Range: a to fact

...

Guess 8: effable
It's after effable.
Range: effable to enemy

Guess 9: eligible
It's before eligible.
Range: effable to eligible

...

Guess 16: electable
It's after electable.
Range: electable to electric

Guess 17: elector
It's before elector.
Range: electable to elector

Guess 18: election

You got it in 18 guesses!
```

## Configuration
You can change the word lists in use and the word wrap width by editing the variables in humble.sh.

## What are the two word lists?
`word_list.txt` is the list from which the game will select words. These are selected from COCA's 5000 most frequent American English words, omitting any with non-ASCII or uppercase. `valid_guesses.txt` is based on /usr/share/dict/words, with the same filters. They're separate to ensure that the game will only choose well-known words but you can guess more obscure ones if you wish.

## Why "Humble"?
On the valid guess list, it's halfway between "binary" and "search."
