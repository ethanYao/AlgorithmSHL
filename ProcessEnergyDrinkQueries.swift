func processEnergyDrinkQueries(_ numOfCustomer: Int, _ numOfQueries: Int, _ queryDesc: Int, _ queries: [[Int]]) -> [Int] {
    // 使用字典存储客户购买记录，key为客户ID，value为购买数量
    var customerPurchases: [Int: Int] = [:]
    var results: [Int] = []
    
    for query in queries {
        let queryType = query[0]
        
        if queryType == 1 {
            // 类型1查询：记录/更新客户购买
            let customerID = query[1]
            let quantity = query[2]
            
            // 如果客户已存在，累加数量；否则创建新记录
            customerPurchases[customerID, default: 0] += quantity
            
        } else if queryType == 2 {
            // 类型2查询：查询范围内客户的总购买量
            let startID = query[1]
            let endID = query[2]
            
            var totalQuantity = 0
            
            // 遍历指定范围内的客户ID
            for customerID in startID...endID {
                totalQuantity += customerPurchases[customerID, default: 0]
            }
            
            results.append(totalQuantity)
        }
    }
    
    return results
}

// 测试示例
let testQueries = [
    [1, 3, 12],  // 客户3购买12罐
    [2, 0, 2],   // 查询客户0-2的总购买量
    [1, 1, 4],   // 客户1购买4罐
    [1, 3, 2],   // 客户3再购买2罐
    [2, 2, 4]    // 查询客户2-4的总购买量
]

let result = processEnergyDrinkQueries(4, 5, 3, testQueries)
print(result.map { String($0) }.joined(separator: " "))
// 输出应该是: 0 14
