
struct RandomStrategy{G <: Game} <: Strategy end

function BoardGames.getmove(board, s::RandomStrategy)
    rand(getmoves(board))
end

function BoardGames.getvarsnames(s::RandomStrategy)
    return String[]
end

function BoardGames.getvalues(s::RandomStrategy)
    return ()
end

BoardGames.name(::RandomStrategy) = "Random Selection"

function Base.copy(s::RandomStrategy)
    return s
end