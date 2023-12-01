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
        for i in 1:length(currentLine)
            c = currentLine[i]
            result = checkIfSpelledOutLetter(currentLine, i)
            if isdigit(c)
                currentNumber = string(currentNumber, c)
                break
            elseif result[1]
                currentNumber = string(result[2])
                break
            end
        end

        #last digit
        for i in reverse(1:length(currentLine))
            c = currentLine[i]
            result = checkIfSpelledOutLetter(currentLine, i)
            if isdigit(c)
                currentNumber = string(currentNumber, c)
                break
            elseif result[1]
                currentNumber = string(currentNumber, result[2])
                break
            end
        end

        total += parse(Int, currentNumber)
    end
    return total
end

function checkIfSpelledOutLetter(line, index)
    spelledOutArray = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    for i in 1:length(spelledOutArray)
        spelledOut = spelledOutArray[i]
        maxIndex = index + length(spelledOut) - 1
        if maxIndex > length(line)
            continue
        end
        test = SubString(line, index:maxIndex)
        if test == spelledOut
            return true, i
        end
    end
    return false, -1
end
println(solution(lineArray))
