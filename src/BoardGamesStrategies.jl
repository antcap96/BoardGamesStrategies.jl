module BoardGamesStrategies

using BoardGames

# Write your package code here.

export
    # Types
    RandomStrategy,
    MCTSStrategy

include("RandomStrategy.jl")
include("MCTSStrategy.jl")

end
