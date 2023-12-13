function solution()
    file = open("input.txt", "r")
    fileString = read(file, String)
    close(file)

    lines = split(fileString, "\n")
    lines = lines[1:end-1]
    matrix::Matrix{String} = fill(".", length(lines), length(lines[1]))

    # create matrix
    for row in 1:length(lines)
        for col in 1:length(lines[1])
            char = lines[row][col]
            matrix[row, col] = "$char"
        end
    end

    # find all og galaxies
    oggalaxyIndexes = []
    for i in CartesianIndices(matrix)
        if matrix[i] == "#"
            push!(oggalaxyIndexes, i)
        end
    end

    emptyRows, emptyCols = findEmptyLines(matrix)

    expandFactor = 999999

    # calculate expanded galaxy indexes
    calculatedExpandedGalaxies = []
    for i in oggalaxyIndexes
        rowMultiplier = 0
        for emptyRow in emptyRows
            if emptyRow < i[1]
                rowMultiplier += 1
            else
                break
            end
        end
        colMultiplier = 0
        for emptyCol in emptyCols
            if emptyCol < i[2]
                colMultiplier += 1
            else
                break
            end
        end
        expandedRow = i[1] + rowMultiplier * expandFactor
        expandedCol = i[2] + colMultiplier * expandFactor
        push!(calculatedExpandedGalaxies, [expandedRow, expandedCol])
    end

    sum = 0
    visited = Dict()
    for currentIndex in calculatedExpandedGalaxies
        for indexToMeasure in calculatedExpandedGalaxies
            if currentIndex == indexToMeasure
                continue
            end
            visitedCheck = [currentIndex, indexToMeasure]
            visitedCheck = sort!(visitedCheck)
            if haskey(visited, visitedCheck)
                continue
            else
                visited[visitedCheck] = true
            end
            add = abs(currentIndex[1] - indexToMeasure[1]) + abs(currentIndex[2] - indexToMeasure[2])
            sum += add
        end
    end
    println(sum)

end

function findEmptyLines(matrix)
    # find empty lines
    index = 1
    emptyRows = []
    for row in eachrow(matrix)
        if row == fill(".", size(matrix, 1))
            push!(emptyRows, index)
        end
        index += 1
    end
    index = 1
    emptyCols = []
    for col in eachcol(matrix)
        if col == fill(".", size(matrix, 2))
            push!(emptyCols, index)
        end
        index += 1
    end
    return emptyRows, emptyCols
end

solution()
