module Hipe

import HTTP, StatsBase

export download_word_list, contains_hipe, extract_all_hipes

"""
    download_word_list() -> Vector{String}

Downloads the word list to use.
"""
function download_word_list()
    word_list_url = "https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt"
    req = HTTP.get(word_list_url)
    return String.(split(String(req.body), "\r\n"))
end

"""
    contains_hipe(hipe::String, word::string) -> Boolean

Whether `word` contains the hipe `hipe`.
"""
contains_hipe(hipe::String, word::String) = occursin(hipe, word)

"""
    extract_all_hipes(word_list::Vector{String}, hipe_length::Int) -> Vector{Pair{String, Int}}

Given the list of words `word_list`, get all occuring hipes with length `hipe_length`.
"""
function extract_all_hipes(word_list::Vector{String}, hipe_length::Int)
    # get for each word all hipes
    n2 = ngram.(word_list, hipe_length)

    # squash into a single long list
    n2 = collect(Iterators.flatten(n2))

    # create a dict with the hipe as key, the frequency of the hipe as value
    count_map = StatsBase.countmap(n2)

    # collect() makes the dict an array of Pairs, allowing us to sort
    sorted = sort(collect(count_map), by=last)
    return sorted
end

function ngram(x::String, n::Int)
    return [x[i:(i+n-1)] for i=1:(length(x)-n+1)]
end

end # module
