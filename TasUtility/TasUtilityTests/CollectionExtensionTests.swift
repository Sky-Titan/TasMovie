//
//  CollectionExtensionTests.swift
//  TasUtilityTests
//
//  Created by 박준현 on 2021/11/29.
//

import XCTest

class CollectionExtensionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExampleSafeIndex() throws {
        let array: [Int] = [3, 2]
        
        XCTAssert(array[safe: 0] != nil)
        XCTAssert(array[safe: 1] == 2)
        XCTAssert(array[safe: 2] == nil)
    }

    func testExampleIsNotEmpty() throws {
        let emptyArray: [Int] = []
        
        XCTAssert(emptyArray.isEmpty == true)
        XCTAssert(emptyArray.isNotEmpty == false)
    }
}
