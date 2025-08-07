import Foundation

func findShortestPathWithMagic() {
    let totalCities = Int(readLine()!)!
    let startCity = Int(readLine()!)!
    let targetCity = Int(readLine()!)!
    let magicSpellCount = Int(readLine()!)!
    let totalRoads = Int(readLine()!.split(separator: " ")[0])!
    
    var cityGraph = Array(repeating: [(Int, Int)](), count: totalCities)
    
    for _ in 0..<totalRoads {
        let roadData = readLine()!.split(separator: " ").map { Int($0)! }
        cityGraph[roadData[0]].append((roadData[1], roadData[2]))
        cityGraph[roadData[1]].append((roadData[0], roadData[2]))
    }
    
    var distanceMatrix = Array(repeating: Array(repeating: Int.max, count: magicSpellCount + 1), count: totalCities)
    
    for spellsUsed in 0...magicSpellCount {
        distanceMatrix[startCity][spellsUsed] = 0
        var tempMatrix = distanceMatrix
        
        for _ in 0..<totalCities {
            for currentCity in 0..<totalCities {
                if tempMatrix[currentCity][spellsUsed] == Int.max { continue }
                
                for (neighborCity, edgeWeight) in cityGraph[currentCity] {
                    let normalDistance = tempMatrix[currentCity][spellsUsed] + edgeWeight
                    if normalDistance < tempMatrix[neighborCity][spellsUsed] {
                        tempMatrix[neighborCity][spellsUsed] = normalDistance
                    }
                    
                    if spellsUsed > 0 {
                        let magicalDistance = tempMatrix[currentCity][spellsUsed - 1]
                        if magicalDistance < tempMatrix[neighborCity][spellsUsed] {
                            tempMatrix[neighborCity][spellsUsed] = magicalDistance
                        }
                    }
                }
            }
        }
        distanceMatrix = tempMatrix
    }
    
    let finalDistance = distanceMatrix[targetCity].min()!
    print(finalDistance == Int.max ? -1 : finalDistance)
}