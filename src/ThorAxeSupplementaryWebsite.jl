module ThorAxeSupplementaryWebsite

using Logging, LoggingExtras

function main()
  Base.eval(Main, :(const UserApp = ThorAxeSupplementaryWebsite))

  include(joinpath("..", "genie.jl"))

  Base.eval(Main, :(const Genie = ThorAxeSupplementaryWebsite.Genie))
  Base.eval(Main, :(using Genie))
end; main()

end
