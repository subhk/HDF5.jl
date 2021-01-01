using Documenter
using HDF5
using MPI  # needed to generate docs for parallel HDF5 API

# Used in index.md to filter the autodocs list
wherefrom(m::Method) = String(m.file)
not_from_api(m::Method) = !endswith(wherefrom(m), "src/api.jl")
not_from_api(f::Function) = all(not_from_api, methods(f))
not_from_api(o) = true
# Manually-defined low-level API
not_from_api(::typeof(HDF5.h5p_get_class_name)) = false
not_from_api(::typeof(HDF5.h5t_get_member_name)) = false
not_from_api(::typeof(HDF5.h5t_get_tag)) = false

makedocs(;
    modules=[HDF5],
    authors="Mustafa Mohamad <mus-m@outlook.com> and contributors",
    repo="https://github.com/JuliaIO/HDF5.jl/blob/{commit}{path}#L{line}",
    sitename="HDF5.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://JuliaIO.github.io/HDF5.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Low-level library bindings" => "api_bindings.md",
    ],
)

deploydocs(;
    repo="github.com/JuliaIO/HDF5.jl.git",
    push_preview=true,
)
