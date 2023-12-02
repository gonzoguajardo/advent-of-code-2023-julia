lineArray = String[]
# read file into array
open("/Users/gonzo/workspace/projects/advent-of-code-2023-julia/day2/input.txt") do f
    while !eof(f)
        s = readline(f)

        push!(lineArray, s)
    end
end

function solution(lineArray)
    sum = 0
    for i in 1:length(lineArray)
        line = lineArray[i]
        linesplit = split(line, ":")
        games = linesplit[2]
        splitGames = split(games, ";")
        maxColorBlockDict = Dict()
        for game in splitGames
            cardAmounts = split(game, ",")
            for cardAmount in cardAmounts
                cardAmount = strip(cardAmount)
                cardSplit = split(cardAmount, " ")
                number::Int = parse(Int, cardSplit[1])
                color = cardSplit[2]
                if haskey(maxColorBlockDict, color)
                    if number > maxColorBlockDict[color]
                        maxColorBlockDict[color] = number
                    end
                else
                    maxColorBlockDict[color] = number
                end
            end
        end

        currentSum = 1
        for key in keys(maxColorBlockDict)
            currentSum *= maxColorBlockDict[key]
        end
        sum += currentSum
    end
    return sum
end
println(solution(lineArray))
