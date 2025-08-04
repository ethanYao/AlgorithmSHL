import Foundation

func processQueries(_ numOfCustomer: Int, _ secondLine: String, _ queryLines: [String]) -> String {
    // 解析第二行的两个整数
    let secondLineComponents = secondLine.split(separator: " ").map { Int($0)! }
    let numOfQueries = secondLineComponents[0]
    let queryDesc = secondLineComponents[1]
    
    var customerQuantities = [Int: Int]()
    var type2Results = [Int]()
    
    // 处理每一行查询
    for queryLine in queryLines {
        let queryComponents = queryLine.split(separator: " ").map { Int($0)! }
        let queryType = queryComponents[0]
        
        if queryType == 1 {
            let customerID = queryComponents[1]
            let quantity = queryComponents[2]
            customerQuantities[customerID, default: 0] += quantity
        } else if queryType == 2 {
            let startID = queryComponents[1]
            let endID = queryComponents[2]
            var totalQuantity = 0
            
            for id in startID...endID {
                totalQuantity += customerQuantities[id, default: 0]
            }
            
            type2Results.append(totalQuantity)
        }
    }
    
    // 返回空格分隔的字符串，如果没有type2查询则返回空字符串
    return type2Results.isEmpty ? "" : type2Results.map(String.init).joined(separator: " ")
}


// 测试示例
let testQueriesCopy = [
    "1 3 12",  // 客户3购买12罐
    "2 0 2",   // 查询客户0-2的总购买量
    "1 1 4",   // 客户1购买4罐
    "1 3 2",   // 客户3再购买2罐
    "2 2 4"    // 查询客户2-4的总购买量
]

let result1 = processQueries(4, "5 3", testQueriesCopy)
print(result1)
