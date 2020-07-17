
struct RandomStrategy <: Strategy end

function getmove(board, s::RandomStrategy)
    rand(getmoves(board))
end