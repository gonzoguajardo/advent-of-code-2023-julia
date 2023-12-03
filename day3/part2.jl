function main()
    parse = parseInput()
    solution(parse[1], parse[2])
end

"""
# Returns
- inputMatrix: matrix of the input
- specialSymbols: list of [row, col] for special symbols
"""
function parseInput()
    inputMatrix = Vector{Vector{String}}([])
    specialSymbols = Vector{Vector{Int}}([])
    open("$(dirname(@__FILE__))/input.txt") do file
        row = 1
        while !eof(file)
            line = readline(file)
            currentLine = String[]
            col = 1
            for char in line
                stringChar = string(char)
                # check if gear
                if stringChar == "*"
                    push!(specialSymbols, [row, col])
                end
                push!(currentLine, stringChar)
                col += 1
            end
            push!(inputMatrix, currentLine)
            row += 1
        end
    end
    return inputMatrix, specialSymbols
end

function solution(inputMatrix, specialSymbols)
    # keep track of visited positions so we don't process the same number
    visited::Dict{Array{Int},Bool} = Dict()
    sum::Int128 = 0
    row::Int = 0
    col::Int = 0
    for specialSymbolPosition in specialSymbols
        gearPartNumbers = Int[]
        currentPartNumber::Int = 0

        # check top left
        row = specialSymbolPosition[1] - 1
        col = specialSymbolPosition[2] - 1
        currentPartNumber = processDirection(inputMatrix, row, col, visited)
        if currentPartNumber != 0
            push!(gearPartNumbers, currentPartNumber)
        end

        # check top
        row = specialSymbolPosition[1] - 1
        col = specialSymbolPosition[2]
        currentPartNumber = processDirection(inputMatrix, row, col, visited)
        if currentPartNumber != 0
            push!(gearPartNumbers, currentPartNumber)
        end

        # check top right
        row = specialSymbolPosition[1] - 1
        col = specialSymbolPosition[2] + 1
        currentPartNumber = processDirection(inputMatrix, row, col, visited)
        if currentPartNumber != 0
            push!(gearPartNumbers, currentPartNumber)
        end

        # check right
        row = specialSymbolPosition[1]
        col = specialSymbolPosition[2] - 1
        currentPartNumber = processDirection(inputMatrix, row, col, visited)
        if currentPartNumber != 0
            push!(gearPartNumbers, currentPartNumber)
        end

        # check left
        row = specialSymbolPosition[1]
        col = specialSymbolPosition[2] + 1
        currentPartNumber = processDirection(inputMatrix, row, col, visited)
        if currentPartNumber != 0
            push!(gearPartNumbers, currentPartNumber)
        end

        # check bottom right
        row = specialSymbolPosition[1] + 1
        col = specialSymbolPosition[2] - 1
        currentPartNumber = processDirection(inputMatrix, row, col, visited)
        if currentPartNumber != 0
            push!(gearPartNumbers, currentPartNumber)
        end

        # check bottom
        row = specialSymbolPosition[1] + 1
        col = specialSymbolPosition[2]
        currentPartNumber = processDirection(inputMatrix, row, col, visited)
        if currentPartNumber != 0
            push!(gearPartNumbers, currentPartNumber)
        end

        # check bottom right
        row = specialSymbolPosition[1] + 1
        col = specialSymbolPosition[2] + 1
        currentPartNumber = processDirection(inputMatrix, row, col, visited)
        if currentPartNumber != 0
            push!(gearPartNumbers, currentPartNumber)
        end

        if length(gearPartNumbers) == 2
            println(gearPartNumbers)
            sum += gearPartNumbers[1] * gearPartNumbers[2]
        end
    end
    println(sum)
end

function processDirection(inputMatrix, row, col, visited)::Int
    if isPositionValid(inputMatrix, row, col) && !haskey(visited, [row, col]) && isdigit(inputMatrix[row][col][1])
        number = findNumber!(inputMatrix, row, col, visited)
        return number
    end
    return 0
end

function findNumber!(inputMatrix, row, col, visited)::Int
    numberString::String = inputMatrix[row][col]
    visited[[row, col]] = true
    # traverse right
    newCol = col - 1
    while (newCol > 0)
        if !isdigit(inputMatrix[row][newCol][1])
            break
        end
        numberString = inputMatrix[row][newCol] * numberString
        visited[[row, newCol]] = true
        newCol -= 1
    end
    # traverse left
    newCol = col + 1
    while (newCol <=length(inputMatrix[1]))
        if !isdigit(inputMatrix[row][newCol][1])
            break
        end
        numberString = numberString * inputMatrix[row][newCol]
        visited[[row, newCol]] = true
        newCol += 1
    end
    return parse(Int, numberString)
end

function isPositionValid(inputMatrix, row, col)::Bool
    if row < 0 || col < 0
        return false
    end
    if row > length(inputMatrix)
        return false
    end
    if col > length(inputMatrix[1])
        return false
    end
    return true
end

main()
