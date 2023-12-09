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

    # create map
    for i in 3:length(inputArray)
        line = inputArray[i]
        equalSplit = split(line, " = ")
        node = equalSplit[1]
        children = replace(equalSplit[2], "("=> "")
        children = replace(children, ")"=> "")
        childrenSplit = split(children, ", ")
        nodeDict[node] = childrenSplit
    end

    currentNode = "AAA"
    sequenceIndex = 1
    count = 0
    while true
        direction = sequence[sequenceIndex]
        children = nodeDict[currentNode]

        if direction == 'L'
            currentNode = children[1]
        else
            currentNode = children[2]
        end

        count += 1
        sequenceIndex += 1

        if currentNode == "ZZZ"
            break
        end

        if sequenceIndex > length(sequence)
            sequenceIndex = 1
        end
    end
    return count
end

main()
