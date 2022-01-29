#--------------------------------------------------------------------------------------------------
using Test

#--------------------------------------------------------------------------------------------------

@testset "Hensel" begin
    @testset "Linear mapping tests" begin
        include("linear_mapping_tests.jl")
    end
    @testset "Functions on [a,b] tests" begin
        include("functions_on_ab_tests.jl")
    end
    @testset "Functions on [0,1] tests" begin
        include("functions_on_01_tests.jl")
    end
    @testset "LinMap tests" begin
        include("LinMap_tests.jl")
    end
    @testset "FunEnv tests" begin
        include("FunEnv_tests.jl")
    end
    @testset "Additional functions tests" begin
        include("additional_functions_tests.jl")
    end
end

#--------------------------------------------------------------------------------------------------
