function main()
    fullTrip = solution()
    s = 0
    if fullTrip %2 == 0
        s =  fullTrip / 2
    else
        s =  1 + ((fullTrip -1)/ 2)
    end
    println(s)
end

function solution()
    file = open("input.txt", "r")
    fileString = read(file, String)
    close(file)

    lines = split(fileString, "\n")
    sRow = missing
    sCol = missing
    for row in 1:length(lines)
        line = lines[row]
        for col in 1:length(line)
            char = line[col]
            if char == 'S'
                sRow = row
                sCol = col
                println("found s at $row, $col")
            end
        end
    end

    visited = Dict()
    return r(lines, sRow, sCol, 0, visited)


end

function r(lines, currentRow, currentCol, distance, visited)
    if haskey(visited, [currentRow, currentCol])
        return distance
    end
    if currentRow > length(lines) || currentRow == 0
        return distance
    end
    if currentCol > length(lines[1]) || currentCol == 0
        return distance
    end
    char = lines[currentRow][currentCol]
    visited[[currentRow, currentCol]] = true

    # end of line
    if char == '.'
        return distance
    end

    #spawn one in all sides
    if char == 'S'
        return max(
            # top
            r(lines, currentRow - 1, currentCol, distance, visited),
            # right
            r(lines, currentRow, currentCol + 1, distance, visited),
            # bottom
            r(lines, currentRow + 1, currentCol, distance, visited),
            # left
            r(lines, currentRow, currentCol - 1, distance, visited)
        )
    elseif char == '-'
        return max(
            # right
            r(lines, currentRow, currentCol + 1, distance + 1, visited),
            # left
            r(lines, currentRow, currentCol - 1, distance + 1, visited)
        )
    elseif char == '|'
        return max(
            # top
            r(lines, currentRow - 1, currentCol, distance + 1, visited),
            # bottom
            r(lines, currentRow + 1, currentCol, distance + 1, visited)
        )
    elseif char == '7'
        return max(
            # bottom
            r(lines, currentRow + 1, currentCol, distance + 1, visited),
            # left
            r(lines, currentRow, currentCol - 1, distance + 1, visited)
        )
    elseif char == 'L'
        return max(
            # top
            r(lines, currentRow - 1, currentCol, distance + 1, visited),
            # right
            r(lines, currentRow, currentCol + 1, distance + 1, visited)
        )
    elseif char == 'J'
        return max(
            # top
            r(lines, currentRow - 1, currentCol, distance + 1, visited),
            # left
            r(lines, currentRow, currentCol - 1, distance + 1, visited)
        )
    elseif char == 'F'
        return max(
            # right
            r(lines, currentRow, currentCol + 1, distance + 1, visited),
            # bottom
            r(lines, currentRow + 1, currentCol, distance + 1, visited)
        )
    else
        println("not implemented for $char")
        return distance
    end
end

main()
