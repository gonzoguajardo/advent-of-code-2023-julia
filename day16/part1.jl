function solution()
    file = open("input.txt", "r")
    fileString = read(file, String)
    close(file)

    lines = split(fileString, "\n")[begin:(end-1)]
    contraption = fill("", length(lines), length(lines[1]))
    visitedMatrix = fill(".", length(lines), length(lines[1]))
    for i in 1:length(lines)
        line = lines[i]
        for j in 1:length(line)
            char = line[j]
            contraption[i, j] = "$char"
        end
    end

    visited = Dict()
    progress(1, 1, 0, contraption, visited, visitedMatrix)

    count = 0
    for value in visitedMatrix
        if value == "#"
            count += 1
        end
    end
    println(count)
end

function progress(row, col, direction, contraption, visited, visitedMatrix)

    if !checkbounds(Bool, contraption, row, col)
        return
    end

    if haskey(visited, [row, col, direction])
        return
    else
        visitedMatrix[row, col] = "#"
        visited[[row, col, direction]] = true
    end

    current = contraption[row, col]

    if current == "."
        # right
        if direction == 0
            progress(row, col + 1, direction, contraption, visited, visitedMatrix)
            return
        elseif direction == 1
            progress(row + 1, col, direction, contraption, visited, visitedMatrix)
            return
        elseif direction == 2
            progress(row, col - 1, direction, contraption, visited, visitedMatrix)
            return
        elseif direction == 3
            progress(row - 1, col, direction, contraption, visited, visitedMatrix)
            return
        else
            return
        end
    elseif current == "|"
        if direction == 0 || direction == 2
            progress(row - 1, col, 3, contraption, visited, visitedMatrix)
            progress(row + 1, col, 1, contraption, visited, visitedMatrix)
            return
        elseif direction == 1
            progress(row + 1, col, 1, contraption, visited, visitedMatrix)
            return
        elseif direction == 3
            progress(row - 1, col, 3, contraption, visited, visitedMatrix)
            return
        else
            return
        end
    elseif current == "-"
        if direction == 1 || direction == 3
            progress(row, col + 1, 0, contraption, visited, visitedMatrix)
            progress(row, col - 1, 2, contraption, visited, visitedMatrix)
            return
        elseif direction == 0
            progress(row, col + 1, 0, contraption, visited, visitedMatrix)
            return
        elseif direction == 2
            progress(row, col - 1, 2, contraption, visited, visitedMatrix)
            return
        else
            println("$direction not supported")
            return
        end
    elseif current == "/"
        # right
        if direction == 0
            # up
            progress(row - 1, col, 3, contraption, visited, visitedMatrix)
            return
            # down
        elseif direction == 1
            # left
            progress(row, col - 1, 2, contraption, visited, visitedMatrix)
            return
            # left
        elseif direction == 2
            # down
            progress(row + 1, col, 1, contraption, visited, visitedMatrix)
            return
            # up
        elseif direction == 3
            # right
            progress(row, col + 1, 0, contraption, visited, visitedMatrix)
            return
        else
            println("$direction not supported")
            return
        end
    elseif current == "\\"
        # right
        if direction == 0
            # down
            progress(row + 1, col, 1, contraption, visited, visitedMatrix)
            return
            # down
        elseif direction == 1
            # right
            progress(row, col + 1, 0, contraption, visited, visitedMatrix)
            return
            # left
        elseif direction == 2
            # up
            progress(row - 1, col, 3, contraption, visited, visitedMatrix)
            return
            # up
        elseif direction == 3
            # left
            progress(row, col - 1, 2, contraption, visited, visitedMatrix)
            return
        else
            println("$direction not supported")
            return
        end
    else
        println("$current char not implemented")
        return
    end
end

function print(matrix)
    for row in eachrow(matrix)
        println(row)
    end
end

solution()
