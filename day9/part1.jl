function main()
    inputArray = parseInput()
    println(solution(inputArray))
end

function parseInput()
    inputArray = []
    open("$(dirname(@__FILE__))/input.txt") do file
        while !eof(file)
            line = readline(file)
            splitLine = split(line, " ")
            currentLine = Int[]
            for i in splitLine
                push!(currentLine, parse(Int, i))
            end
            push!(inputArray, currentLine)
        end
    end
    return inputArray
end

function solution(inputArray)
    total = 0
    for line in inputArray
        currentLine = line
        allDifferences = []
        push!(allDifferences, line)
        while true
            differences = Int[]
            valid = true
            for i in 2:length(currentLine)
                number = currentLine[i] - currentLine[i-1]
                push!(differences, number)
                if valid && number != 0
                    valid = false
                end
            end

            currentLine = differences
            push!(allDifferences, differences)

            if valid
                break
            end
        end

        for i in reverse(2:length(allDifferences))
            newNumber = allDifferences[i][end] + allDifferences[i-1][end]
            push!(allDifferences[i-1], newNumber)
        end
        # println(allDifferences[1][end])
        total += allDifferences[1][end]
    end
    return total
end

main()
