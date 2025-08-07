import Foundation

func sortByFrequencyDescending() {
//    let elementCount = Int(readLine()!)!
//    let numberList = readLine()!.split(separator: " ").map { Int($0)! }
    
    let elementCount = 19
    let testNum = "1 2 2 3 3 3 4 4 5 5 5 5 6 6 6 7 8 9 10"
    let numberList = testNum.split(separator: " ").map { Int($0)! }
    
    var frequencyMap = [Int: Int]()
    var firstOccurrenceIndex = [Int: Int]()
    
    for (index, number) in numberList.enumerated() {
        frequencyMap[number, default: 0] += 1
        if firstOccurrenceIndex[number] == nil {
            firstOccurrenceIndex[number] = index
        }
    }
    
    let sortedNumbers = numberList.sorted { firstNum, secondNum in
        let firstFreq = frequencyMap[firstNum]!
        let secondFreq = frequencyMap[secondNum]!
        
        if firstFreq != secondFreq {
            return firstFreq > secondFreq
        }
        return firstOccurrenceIndex[firstNum]! < firstOccurrenceIndex[secondNum]!
    }
    
    print(sortedNumbers.map { String($0) }.joined(separator: " "))
}

sortByFrequencyDescending()