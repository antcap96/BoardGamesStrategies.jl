using BoardGamesStrategies
using Test

include("TicTacToe.jl")

b = playgame(TicTacToeBoard(), MCTSStrategy{TicTacToe}(1000, √2), MCTSStrategy{TicTacToe}(1000, √2));

b = TicTacToeBoard()
b = play(b, 1)
b = play(b, 2)

@testset "BoardGamesStrategies.jl" begin
    #a bit random but player 1 should win
    @test winner(playgame(b, MCTSStrategy{TicTacToe}(10000, √2),
                             MCTSStrategy{TicTacToe}(10000, √2))) == 1
end
