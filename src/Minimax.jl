struct Minimax{G <: Game, H} <: Strategy
    depth::Int
    heuristic::H
end

Minimax{G}(depth::Int, heuristic::H) where {G<:Game, H} = Minimax{G,H}(depth, heuristic)

function BoardGames.getmove(board, s::Minimax; verbose=false)
    @assert !isempty(getmoves(board))
    move, score = expand(board, s, playerturn(board), s.depth)
    verbose && println(score)

    return getmoves(board)[move]
end

function expand(board, s::Minimax, player::Int, depth::Int)
    @assert depth >= 0
    moves = getmoves(board)

    best_move = 0
    if player == playerturn(board)
        best_score = -Inf
    else
        best_score = Inf
    end

    if isempty(moves) || depth == 0
        best_move = 0
        best_score = s.heuristic(board, player)
    else
        for i in 1:length(moves)
            next_board = play(board, moves[i])

            move, score = expand(next_board, s, player, depth-1)
            if (score > best_score && player == playerturn(board)) ||
               (score < best_score && player != playerturn(board))
                best_move = i
                best_score = score
            end
        end
    end
    return (best_move, best_score)
end
