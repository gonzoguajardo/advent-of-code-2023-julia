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
    timeArray, distanceArray = createArrays(inputArray)
    # println(timeArray)
    # println(distanceArray)

    numberOfWins::Vector{Int} = []
    for i in 1:length(timeArray)
        maxTime = timeArray[i]
        targetDistance = distanceArray[i]

        currentWins = 0
        for time in 1:maxTime - 1
            distance = time * (maxTime - time)

            # println("$time milliseconds")
            # println("$distance millimeters")
            # println("")

            if distance > targetDistance
                currentWins += 1
            end
        end
        push!(numberOfWins, currentWins)
    end

    return reduce(multiply, numberOfWins)
end

function multiply(a, b)
    return a * b
end

function createArrays(inputArray)
    time::Vector{Int} = []
    distance::Vector{Int} = []

    timeSplit = split(strip(split(inputArray[1], ":")[2]), " ")
    for currentTimeString in timeSplit
        if currentTimeString == ""
            continue
        end
        currentTime = parse(Int, currentTimeString)
        push!(time, currentTime)
    end

    distanceSplit = split(strip(split(inputArray[2], ":")[2]), " ")
    for currentDistanceString in distanceSplit
        if currentDistanceString == ""
            continue
        end
        currentDistance = parse(Int, currentDistanceString)
        push!(distance, currentDistance)
    end

    return time, distance
end

main()
