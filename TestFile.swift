import Foundation

func minGasStations(_ num: Int, _ distancesStr: String, _ numS: Int, _ gasAmountsStr: String, _ totalDistance: Int, _ initialGas: Int) -> Int {
    let distances = distancesStr.split(separator: " ").map { Int($0)! }
    let gasAmounts = gasAmountsStr.split(separator: " ").map { Int($0)! }
    let stations = zip(distances, gasAmounts).sorted { $0.0 < $1.0 }
    
    var position = 0
    var currentGas = initialGas
    var count = 0
    var i = 0
    
    while position < totalDistance {
        if position + currentGas >= totalDistance { return count }
        
        var best = -1
        var maxGas = 0
        
        while i < stations.count && stations[i].0 <= position + currentGas {
            if stations[i].1 > maxGas {
                maxGas = stations[i].1
                best = i
            }
            i += 1
        }
        
        if best == -1 { return -1 }
        
        currentGas -= stations[best].0 - position
        position = stations[best].0
        currentGas += stations[best].1
        count += 1
        i = best + 1
    }
    
    return count
}

// Test
print(minGasStations(4, "5 7 8 10", 4, "2 3 1 5", 15, 5))