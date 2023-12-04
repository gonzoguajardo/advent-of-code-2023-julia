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
    totalScore = 0
    for line in inputArray
        splitColon = split(line, ":")
        numbers = splitColon[2]
        splitPipe = split(numbers, "|")
        numberDict = Dict{String, Bool}()

        # process first set
        splitNumbers = split(strip(splitPipe[1]), " ")
        for number in splitNumbers
            if number == ""
                continue
            end
            numberDict[number] = true
        end

        currentScore = 0
        # process second set
        splitNumbers = split(strip(splitPipe[2]), " ")
        for number in splitNumbers
            if number == ""
                continue
            end
            if haskey(numberDict, number)
                if currentScore == 0
                    currentScore = 1
                else
                    currentScore *= 2
                end
            end
        end

        totalScore += currentScore
    end
    return totalScore
end

main()
