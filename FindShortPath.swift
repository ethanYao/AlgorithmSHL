
import Foundation

func findShortestPath(_ posK: Int, _ num: Int, _ xCoordinates: String, _ xHead: Int, _ yHead: Int) -> String {
    let xCoords = xCoordinates.split(separator: " ").map { Double($0)! }
    var points = xCoords.map { ($0, 0.0) }
    points.append((Double(xHead), Double(yHead)))
    
    let n = points.count
    let start = posK - 1
    
    func dist(_ i: Int, _ j: Int) -> Double {
        let dx = points[i].0 - points[j].0
        let dy = points[i].1 - points[j].1
        return sqrt(dx * dx + dy * dy)
    }
    
    var dp = Array(repeating: Array(repeating: Double.infinity, count: n), count: 1 << n)
    dp[1 << start][start] = 0.0
    
    for mask in 0..<(1 << n) {
        for u in 0..<n where dp[mask][u] != Double.infinity && (mask & (1 << u)) != 0 {
            for v in 0..<n where u != v && (mask & (1 << v)) == 0 {
                let newMask = mask | (1 << v)
                dp[newMask][v] = min(dp[newMask][v], dp[mask][u] + dist(u, v))
            }
        }
    }
    
    // max? min
    let result = dp[(1 << n) - 1].filter { $0 != Double.infinity }.max()!
    return String(format: "%.6f", result)
}


let result = findShortestPath(1, 3, "0 1 2", 1, 1)
print(result)
