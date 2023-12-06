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

    seedIndex = 1
    ranges = []
    while seedIndex <= length(seeds)
        push!(ranges, [seeds[seedIndex], seeds[seedIndex] + seeds[seedIndex+1] - 1])
        seedIndex += 2
    end
    # println("initial ranges")
    # println(ranges)

    currentIndex = 3
    while currentIndex < length(inputArray)
    # while currentIndex < 27
        currentIndex += 1
        newDestinationRanges::Vector{Vector{Int}} = []
        for i in currentIndex:length(inputArray)
            currentIndex += 1
            line = inputArray[i]
            # println(line)
            if line == ""
                break
            end

            lineSplit = split(line, " ")
            destinationStart = parse(Int, lineSplit[1])
            sourceStart = parse(Int, lineSplit[2])
            range = parse(Int, lineSplit[3])
            sourceEnd = sourceStart + range - 1

            # println(ranges)
            newRanges = []
            for currentRange in ranges
                rangeStart = currentRange[1]
                rangeEnd = currentRange[2]

                # check if there is any overlap
                if (rangeStart >= sourceStart && rangeStart <= sourceEnd) ||
                   (rangeEnd >= sourceStart && rangeEnd <= sourceEnd)
                    # println("found overlap")

                    #how much is overlapping
                    overlapStart = max(rangeStart, sourceStart)
                    overlapEnd = min(rangeEnd, sourceEnd)
                    # println("overlap: $overlapStart-$overlapEnd")

                    # calculate destination and cache
                    difference = sourceStart - destinationStart
                    newDestinationStart = overlapStart - difference
                    newDestinationEnd = overlapEnd - difference
                    # println("new destination range: $newDestinationStart-$newDestinationEnd")
                    push!(newDestinationRanges, [newDestinationStart, newDestinationEnd])

                    #figure out what is left over
                    #beginning leftover
                    if overlapStart != rangeStart
                        push!(newRanges, [rangeStart, overlapStart - 1])
                        # println("have left over beginning: $rangeStart-$(overlapStart - 1)")
                    end
                    #end leftover
                    if overlapEnd != rangeEnd
                        push!(newRanges, [overlapEnd + 1, rangeEnd])
                        # println("have left over beginning: $rangeStart-$(overlapStart - 1)")
                    end
                else
                    push!(newRanges, [rangeStart, rangeEnd])
                end
            end
            ranges = newRanges
        end

        for i in newDestinationRanges
            push!(ranges, i)
        end

        # println(ranges)
        # println("current index: $currentIndex")
    end

    minLocation = missing
    for range in ranges
        if ismissing(minLocation)
            minLocation = range[1]
        elseif range[1] < minLocation
            minLocation = range[1]
        end
    end


    return minLocation
end

main()
