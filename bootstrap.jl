  cd(@__DIR__)
  import Pkg
  Pkg.activate(".")

  function main()
    include(joinpath("src", "ThorAxeSupplementaryWebsite.jl"))
  end; main()
