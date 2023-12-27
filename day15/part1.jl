function solution()
    file = open("input.txt", "r")
    fileString = read(file, String)
    close(file)

    lines = split(fileString, "\n")
    sequences = split(lines[1], ",")
    sum = 0
    for line in sequences
        currentValue = 0
        # println(line)
        if line == "hello"
            break
        end
        for char in line
            # println("char is: $char")
            asciiValue = UInt8(char)
            # println("ascii value: $asciiValue")
            currentValue += asciiValue
            # println("current value: $currentValue")
            currentValue *= 17
            # println("current value: $currentValue")
            currentValue = currentValue % 256
            # println("current value: $currentValue")
        end
        sum += currentValue
        # println("$line becomes $currentValue")
    end
    println(sum)
end

function print(matrix)
    for row in eachrow(matrix)
        println(row)
    end
end

solution()
