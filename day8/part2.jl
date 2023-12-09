function main()
    inputArray = parseInput()
    println(solution(inputArray))
end

function parseInput()
    inputArray = String[]
    open("$(dirname(@__FILE__))/input.txt") do file
        while !eof(file)
            line = readline(file)
            push!(inputArray, line)
        end
    end
    return inputArray
end

function solution(inputArray)
    sequence = inputArray[1]
    nodeDict = Dict()
    startingNodes = []

    # create map
    for i in 3:length(inputArray)
        line = inputArray[i]
        equalSplit = split(line, " = ")
        node = equalSplit[1]
        children = replace(equalSplit[2], "("=> "")
        children = replace(children, ")"=> "")
        childrenSplit = split(children, ", ")
        nodeDict[node] = childrenSplit

        if node[end] == 'A'
            push!(startingNodes, node)
        end
    end

    # startingNodes = [startingNodes[1]]

    loopIndexes = []
    zIndexes = []
    for node in startingNodes
        # println("evaluating node: $node")
        visited = Dict()
        sequenceIndex = 1
        count = 1

        destinationNode = missing
        while true
            direction = sequence[sequenceIndex]

            # handle loops
            if haskey(visited, [node, sequenceIndex])
                push!(loopIndexes, count)
                # println("found loop at count: $count")
                break
            end
            visited[[node, sequenceIndex]] = true

            # traverse tree
            children = nodeDict[node]
            if direction == 'L'
                destinationNode = children[1]
            else
                destinationNode = children[2]
            end

            if destinationNode[end] == 'Z'
                push!(zIndexes, count)
                # println("found Z at count: $count")
            end

            # increase count of everything
            count += 1
            sequenceIndex += 1
            if sequenceIndex > length(sequence)
                sequenceIndex = 1
            end

            # reset starting node
            node = destinationNode
        end


    end

    ## why does this work???
    return lcm(zIndexes...)


end

main()
