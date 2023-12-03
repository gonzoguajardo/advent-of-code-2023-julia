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
        validCardAmounts = true
        for game in splitGames
            cardAmounts = split(game, ",")
            for cardAmount in cardAmounts
                cardAmount = strip(cardAmount)
                cardSplit = split(cardAmount, " ")
                number::Int = parse(Int, cardSplit[1])
                color = cardSplit[2]
                if color == "blue" && number > 14
                    validCardAmounts = false
                    break
                elseif color == "red" && number > 12
                    validCardAmounts = false
                    break
                elseif color == "green" && number > 13
                    validCardAmounts = false
                    break
                end
            end
            if !validCardAmounts
                break
            end
        end
        if validCardAmounts
            sum += i
        end
    end
    return sum
end
println(solution(lineArray))
