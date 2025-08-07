import Foundation

func findShortestPathWithMagic() {
    let totalCities = Int(readLine()!)!
    let startCity = Int(readLine()!)!
    let targetCity = Int(readLine()!)!
    let magicSpellCount = Int(readLine()!)!
    let totalRoads = Int(readLine()!.split(separator: " ")[0])!
    
    var cityGraph = Array(repeating: [(Int, Int)](), count: totalCities)
    
    (0..<totalRoads).forEach { _ in
        let roadData = readLine()!.split(separator: " ").map { Int($0)! }
        cityGraph[roadData[0]].append((roadData[1], roadData[2]))
        cityGraph[roadData[1]].append((roadData[0], roadData[2]))
    }
    
    var distanceStates = Array(repeating: Array(repeating: Int.max, count: magicSpellCount + 1), count: totalCities)
    distanceStates[startCity][0] = 0
    
    var priorityQueue = [(distance: Int, city: Int, spellsUsed: Int)]()
    priorityQueue.append((0, startCity, 0))
    
    while !priorityQueue.isEmpty {
        let (currentDistance, currentCity, currentSpells) = priorityQueue.removeFirst()
        
        if currentDistance > distanceStates[currentCity][currentSpells] { continue }
        
        cityGraph[currentCity].forEach { neighbor, edgeWeight in
            let newDistance = currentDistance + edgeWeight
            if newDistance < distanceStates[neighbor][currentSpells] {
                distanceStates[neighbor][currentSpells] = newDistance
                priorityQueue.append((newDistance, neighbor, currentSpells))
            }
            
            if currentSpells < magicSpellCount && currentDistance < distanceStates[neighbor][currentSpells + 1] {
                distanceStates[neighbor][currentSpells + 1] = currentDistance
                priorityQueue.append((currentDistance, neighbor, currentSpells + 1))
            }
        }
        
        priorityQueue.sort { $0.distance < $1.distance }
    }
    
    let finalResult = distanceStates[targetCity].min()!
    print(finalResult == Int.max ? -1 : finalResult)
}