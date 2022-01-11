"Collection of functions for mapping Number numbers to Hensel code."
module Hensel
export pIndex, hVector

"Linear mapping x from [a,b] to y ∈ [0,1]. x ∈ [a,b]."
to01(x::Number, a::Number, b::Number)::Number             = (x-a)/(b-a)
to01(x::Number, (a,b)::Tuple{<:Number, <:Number})::Number = (x-a)/(b-a)

"Linear mapping x ∈ [0,1] to y ∈ [a,b]. x ∈ [0,1]."
from01(x::Number, a::Number, b::Number)::Number              = x*(b-a)+a
from01(x::Number, (a, b)::Tuple{<:Number, <:Number})::Number = x*(b-a)+a

"
Suppose [0,1] is diveded into p equal length intervals. Function retuns index
of the interval to which x belongs to. Indexation starts from 0 (zero).
x ∈ [0,1].
"
pIndex(x::Number, p::Integer)::Integer = floor(Int, x*p)

"
Caclulates Hensel code as integer vector. p is a base, sz - precision.
Asserts: x ∈ [0,1], p > 0, sz > 0.
"
function hVector(x::Number, p::Integer, sz::Integer)::Vector{Integer}
    @assert(0 <= x <= 1)
    @assert(p > 0)
    @assert(sz > 0)
    h = Vector{Integer}(undef, sz)
    for i = 1 : sz
        n = pIndex(x, p)
        x = to01(x, n/p, (n+1)/p)
        h[i] = n
    end
    return h
end

"
Caclulates Hensel code as integer vector. p is a base, sz - precision.
Asserts: x ∈ [a,b], p > 0, sz > 0.
"
function hVector(x::Number, a::Number, b::Number, p::Integer, sz::Integer)::Vector{Integer}
    @assert(a <= x <= b)
    return hVector(to01(x, a, b), p, sz)
end
hVector(x::Number, (a, b)::Tuple{<:Real, <:Real}, p::Integer, sz::Integer)::Vector{Integer} = 
    hVector(x, a, b, p, sz)

"Calculates integer from Hensel code vector: Σv[i]*p^i"
iValue(v::Vector{<:Integer}, p::Integer)::Integer = 
    foldl((s,i) -> v[i]+s*p, length(v):-1:1, init = 0)

"Calculates Hensel code vector back from its integer representation"
function iValue(n::Integer, p::Integer, sz::Integer)::Vector{Integer}
    h = Vector{Integer}(undef, sz)
    for i = 1 : sz
        h[i] = n % p
        n ÷= p
    end
    return h
end

"Calculates integer from real number x∈[a,b]"
iValue(x::Number, p::Integer, sz::Integer, ab::Tuple{<:Number, <:Number})::Integer = 
    iValue(hVector(x, ab, p, sz), p)

"Calculates real number x∈[0,1] from Hensel code vector: Σv[i]*p^(-i)/p"
rValue(v::Vector{<:Integer}, p::Integer)::Real = 
    foldl((s,i) -> v[i]+s/p, length(v):-1:1, init = p/2)/p

"Calculates real number x∈[0,1] from integer"
rValue(n::Integer, p::Integer, sz::Integer)::Real = rValue(iValue(n, p, sz), p)

"Calculates real number x∈[a,b] from integer"
rValue(n::Integer, p::Integer, sz::Integer, ab::Tuple{<:Number, <:Number})::Real = 
    from01(rValue(iValue(n, p, sz), p), ab)


"Envilope for calculating functions real -> real as integer -> integer"
struct FunEnv{T1<:Number, T2<:Number}
    f::Function                # function
    arange::Tuple{T1, T1}      # argument range
    ap::Integer                # argument base
    asz::Integer               # argument precision 
    vrange::Tuple{T2, T2}      # function value range
    vp::Integer                # value base
    vsz::Integer               # value precision 
end
FunEnv(f, arange, ap, asz, vrange) = FunEnv(f, arange, ap, asz, vrange, ap, asz)
FunEnv(f, arange, ap, asz) = FunEnv(f, arange, ap, asz, arange)

"Direct call to the function"
(s::FunEnv)(x::Real) = s.f(x)

"Call function real -> real as integer -> integer"
(s::FunEnv)(x::Integer) = 
    iValue(s.f(rValue(x, s.ap, s.asz, s.arange)), s.vp, s.vsz, s.vrange)

# end

end # module

# include("./src/Hensel.jl")
# or
# pkg> activate .
# and then
# using Mahler

