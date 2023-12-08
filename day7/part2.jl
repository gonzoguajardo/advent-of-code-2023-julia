
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
    handGroups::Vector{Vector{String}}= []
    for i in 1:7
        push!(handGroups, [])
    end

    # sort into hand groups
    bidDict = Dict()
    for line in inputArray
        lineSplit = split(line, " ")
        hand = lineSplit[1]
        bid = parse(Int, lineSplit[2])
        bidDict[hand] = bid

        cardDict = Dict()
        maxCount = missing
        wildCards = 0
        for card in hand
            if card == 'J'
                wildCards += 1
                continue
            end
            if haskey(cardDict, card)
                cardDict[card] += 1
            else
                cardDict[card] = 1
            end

            if ismissing(maxCount)
                maxCount = cardDict[card]
            elseif cardDict[card] > maxCount
                maxCount = cardDict[card]
            end
        end
        if ismissing(maxCount)
            maxCount = 5
        else
            maxCount += wildCards
        end

        # high card
        if maxCount == 1
            push!(handGroups[1], hand)
        # pair or two pair
        elseif maxCount == 2
            if length(cardDict) == 4
                push!(handGroups[2], hand)
            else
                push!(handGroups[3], hand)
            end
        # 3 of a kind, or full house
        elseif maxCount == 3
            if length(cardDict) == 3
                push!(handGroups[4], hand)
            else
                push!(handGroups[5], hand)
            end
        # 4 of a kind
        elseif maxCount == 4
            push!(handGroups[6], hand)
        # 5 of a kind
        elseif maxCount == 5
            push!(handGroups[7], hand)
        end
    end

    rank = 1
    totalWinnings = 0
    for i in 1:length(handGroups)
        handGroup = handGroups[i]
        sortedHandGroup = sort(handGroup, lt=sortByHandValue)
        for sortedHand in sortedHandGroup
            totalWinnings += rank * bidDict[sortedHand]
            rank += 1
        end
    end
    return totalWinnings
end

function sortByHandValue(hand1::String, hand2::String)::Bool
    cardValues = Dict(
        'A' => 13,
        'K' => 12,
        'Q' => 11,
        'T' => 10,
        '9' => 9,
        '8' => 8,
        '7' => 7,
        '6' => 6,
        '5' => 5,
        '4' => 4,
        '3' => 3,
        '2' => 2,
        'J' => 1,
    )
    for i in 1:length(hand1)
        card1 = hand1[i]
        card2 = hand2[i]

        card1Value = cardValues[card1]
        card2Value = cardValues[card2]
        if card1Value < card2Value
            return true
        elseif card1Value > card2Value
            return false
        else
            continue
        end
    end
end


main()
