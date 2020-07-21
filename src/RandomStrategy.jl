
struct RandomStrategy{G <: Game} <: Strategy end

function BoardGames.getmove(board, s::RandomStrategy)
    rand(getmoves(board))
end
