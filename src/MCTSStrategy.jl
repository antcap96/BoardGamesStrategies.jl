using BoardGames

mutable struct TreeNode{Board}
    board::Board

    n::Float64
    w::Float64

    expanded::Bool
    children::Vector{TreeNode{Board}}
    parent::TreeNode{Board}


    function TreeNode(board::Board) where {Board}
        new{Board}(board, 0, 0, false, TreeNode{Board}[])
     end
end

function TreeNode(board::B, parent::TreeNode{B}) where {B}
    tn = TreeNode(board)
    tn.parent = parent
    return tn
end

struct MCTSTree{Board}
    root::TreeNode{Board}
end

MCTSTree(board::Board) where {Board} = MCTSTree(TreeNode(board))

struct MCTSStrategy{G <: Game} <: Strategy
    nsteps::Int
    c::Float64
end

function MCTSStrategy{G}(nsteps::Int) where {G <: Game}
    MCTSStrategy{G}(nsteps, √2)
end

function BoardGames.getmove(board, s::MCTSStrategy; verbose=false)
    tree = MCTSTree(board)
    player = playerturn(board)

    for i in 1:s.nsteps
        step(tree.root, player, s.c)
    end
    if verbose
        results = [(m, c.w, c.n) for (m,c) in zip(getmoves(board), tree.root.children)]
        @show results
    end
    move_idx = select(tree.root, player, 0)

    verbose && println("selected $move_idx")

    getmoves(board)[move_idx]
end

function expand(node::TreeNode)
    moves = getmoves(node.board)

    for move in moves
        push!(node.children, TreeNode(play(node.board, move), node))
    end
    node.expanded = true
    nothing
end

function select(node::TreeNode, player::Int, c=√2)
    params = zeros(Float64, size(node.children))

    for (i,child) in enumerate(node.children)
        if child.n == 0
            params[i] = Inf
        else
            if player == playerturn(node.board)
                params[i] =  child.w / child.n + c*sqrt(log(node.n)/child.n)
            else
                params[i] = -child.w / child.n + c*sqrt(log(node.n)/child.n)
            end
        end
    end
    return random_argmax(params)
end

function backpropagate(node::TreeNode, w::Float64)
    while(isdefined(node, :parent))
        node.w += w
        node.n += 1
        node = node.parent
    end
    node.w += w
    node.n += 1
    nothing
end

function step(node::TreeNode, player::Int, c::Float64)
    if !node.expanded
        expand(node)
    end
    if isempty(node.children)
        w = 0.
        if winner(node.board) == 0
            w = .5
        else
            w = Float64(winner(node.board) == player)
        end
        backpropagate(node, w)
    else
        i = select(node, player, c)
        step(node.children[i], player, c)
    end
    nothing
end

function random_argmax(v)
    @assert(length(v) > 0)
    best = v[1]
    best_idx = 1
    best_count = 1

    for i in 2:length(v)
        if v[i] > best
            best = v[i]
            best_idx = i
            best_count = 1
        elseif v[i] == best
            best_count += 1
            if rand() < 1/best_count
                best_idx = i
            end
        end
    end
    return best_idx
end
