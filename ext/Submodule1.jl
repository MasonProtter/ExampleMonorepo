module Submodule1

using ExampleMonorepo: Foo
using PrecompileTools

struct Bar
    f::Foo{Int}
end

export Bar

end
