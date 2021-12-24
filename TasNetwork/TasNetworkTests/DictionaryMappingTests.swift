//
//  DictionaryMappingTests.swift
//  TasNetworkTests
//
//  Created by 박준현 on 2021/12/21.
//

import XCTest
import TasNetwork

class DictionaryMappingTests: XCTestCase {

    class TestInformationModel: BaseJSONMappable {
        let name: String
        let age: Int
        let height: Double
        let isAdult: Bool
        
        required init(from json: [String : Any]) {
            name = json.string(itemKey: "name") ?? ""
            age = json.integer(itemKey: "age") ?? 0
            height = json.double(itemKey: "height") ?? 0
            isAdult = json.bool(itemKey: "isAdult") ?? false
        }
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBasicValueTypeExample() throws {
        let json: [String: Any] = ["name": "park", "age": 15, "height": 175.5, "isAdult": true]
        XCTAssert(json.string(itemKey: "name") == "park")
        XCTAssert(json.bool(itemKey: "isAdult") == true)
        XCTAssert(json.integer(itemKey: "age") == 15)
        XCTAssert(json.double(itemKey: "height") == 175.5)
        XCTAssert(json.string(itemKey: "City") == nil)
    }
    
    func testObjectTypeExample() throws {
        let object: [String: Any] = ["name": "park", "age": 15, "height": 175.5, "isAdult": true]
        let json: [String: Any] = ["information": object]
        
        let information = json.object(itemKey: "information", objectType: TestInformationModel.self)
        XCTAssert(information != nil)
        XCTAssert(information?.name == "park")
        XCTAssert(information?.age == 15)
        XCTAssert(information?.height == 175.5)
        XCTAssert(information?.isAdult == true)
    }
    
    func testArrayExample() throws {
        let array: [Int] = [0, 1, 2, 3]
        let json: [String: Any] = ["array": array]
        
        let result = json.array(itemKey: "array", itemType: Int.self)
        XCTAssert(result.isNotEmpty)
        XCTAssert(result[safe: 0] == 0)
        XCTAssert(result[safe: 1] == 1)
        XCTAssert(result[safe: 2] == 2)
        XCTAssert(result[safe: 3] == 3)
    }
    
    func testObjectArrayExample() throws {
        let object: [String: Any] = ["name": "park", "age": 15, "height": 175.5, "isAdult": true]
        let object2: [String: Any] = ["name": "kim", "age": 17, "height": 176.5, "isAdult": false]
        
        let array: [[String: Any]] = [object, object2]
        let json: [String: Any] = ["array": array]
        
        let result = json.array(itemKey: "array", objectType: TestInformationModel.self)
        XCTAssert(result.isNotEmpty)
        let information1 = result[safe: 0]
        XCTAssert(information1?.name == "park")
        XCTAssert(information1?.age == 15)
        XCTAssert(information1?.height == 175.5)
        XCTAssert(information1?.isAdult == true)
        
        let information2 = result[safe: 1]
        XCTAssert(information2?.name == "kim")
        XCTAssert(information2?.age == 17)
        XCTAssert(information2?.height == 176.5)
        XCTAssert(information2?.isAdult == false)
    }

}
