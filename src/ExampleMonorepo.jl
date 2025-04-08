module ExampleMonorepo

struct Foo{T}
    x::T
end
export Foo, @using_Submodule1



using UUIDs
function inject_extension(uuid, stub_name, ext_name)
    ext1_uuid = UUID(uuid)
    stub_id = Base.PkgId(ext1_uuid, stub_name)
    @lock Base.require_lock Base.run_extension_callbacks(stub_id)
    Base.get_extension(ExampleMonorepo, ext_name)
end
macro using_Submodule1()
    ext = inject_extension("e7278e9f-96f8-4b00-8276-224ecdc3ad49", "Stub1", :Submodule1)
    @gensym submod
    esc(quote
            $submod = $ext
            using .$submod
        end)
end

end # module ExampleMonorepo
