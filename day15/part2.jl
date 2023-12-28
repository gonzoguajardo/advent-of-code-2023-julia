function solution()
    file = open("input.txt", "r")
    fileString = read(file, String)
    close(file)

    lines = split(fileString, "\n")
    sequences = split(lines[1], ",")
    boxes = Dict()
    boxIndexes = Dict()
    for sequenceIndex in 1:length(sequences)
        sequence = sequences[sequenceIndex]
        if occursin("=", sequence)
            label, focalLength = split(sequence, "=")
            box = hash(label)
            if haskey(boxes, box)
                if haskey(boxIndexes[box], label)
                    index = boxIndexes[box][label]
                    boxes[box][index] = "$label $focalLength"
                else
                    push!(boxes[box], "$label $focalLength")
                    boxIndexes[box][label] = length(boxes[box])
                end
            else
                boxes[box] = ["$label $focalLength"]
                boxIndexes[box] = Dict()
                boxIndexes[box][label] = 1
            end
        else
            label = split(sequence, "-")[1]
            box = hash(label)
            if haskey(boxIndexes, box) && haskey(boxIndexes[box], label)
                index = boxIndexes[box][label]
                currentList = boxes[box]
                boxes2 = vcat(currentList[begin:index-1], currentList[index+1:end])
                # hmm so I have to rest the indexes here?
                boxes[box] = boxes2
                delete!(boxIndexes[box], label)
                for i in 1:length(boxes2)
                    s = boxes2[i]
                    currentLabel, _ = split(s, " ")
                    boxIndexes[box][currentLabel] = i
                end
            end
        end
    end

    sum = 0
    for (boxNumber, box) in boxes
        for i in 1:length(box)
            sequence = box[i]
            _, focalLengthString = split(sequence, " ")
            focalLength = parse(Int, focalLengthString)
            sum += (boxNumber +1)* focalLength * i
        end
    end
    println(sum)
end

function hash(string)
    currentValue = 0
    for char in string
        asciiValue = UInt8(char)
        currentValue += asciiValue
        currentValue *= 17
        currentValue = currentValue % 256
    end
    return currentValue
end

solution()
