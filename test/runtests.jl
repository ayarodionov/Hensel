# ----------------------------------------------------------------------

# ----------------------------------------------------------------------
using Test
using Hensel
# include("../src/Hensel.jl")

# ----------------------------------------------------------------------

@test Hensel.to01(0.5, 0, 1)    == 0.5
@test Hensel.to01(1.5, 1, 2)    == 0.5
@test Hensel.to01(1.3, 1, 2)    ≈  0.3
@test Hensel.to01(1.7, 1, 2)    ≈  0.7
@test Hensel.to01(-1.3, -2, -1) ≈  0.7
@test Hensel.to01(-1.7, -2, -1) ≈  0.3

@test Hensel.to01(0.5, (0, 1))    == 0.5
@test Hensel.to01(1.5, (1, 2))    == 0.5
@test Hensel.to01(1.3, (1, 2))    ≈  0.3
@test Hensel.to01(1.7, (1, 2))    ≈  0.7
@test Hensel.to01(-1.3, (-2, -1)) ≈  0.7
@test Hensel.to01(-1.7, (-2, -1)) ≈  0.3

@test Hensel.from01(0.5, 0, 1)   == 0.5
@test Hensel.from01(0.5, 1, 2)   == 1.5
@test Hensel.from01(0.3, 1, 2)   ≈  1.3
@test Hensel.from01(0.7, 1, 2)   ≈  1.7
@test Hensel.from01(0.7, -2, -1) ≈  -1.3
@test Hensel.from01(0.3, -2, -1) ≈  -1.7

@test Hensel.from01(0.5, (0, 1))   == 0.5
@test Hensel.from01(0.5, (1, 2))   == 1.5
@test Hensel.from01(0.3, (1, 2))   ≈  1.3
@test Hensel.from01(0.7, (1, 2))   ≈  1.7
@test Hensel.from01(0.7, (-2, -1)) ≈  -1.3
@test Hensel.from01(0.3, (-2, -1)) ≈  -1.7

@test Hensel.pIndex(0.5     , 2) == 1
@test Hensel.pIndex(0.4999  , 2) == 0
@test Hensel.pIndex(0.499999, 3) == 1
@test Hensel.pIndex(0.699999, 3) == 2

@test Hensel.hVector(0.5, 2, 3)   == [1, 0, 0]
@test Hensel.hVector(0.999, 2, 3) == [1, 1, 1]
@test Hensel.hVector(0.499, 2, 3) == [0, 1, 1]
@test Hensel.hVector(0.3, 2, 3)   == [0, 1, 0]

@test Hensel.hVector(11.5, 11, 12, 2, 3)    == [1, 0, 0]
@test Hensel.hVector(0.0, -1.0, 1.0, 2, 3)  == [1, 0, 0]
@test Hensel.hVector(-0.9, -1.0, 1.0, 2, 3) == [0, 0, 0]
@test Hensel.hVector(100.3, 100, 101, 2, 3) == [0, 1, 0]


@test Hensel.iValue([1, 1, 0], 2) == 3
@test Hensel.iValue([1, 0, 1], 2) == 5
@test Hensel.iValue([1, 1, 1], 2) == 7

@test Hensel.hVector(0, 2, 3) == [0, 0, 0]
@test Hensel.hVector(1, 2, 3) == [1, 0, 0]
@test Hensel.hVector(3, 2, 3) == [1, 1, 0]
@test Hensel.hVector(5, 2, 3) == [1, 0, 1]
@test Hensel.hVector(7, 2, 3) == [1, 1, 1]

@test Hensel.hVector(0.0, 2, 3) == [0, 0, 0]
@test Hensel.hVector(0.9, 2, 3) == [1, 1, 1] 
@test Hensel.hVector(1.0, 2, 3) == [1, 1, 1]
@test Hensel.hVector(0.0, 7, 3) == [0, 0, 0]
@test Hensel.hVector(0.005, 7, 3) == [0, 0, 1]
@test Hensel.hVector(0.995, 7, 3) == [6, 6, 5]
@test Hensel.hVector(1.0, 7, 3) == [6, 6, 6]


