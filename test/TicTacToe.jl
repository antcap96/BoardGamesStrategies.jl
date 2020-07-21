using BoardGames

struct TicTacToeBoard
    v::Vector{Int}
    turn::Int
    winner::Int
end

struct TicTacToe <: Game{TicTacToeBoard, Int} end

function TicTacToeBoard()
    v = zeros(Int, (9))
    turn = 1
    winner = 0

    TicTacToeBoard(v, turn, winner)
end

function BoardGames.getmoves(board::TicTacToeBoard)
    if board.winner == 0
        (1:9)[board.v .== 0]
    else
        return Int[]
    end
end

function Base.copy(board::TicTacToeBoard)
    TicTacToeBoard(copy(board.v), board.turn, board.winner)
end

const lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

function BoardGames.play(board::TicTacToeBoard, move::Int)
    v = copy(board.v)
    v[move] = board.turn
    turn = -board.turn

    winner = 0
    for l in lines
        if all(v[l] .== board.turn)
            winner = board.turn
        end
    end

    TicTacToeBoard(v, turn, winner)
end

function BoardGames.playerturn(board::TicTacToeBoard)
    if board.turn == 1
        return 1
    else
        return 2
    end
end

function BoardGames.winner(board::TicTacToeBoard)
    return board.winner == -1 ? 2 : board.winner
end
