import Foundation

func findShortestPathWithMagic() {
    let totalCities = Int(readLine()!)!
    let startCity = Int(readLine()!)!
    let targetCity = Int(readLine()!)!
    let magicSpellCount = Int(readLine()!)!
    let roadInfo = readLine()!.split(separator: " ").map { Int($0)! }
    let totalRoads = roadInfo[0]
    
    var cityGraph = Array(repeating: [(Int, Int)](), count: totalCities)
    
    for _ in 0..<totalRoads {
        let roadData = readLine()!.split(separator: " ").map { Int($0)! }
        let cityFrom = roadData[0]
        let cityTo = roadData[1]
        let roadDistance = roadData[2]
        
        cityGraph[cityFrom].append((cityTo, roadDistance))
        cityGraph[cityTo].append((cityFrom, roadDistance))
    }
    
    var minDistanceTable = Array(repeating: Array(repeating: Int.max, count: magicSpellCount + 1), count: totalCities)
    var visitedStates = Array(repeating: Array(repeating: false, count: magicSpellCount + 1), count: totalCities)
    
    minDistanceTable[startCity][0] = 0
    
    for _ in 0..<totalCities * (magicSpellCount + 1) {
        var currentMinDistance = Int.max
        var selectedCity = -1
        var selectedSpellsUsed = -1
        
        for cityIndex in 0..<totalCities {
            for spellsUsed in 0...magicSpellCount {
                if !visitedStates[cityIndex][spellsUsed] && minDistanceTable[cityIndex][spellsUsed] < currentMinDistance {
                    currentMinDistance = minDistanceTable[cityIndex][spellsUsed]
                    selectedCity = cityIndex
                    selectedSpellsUsed = spellsUsed
                }
            }
        }
        
        if selectedCity == -1 { break }
        
        visitedStates[selectedCity][selectedSpellsUsed] = true
        
        for (neighborCity, edgeWeight) in cityGraph[selectedCity] {
            // Normal traversal
            if minDistanceTable[selectedCity][selectedSpellsUsed] + edgeWeight < minDistanceTable[neighborCity][selectedSpellsUsed] {
                minDistanceTable[neighborCity][selectedSpellsUsed] = minDistanceTable[selectedCity][selectedSpellsUsed] + edgeWeight
            }
            
            // Magic spell traversal
            if selectedSpellsUsed < magicSpellCount && minDistanceTable[selectedCity][selectedSpellsUsed] < minDistanceTable[neighborCity][selectedSpellsUsed + 1] {
                minDistanceTable[neighborCity][selectedSpellsUsed + 1] = minDistanceTable[selectedCity][selectedSpellsUsed]
            }
        }
    }
    
    var finalResult = Int.max
    for spellsUsed in 0...magicSpellCount {
        finalResult = min(finalResult, minDistanceTable[targetCity][spellsUsed])
    }
    
    print(finalResult == Int.max ? -1 : finalResult)
}