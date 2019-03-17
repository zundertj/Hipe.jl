Hipe.jl
===========

Small toolkit for generating and analyzing HIPE's.

## What is a hipe?
A *hipe* is a combination of letters that occurs rarely consecutively in words.
See https://www.researchgate.net/publication/31507186_A_Wordy_Digression_The_Game_of_Hipe for more details.

## Usage
This package depends on an external word list of English words. The function `download_word_list` downloads a freely available list (NOTE: the quality is not too great, if you know any better, let me know).

```julia
using Hipe
word_list = download_word_list()
```

The function `contains_hipe` checks whether a hipe is embedded in a word. The code below analyzes a number of hipes, and stores all words containing it in a dictionary.
```julia
hipes = ["wnm", "hq", "thac", "bv", "hipe", "ptc"]
results = Dict(hp => word_list[contains_hipe.(hp, word_list)] for hp in hipes)
```

To come up with new hipes, one can take the opposite route:

```julia
# get all hipes in the word list of length 2
all_hipes_sorted = extract_all_hipes(word_list, 2)
```
