function main()
    inputArray = parseInput()
    println("working")
    println(solution(inputArray))
    println("done")
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
    gameNumberOfMatchesDict = Dict{Int,Int}()
    for line in inputArray
        splitColon = split(line, ":")

        splitGameNumber = split(splitColon[1], " ")
        gameNumber::Int = parse(Int, splitGameNumber[end])
        numbers = splitColon[2]
        splitPipe = split(numbers, "|")
        numberDict = Dict{String,Bool}()

        # process first set
        splitNumbers = split(strip(splitPipe[1]), " ")
        for number in splitNumbers
            if number == ""
                continue
            end
            numberDict[number] = true
        end

        # process second set
        numberOfMatches = 0
        splitNumbers = split(strip(splitPipe[2]), " ")
        for number in splitNumbers
            if number == ""
                continue
            end
            if haskey(numberDict, number)
                numberOfMatches += 1
            end
        end

        # cache number of matches
        gameNumberOfMatchesDict[gameNumber] = numberOfMatches
    end

    # work through additional tickets starting from the end
    additionalTicketsDict = Dict{Int,Int}()
    for i in reverse(1:length(inputArray))
        numberOfMatches = gameNumberOfMatchesDict[i]
        if numberOfMatches == 0
            additionalTicketsDict[i] = 0
        else
            numberOfAdditionalCards = numberOfMatches
            for additional in i+1:i + numberOfMatches
                numberOfAdditionalCards += additionalTicketsDict[additional]
            end
            additionalTicketsDict[i] = numberOfAdditionalCards
        end
    end

    totalCountOfTickets = length(inputArray)
    for i in 1:length(inputArray)
        totalCountOfTickets += additionalTicketsDict[i]
    end
    return totalCountOfTickets
end

main()
