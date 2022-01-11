# ----------------------------------------------------------------------

# ----------------------------------------------------------------------
using Test
using Hensel
include("../src/Hensel.jl")

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

@test Hensel.iValue(3, 2, 3) == [1, 1, 0]
@test Hensel.iValue(5, 2, 3) == [1, 0, 1]
@test Hensel.iValue(7, 2, 3) == [1, 1, 1]

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


@test Hensel.Hensel.FunEnv((x) -> x+1, (0, 1), 2, 5, (1, 2)).(0.5) == 1.5
# ----------------------------------------------------------------------