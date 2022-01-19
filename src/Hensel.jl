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
Asserts: x ∈ [0,1], p > 1, sz > 0.
"
function hVector(x::Real, p::Integer, sz::Integer)::Vector{Integer}
    @assert(0.0 <= x <= 1.0)
    @assert(p > 1)
    @assert(sz > 0)
    if x == 1.0 
        return fill(p - 1, sz)
    end
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

"Calculates Hensel code vector back from its integer representation"
function hVector(n::Integer, p::Integer, sz::Integer)::Vector{Integer}
    h = Vector{Integer}(undef, sz)
    for i = 1 : sz
        h[i] = n % p
        n ÷= p
    end
    return h
end

"Calculates integer from Hensel code vector: Σv[i]*p^i"
iValue(v::Vector{<:Integer}, p::Integer)::Integer = 
    foldl((s,i) -> v[i]+s*p, length(v):-1:1, init = 0)

"Calculates integer from real number x∈[a,b]"
iValue(x::Number, ab::Tuple{<:Number, <:Number}, p::Integer, sz::Integer)::Integer = 
    iValue(hVector(x, ab, p, sz), p)

"Calculates real number x∈[0,1] from Hensel code vector: Σv[i]*p^(-i)/p"
rValue(v::Vector{<:Integer}, p::Integer)::Real = 
    foldl((s,i) -> v[i]+s/p, length(v):-1:1, init = p/2)/p

"Calculates real number x∈[0,1] from integer"
rValue(n::Integer, p::Integer, sz::Integer)::Real = rValue(hVector(n, p, sz), p)

"Calculates real number x∈[a,b] from integer"
rValue(n::Integer, p::Integer, sz::Integer, ab::Tuple{<:Number, <:Number})::Real = 
    from01(rValue(hVector(n, p, sz), p), ab)


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

"Call function real -> real as integer -> [integer | real | vector]"
function (s::FunEnv)(x::Integer; return_type="integer")
    if return_type == "integer"
        return iValue(s.f(rValue(x, s.ap, s.asz, s.arange)), s.vrange, s.vp, s.vsz)
    elseif return_type == "hensel"
        return hVector(s.f(rValue(x, s.ap, s.asz, s.arange)), s.vrange, s.vp, s.vsz)
    elseif return_type == "real"
        return s.f(rValue(x, s.ap, s.asz, s.arange))
    end
    throw(DomainError(return_type, "unknown keyword"))
end

"Logistic map function. For testing. 
See <a href=https://en.wikipedia.org/wiki/Logistic_map>Logistic map</a>"
logistic(x::Real, r::Real) = r*x*(1.0 - x)

logistic(x::Real, r::Real, n::Integer) = foldl((s,i) -> logistic(s,r), 1:(n-1), init = logistic(x,r))

end # module

# include("./src/Hensel.jl")
# or
# pkg> activate .
# and then
# using Hensel

