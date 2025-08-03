import Foundation

func streetLights(n: Int, currentState: String, days: Int) -> String {
    var state = currentState.split(separator: " ").map { Int($0)! }
    
    for _ in 0..<days {
        var newState = Array(repeating: 0, count: n)
        for i in 0..<n {
            let left = i == 0 ? 0 : state[i-1]
            let right = i == n-1 ? 0 : state[i+1]
            newState[i] = left == right ? 0 : 1
        }
        state = newState
    }
    
    return state.map { String($0) }.joined(separator: " ")
}

let street1 = streetLights(n: 8, currentState: "1 0 0 0 0 1 0 0", days: 1)
streetLights(n: 8, currentState: "1 1 1 0 1 1 1 1", days: 2)
