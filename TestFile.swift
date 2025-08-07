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
    distanceMatrix[startCity][0] = 0
    
    for _ in 0..<totalCities * (magicSpellCount + 1) {
        var selectedCity = -1
        var selectedSpells = -1
        var minDistance = Int.max
        
        for city in 0..<totalCities {
            for spells in 0...magicSpellCount {
                if distanceMatrix[city][spells] < minDistance {
                    minDistance = distanceMatrix[city][spells]
                    selectedCity = city
                    selectedSpells = spells
                }
            }
        }
        
        guard selectedCity != -1 else { break }
        
        distanceMatrix[selectedCity][selectedSpells] = Int.max
        
        for (neighborCity, edgeWeight) in cityGraph[selectedCity] {
            distanceMatrix[neighborCity][selectedSpells] = min(distanceMatrix[neighborCity][selectedSpells], minDistance + edgeWeight)
            
            if selectedSpells < magicSpellCount {
                distanceMatrix[neighborCity][selectedSpells + 1] = min(distanceMatrix[neighborCity][selectedSpells + 1], minDistance)
            }
        }
    }
    
    print(distanceMatrix[targetCity].min() == Int.max ? -1 : distanceMatrix[targetCity].min()!)
}

findShortestPathWithMagic()