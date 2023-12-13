using Combinatorics
function solution()
    file = open("input.txt", "r")
    fileString = read(file, String)
    close(file)

    lines = split(fileString, "\n")[1:end-1]

    choices = ["#", "."]

    sum = 0
    for currentLine in lines
        numberOfQuestionMarks = length(collect(eachmatch(r"\?", currentLine)))
        record, lengths = split(currentLine, " ")

        lengths = map(x -> parse(Int, x), split(lengths, ","))

        for i in Iterators.product(Iterators.repeated(choices, numberOfQuestionMarks)...)
            changedLine = record
            for change in i
                changedLine = replace(changedLine, "?" => change, count=1)
            end

            changedLine = strip(changedLine, '.')
            lengthsToCheck = split(changedLine, r"[.]+")
            lengthsToCheck = map(x -> length(x), lengthsToCheck)
            if lengths == lengthsToCheck
                sum += 1
            end
        end
    end

    println(sum)


end

solution()
