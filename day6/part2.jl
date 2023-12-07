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
    maxTime, targetDistance = createRace(inputArray)
    currentWins = 0

    for time in 1:maxTime-1
        distance = time * (maxTime - time)

        if distance > targetDistance
            currentWins += 1
        end
    end

    return currentWins
end

function createRace(inputArray)
    timeString = ""
    timeSplit = split(strip(split(inputArray[1], ":")[2]), " ")
    for currentTimeString in timeSplit
        if currentTimeString == ""
            continue
        end
        timeString *= currentTimeString
    end
    time = parse(Int, timeString)

    distanceString = ""
    distanceSplit = split(strip(split(inputArray[2], ":")[2]), " ")
    for currentDistanceString in distanceSplit
        if currentDistanceString == ""
            continue
        end
        distanceString *= currentDistanceString
    end
    distance = parse(Int, distanceString)

    return time, distance
end

main()
