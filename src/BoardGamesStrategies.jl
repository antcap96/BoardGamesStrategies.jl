module BoardGamesStrategies

using BoardGames

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