@test ((x) -> Hensel.hVector(x, 2, 5)).(0:9) == [
    [0, 0, 0, 0, 0],
    [1, 0, 0, 0, 0],
    [0, 1, 0, 0, 0],
    [1, 1, 0, 0, 0],
    [0, 0, 1, 0, 0],
    [1, 0, 1, 0, 0],
    [0, 1, 1, 0, 0],
    [1, 1, 1, 0, 0],
    [0, 0, 0, 1, 0],
    [1, 0, 0, 1, 0]
]
@test ((x) -> Hensel.hVector(x, 3, 5)).(0:9) == [
    [0, 0, 0, 0, 0],
    [1, 0, 0, 0, 0],
    [2, 0, 0, 0, 0],
    [0, 1, 0, 0, 0],
    [1, 1, 0, 0, 0],
    [2, 1, 0, 0, 0],
    [0, 2, 0, 0, 0],
    [1, 2, 0, 0, 0],
    [2, 2, 0, 0, 0],
    [0, 0, 1, 0, 0] 
]
@test ((x) -> Hensel.hVector(x, 7, 5)).(0:9) == [
    [0, 0, 0, 0, 0],
    [1, 0, 0, 0, 0],
    [2, 0, 0, 0, 0],
    [3, 0, 0, 0, 0],
    [4, 0, 0, 0, 0],
    [5, 0, 0, 0, 0],
    [6, 0, 0, 0, 0],
    [0, 1, 0, 0, 0],
    [1, 1, 0, 0, 0],
    [2, 1, 0, 0, 0]
]

@test ((x) -> Hensel.hVector(x, 2, 5)).([n/10.0 for n in 0:10]) == [
    [0, 0, 0, 0, 0],
    [0, 0, 0, 1, 1],
    [0, 0, 1, 1, 0],
    [0, 1, 0, 0, 1],
    [0, 1, 1, 0, 0],
    [1, 0, 0, 0, 0],
    [1, 0, 0, 1, 1],
    [1, 0, 1, 1, 0],
    [1, 1, 0, 0, 1],
    [1, 1, 1, 0, 0],
    [1, 1, 1, 1, 1]
]
@test ((x) -> Hensel.hVector(x, 3, 5)).([n/10.0 for n in 0:10]) == [
    [0, 0, 0, 0, 0],
    [0, 0, 2, 2, 0],
    [0, 1, 2, 1, 0],
    [0, 2, 2, 0, 0],
    [1, 0, 1, 2, 1],
    [1, 1, 1, 1, 1],
    [1, 2, 1, 0, 1],
    [2, 0, 0, 2, 2],
    [2, 1, 0, 1, 2],
    [2, 2, 0, 0, 2],
    [2, 2, 2, 2, 2]
]
@test ((x) -> Hensel.hVector(x, 7, 5)).([n/10.0 for n in 0:10]) == [
    [0, 0, 0, 0, 0],
    [0, 4, 6, 2, 0],
    [1, 2, 5, 4, 1],
    [2, 0, 4, 6, 2],
    [2, 5, 4, 1, 2],
    [3, 3, 3, 3, 3],
    [4, 1, 2, 5, 4],
    [4, 6, 2, 0, 4],
    [5, 4, 1, 2, 5],
    [6, 2, 0, 4, 6],
    [6, 6, 6, 6, 6]
]

@test ((x) -> Hensel.rValue(Hensel.hVector(x, 2, 5), 2)).(0:9) == [
    0.015625,
    0.515625,
    0.265625,
    0.765625,
    0.140625,
    0.640625,
    0.390625,
    0.890625,
    0.078125,
    0.578125
]
@test ((x) -> Hensel.rValue(Hensel.hVector(x, 3, 5), 5)).(0:9) == [
    0.00016,
    0.20015999999999998,
    0.40015999999999996,
    0.04016,
    0.24016,
    0.44016,
    0.08016,
    0.28016,
    0.48016,
    0.00816,
]
@test ((x) -> Hensel.rValue(Hensel.hVector(x, 7, 5), 7)).(0:9) == [
    2.9749509133099306e-5,
    0.14288689236627597,
    0.2857440352234188,
    0.4286011780805617,
    0.5714583209377045,
    0.7143154637948473,
    0.8571726066519902,
    0.02043791277443922,
    0.16329505563158206,
    0.30615219848872494
]

function hTest(x, p, sz)
    @test Hensel.hVector(Hensel.rValue(Hensel.hVector(x, p, sz), p), p, sz) == Hensel.hVector(x, p, sz)
end

hTest(0.5, 2, 3)
hTest(0.5, 3, 4)
hTest(0.009, 3, 14)
hTest(0.333, 3, 14)
hTest(0.999, 3, 14)

dist(x, p, sz) = abs(Hensel.rValue(Hensel.hVector(x, p, sz), p) - x)

function dTest(x, p, sz)
    dist(x, p, sz) <= 1/p^(sz)
end

