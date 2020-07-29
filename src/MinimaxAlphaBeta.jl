struct MinimaxAlphaBeta{G <: Game, H} <: Strategy
    depth::Int
    heuristic::H
end

function BoardGames.getmove(board, s::MinimaxAlphaBeta; verbose=false)
    @assert !isempty(getmoves(board))
    move, score = expand(board, s, playerturn(board), s.depth, -Inf, Inf)
    verbose && println(score)

    return getmoves(board)[move]
end

function expand(board, s::MinimaxAlphaBeta, player::Int, depth::Int, α::Float64, β::Float64)
    @assert depth >= 0
    moves = getmoves(board)

    maximize = player == playerturn(board)
    best_move = 0
    if maximize
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

            move, score = expand(next_board, s, player, depth-1, α, β)
            if (score > best_score && maximize) ||
               (score < best_score && maximize)
                best_move = i
                best_score = score
                if maximize
                    α = max(α, best_score)
                    if α >= β
                        break
                    end
                else
                    β = min(β, best_score)
                    if β <= α
                        break
                    end
                end
            end
        end
    end
    return (best_move, best_score)
end
