This is a test repo for trying out the idea of being able to `using` package extensions, essentially as optionally loaded submodules.

``` julia
❯ julia --project -q
julia> using ExampleMonorepo

julia> names(ExampleMonorepo)
3-element Vector{Symbol}:
 Symbol("@using")
 :ExampleMonorepo
 :Foo
 
julia> Submodule1
ERROR: UndefVarError: `Submodule1` not defined in `Main`
Suggestion: check for spelling errors or missing imports.

``` 
```julia
julia> ExampleMonorepo.@using Submodule1
[ Info: Precompiling Submodule1 [84d07829-0b5c-5d43-bb2b-2750b0c51663]

julia> names(Submodule1)
2-element Vector{Symbol}:
 :Bar
 :Submodule1

julia> Bar(Foo(1))
Bar(Foo{Int64}(1))
```

The struct `Bar` came from the `[extension]` `Submodule1`, and it was only loaded when we did `ExampleMonorepo.@using Submodule1`. 

``` julia
julia> methods(Bar)
# 2 methods for type constructor:
 [1] Bar(f::Foo{Int64})
     @ ~/ExampleMonorepo/ext/Submodule1.jl:7
 [2] Bar(f)
     @ ~/ExampleMonorepo/ext/Submodule1.jl:7
```

This is done using a rather cursed mechanism, but might be a useful experiment.
