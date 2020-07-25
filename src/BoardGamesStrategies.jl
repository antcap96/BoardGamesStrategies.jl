module BoardGamesStrategies

using BoardGames

# Write your package code here.

export
    # Types
    RandomStrategy,
    MCTSStrategy,
    Minimax,
    MinimaxAlphaBeta

include("RandomStrategy.jl")
include("MCTSStrategy.jl")
include("Minimax.jl")
include("MinimaxAlphaBeta.jl")

end
