using BoardGamesStrategies
using Test

include("TicTacToe.jl")

b = playgame(TicTacToeBoard(), MCTSStrategy{TicTacToe}(1000, √2), MCTSStrategy{TicTacToe}(1000, √2));

b = TicTacToeBoard()
b = play(b, 1)
b = play(b, 2)

function heuristic(b::TicTacToeBoard, player::Int64)
    b.winner * -((player - 2) * 2 + 1)
end

@testset "BoardGamesStrategies.jl" begin
    #a bit random but player 1 should win
    @test 0 <= winner(playgame(b, RandomStrategy{TicTacToe}(), 
                                  RandomStrategy{TicTacToe}())) <= 2

    @test winner(playgame(b, MCTSStrategy{TicTacToe}(10000, √2),
                             MCTSStrategy{TicTacToe}(10000, √2))) == 1

    @test winner(playgame(b, Minimax{TicTacToe}(10,heuristic),
                             Minimax{TicTacToe}(10,heuristic))) == 1

    @test winner(playgame(b, MinimaxAlphaBeta{TicTacToe}(10, heuristic),
                             MinimaxAlphaBeta{TicTacToe}(10, heuristic))) == 1

end
