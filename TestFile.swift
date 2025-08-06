import Foundation

func encryptCode(_ secretCode: Int, _ firstKey: Int, _ secondKey: Int) {
    let MOD = 1000000007
    
    // Calculate S^N % 10 using modular exponentiation
    func modPow(_ base: Int, _ exp: Int, _ mod: Int) -> Int {
        if exp == 0 { return 1 }
        var result = 1
        var b = base % mod
        var e = exp
        
        while e > 0 {
            if e % 2 == 1 {
                result = (result * b) % mod
            }
            b = (b * b) % mod
            e /= 2
        }
        return result
    }
    
    // First step: S^N % 10
    let base = modPow(secretCode, firstKey, 10)
    
    // Second step: (base^M) % 1000000007
    let result = modPow(base, secondKey, MOD)
    
    print(result)
}

// Test with the example
encryptCode(2, 3, 4)
encryptCode(3, 1000000007, 4)