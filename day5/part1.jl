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
    seeds::Vector{Int} = Int[]

    splitSeeds = split(inputArray[1], ":")
    for seed in split(strip(splitSeeds[2]))
        push!(seeds, parse(Int, seed))
    end
    minLocation = missing

    for seed in seeds
        currentNumber = seed
        currentIndex = 3
        while currentIndex < length(inputArray)
            currentIndex += 1
            match = false
            for i in currentIndex:length(inputArray)
                currentIndex += 1
                line = inputArray[i]
                if line == ""
                    break
                end

                lineSplit = split(line, " ")
                destinationStart = parse(Int, lineSplit[1])
                sourceStart = parse(Int, lineSplit[2])
                range = parse(Int, lineSplit[3])

                if currentNumber >= sourceStart && currentNumber <= sourceStart + range - 1 && !match
                    difference = currentNumber - sourceStart
                    currentNumber = destinationStart + difference
                    match = true
                end
            end
        end

        if ismissing(minLocation)
            minLocation = currentNumber
        elseif currentNumber < minLocation
            minLocation = currentNumber
        end
    end

    return minLocation
end

main()