dTest(0.5, 2, 3)
dTest(0.5, 3, 4)
dTest(0.009, 3, 14)
dTest(0.333, 3, 14)
dTest(0.999, 3, 14)

# -----------------------------------------------------------------
@test Hensel.FunEnv((x) -> x+1, (0, 1), 2, 5, (1, 2))(0.25) == 1.25
@test Hensel.to01(1.25, (1, 2)) == 0.25

@test Hensel.hVector(0.25, 2, 5) == [0,1,0,0,0]
@test Hensel.iValue(Hensel.hVector(0.25, 2, 5), 2) == 2
@test Hensel.rValue(2, 2, 5) == 0.265625
@test Hensel.rValue(2, 2, 5, (1, 2)) == 1.265625
@test Hensel.FunEnv((x) -> x+1, (0, 1), 2, 5, (1, 2))(2) == 2
@test Hensel.FunEnv((x) -> x+1, (0, 1), 2, 5, (1, 2))(2, return_type="hensel") == [0,1,0,0,0]
@test Hensel.FunEnv((x) -> x+1, (0, 1), 2, 5, (1, 2))(2, return_type="real") == 1.265625
@test Hensel.FunEnv((x) -> x+1, (0, 1), 2, 5, (1, 2)).(0:9) == 0:9
@test ((y) -> Hensel.FunEnv((x) -> x+1, (0, 1), 2, 5, (1, 2))(y, return_type="real")).(0:9) == [
    1.015625,
    1.515625,
    1.265625,
    1.765625,
    1.140625,
    1.640625,
    1.390625,
    1.890625,
    1.078125,
    1.578125, 
]

@test Hensel.hVector(0.25, 3, 5) == [0,2,0,2,0]
@test Hensel.iValue(Hensel.hVector(0.25, 3, 5), 3) == 60
@test Hensel.FunEnv((x) -> x+1, (0, 1), 3, 5, (1, 2))(60) == 60
@test Hensel.FunEnv((x) -> x+1, (0, 1), 3, 5, (1, 2))(60, return_type="hensel") == [0,2,0,2,0]
@test Hensel.FunEnv((x) -> x+1, (0, 1), 3, 5, (1, 2))(60, return_type="real") == 1.2489711934156378
@test Hensel.FunEnv((x) -> x+1, (0, 1), 3, 5, (1, 2)).(0:9) == 0:9
@test ((y) -> Hensel.FunEnv((x) -> x+1, (0, 1), 3, 5, (1, 2))(y, return_type="real")).(0:9) == [
    1.0020576131687242,
    1.3353909465020577,
    1.668724279835391,
    1.1131687242798354,
    1.4465020576131686,
    1.7798353909465021,
    1.2242798353909465,
    1.5576131687242798,
    1.8909465020576133,
    1.0390946502057614
]

@test Hensel.hVector(0.25, 7, 5) == [1,5,1,5,1]
@test Hensel.iValue(Hensel.hVector(0.25, 7, 5), 7) == 4201
@test Hensel.FunEnv((x) -> x+1, (0, 1), 7, 5, (1, 2))(4201) == 4201
@test Hensel.FunEnv((x) -> x+1, (0, 1), 7, 5, (1, 2))(4201, return_type="hensel") == [1,5,1,5,1]
@test Hensel.FunEnv((x) -> x+1, (0, 1), 7, 5, (1, 2))(4201, return_type="real") == 1.2499851252454335
@test Hensel.FunEnv((x) -> x+1, (0, 1), 7, 5, (1, 2)).(0:9) == 0:9
@test ((y) -> Hensel.FunEnv((x) -> x+1, (0, 1), 7, 5, (1, 2))(y, return_type="real")).(0:9) == [
    1.000029749509133,
    1.142886892366276,
    1.2857440352234188,
    1.4286011780805616,
    1.5714583209377047,
    1.7143154637948474,
    1.8571726066519902,
    1.0204379127744392,
    1.163295055631582,
    1.306152198488725
]

# -----------------------------------------------------------------
@test Hensel.FunEnv((x) -> 3*x+2, (0, 1), 2, 5, (2, 5))(0.25) == 2.75
@test Hensel.to01(2.75, (2, 5)) == 0.25

@test Hensel.hVector(0.25, 2, 5) == [0,1,0,0,0]
@test Hensel.iValue(Hensel.hVector(0.25, 2, 5), 2) == 2
@test Hensel.FunEnv((x) -> 3*x+2, (0, 1), 2, 5, (2, 5))(2) == 2
@test Hensel.FunEnv((x) -> 3*x+2, (0, 1), 2, 5, (2, 5))(2, return_type="hensel") == [0,1,0,0,0]
@test Hensel.FunEnv((x) -> 3*x+2, (0, 1), 2, 5, (2, 5))(2, return_type="real") == 2.796875
@test Hensel.FunEnv((x) -> 3*x+2, (0, 1), 2, 5, (2, 5)).(0:9) == 0:9

