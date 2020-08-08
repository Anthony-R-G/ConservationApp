//
//  TerraTests.swift
//  TerraTests
//
//  Created by Anthony Gonzalez on 1/26/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import XCTest
@testable import Terra

class TerraTests: XCTestCase {
        
    func testJSONMapping() throws {
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "modelTestData", withExtension: "json") else {
            XCTFail("Missing file: data.json")
            return
        }

        let jsonData = try Data(contentsOf: url)
        let animal: Species = try JSONDecoder().decode(Species.self, from: jsonData)

        XCTAssertEqual(animal.commonName, "Amur Leopard")
    }
    
    func testFactoryLabelWorks() {
        let labelTitle = "ASDF"
        let label = Factory.makeLabel(title: labelTitle, weight: .bold, size: 15, color: .white, alignment: .left)
        
        XCTAssert(label.text == labelTitle, "Factory method not assigning title correctly")
       }
    
    //ISO8601 Formatting
    
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
