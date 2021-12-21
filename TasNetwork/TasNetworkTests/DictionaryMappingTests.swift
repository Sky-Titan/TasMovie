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
        
        let information = json.object(itemKey: "information", itemType: TestInformationModel.self)
        XCTAssert(information != nil)
        XCTAssert(information?.name == "park")
        XCTAssert(information?.age == 15)
        XCTAssert(information?.height == 175.5)
        XCTAssert(information?.isAdult == true)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