@test Hensel.hVector(0.25, 3, 5) == [0,2,0,2,0]
@test Hensel.iValue(Hensel.hVector(0.25, 3, 5), 3) == 60
@test Hensel.FunEnv((x) -> 3*x+2, (0, 1), 3, 5, (2, 5))(60) == 60
@test Hensel.FunEnv((x) -> 3*x+2, (0, 1), 3, 5, (2, 5))(60, return_type="hensel") == [0,2,0,2,0]
@test Hensel.FunEnv((x) -> 3*x+2, (0, 1), 3, 5, (2, 5))(60, return_type="real") == 2.746913580246914
@test Hensel.FunEnv((x) -> 3*x+2, (0, 1), 3, 5, (2, 5)).(0:9) == 0:9

@test Hensel.hVector(0.25, 7, 5) == [1,5,1,5,1]
@test Hensel.iValue(Hensel.hVector(0.25, 7, 5), 7) == 4201
@test Hensel.FunEnv((x) -> 3*x+2, (0, 1), 7, 5, (2, 5))(4201) == 4201
@test Hensel.FunEnv((x) -> 3*x+2, (0, 1), 7, 5, (2, 5))(4201, return_type="hensel") == [1,5,1,5,1]
@test Hensel.FunEnv((x) -> 3*x+2, (0, 1), 7, 5, (2, 5))(4201, return_type="real") == 2.7499553757363002
@test Hensel.FunEnv((x) -> 3*x+2, (0, 1), 7, 5, (2, 5)).(0:9) == 0:9

@test Hensel.FunEnv((x) -> 0.6*x*(1.0-x), (0.0, 1.0), 2, 8, (0.0, 1.0)).(0:10) == [
    0,
    100,
     56,
     56,
    136,
    196,
     36,
      8,
    144,
    164,
    132
]
@test Hensel.FunEnv((x) -> 0.6*x*(1-x), (0.0, 1.0), 2, 8, (0.0, 1.0))(0.5) == 0.15
@test Hensel.rValue(Hensel.hVector(100, 2, 8), 2) == 0.150390625

@test Hensel.logistic(Hensel.logistic(Hensel.logistic(0.3, 4.0), 4.0), 4.0) ==  Hensel.logistic(0.3,4.0,3)
@test Hensel.dyadic(Hensel.dyadic(Hensel.dyadic(0.3))) ==  Hensel.dyadic(0.3,3)
@test Hensel.nyadic(Hensel.nyadic(Hensel.nyadic(0.3, 5), 5), 5) ==  Hensel.nyadic(0.3,5,3)
@test Hensel.cfshift(Hensel.cfshift(Hensel.cfshift(0.3))) ==  Hensel.cfshift(0.3,3)


@test ((y) -> Hensel.FunEnv((x) -> Hensel.dyadic(0.35,y), (0, 1), 2, 8)(y, return_type="integer")).(0:10) == [
    154,
    205,
    102,
     51,
    153,
    204,
    102,
     51,
    153,
    204,
    102
]

@test ((y) -> Hensel.FunEnv((x) -> Hensel.nyadic(0.35,2,y), (0, 1), 2, 8)(y, return_type="integer")).(0:10) == [
    154,
    205,
    102,
     51,
    153,
    204,
    102,
     51,
    153,
    204,
    102
]

@test Hensel.FunEnv(Hensel.dyadic, (0, 1), 2, 8)(1,2,return_type="integer") == 64
@test Hensel.FunEnv(Hensel.dyadic, (0, 1), 2, 8)((1,2,"integer")) == 64
@test Hensel.FunEnv(Hensel.dyadic, (0, 1), 2, 8)((1,2)) == 64
@test Hensel.FunEnv(Hensel.dyadic, (0, 1), 2, 8).([(1,1),(1,2),(1,3)]) == [128, 64, 32]
@test Hensel.FunEnv(Hensel.dyadic, (0, 1), 2, 8).([(1,1,"hensel"),(1,2,"hensel"),(1,3,"hensel")]) == [
    [0, 0, 0, 0, 0, 0, 0, 1],
    [0, 0, 0, 0, 0, 0, 1, 0],
    [0, 0, 0, 0, 0, 1, 0, 0]    
]

# ----------------------------------------------------------------------