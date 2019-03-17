
using Hipe
using Test

@test contains_hipe("al", "ball")
@test !contains_hipe("la", "ball")

@test extract_all_hipes(["ball", "hi"], 2) == [Pair("ll", 1),
    Pair("hi", 1),
    Pair("al", 1),
    Pair("ba", 1)]
