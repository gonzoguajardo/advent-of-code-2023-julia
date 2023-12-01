lineArray = String[]
# read file into array
open("/Users/gonzo/workspace/projects/advent-of-code-2023-julia/day1/input.txt") do f
    while !eof(f)
        s = readline(f)

        push!(lineArray, s)
    end
end

function solution(lineArray)
    total = 0
    for currentLine in lineArray
        currentNumber = ""

        #first digit
        for c in currentLine
            if isdigit(c)
                currentNumber = string(currentNumber, c)
                break
            end
        end

        #last digit
        for i in reverse(1:length(currentLine))
            c = currentLine[i]
            if isdigit(c)
                currentNumber = string(currentNumber, c)
                break
            end
        end

        total += parse(Int, currentNumber)
    end
    return total
end
println(solution(lineArray))
