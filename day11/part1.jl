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

    emptyRows, emptyCols = findEmptyLines(matrix)
    matrix = expand(matrix, emptyRows, emptyCols)

    # find all galaxies
    galaxyIndexes = []
    for i in CartesianIndices(matrix)
        if matrix[i] == "#"
            push!(galaxyIndexes, i)
        end
    end

    sum = 0
    visited = Dict()
    for currentIndex in galaxyIndexes
        for indexToMeasure in galaxyIndexes
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

function expand(matrix, emptyRows, emptyCols)
    # Expand
    count = 0
    for i in emptyRows
        indexToAdd = i + count
        matrix = vcat(matrix[1:indexToAdd, :], fill(".", 1, size(matrix,2)), matrix[indexToAdd+1:end, :])
        count += 1
    end
    count = 0
    for i in emptyCols
        indexToAdd = i + count
        matrix = hcat(matrix[:, 1:indexToAdd], fill(".", size(matrix, 1), 1), matrix[:, indexToAdd + 1 : end])
        count += 1
    end
    return matrix
end

function print(matrix)
    for row in eachrow(matrix)
        println(row)
    end
end

solution()
