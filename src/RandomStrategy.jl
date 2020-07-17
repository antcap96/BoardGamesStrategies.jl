
struct RandomStrategy <: Strategy end

function BoardGames.getmove(board, s::RandomStrategy)
    rand(getmoves(board))
end
