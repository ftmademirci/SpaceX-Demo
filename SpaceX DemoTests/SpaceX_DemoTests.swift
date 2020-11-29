//
//  SpaceX_DemoTests.swift
//  SpaceX DemoTests
//
//  Created by Admin on 25.11.2020.
//

import XCTest
@testable import SpaceX_Demo

class SpaceX_DemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "mock", withExtension: "json") else {
            XCTFail("Missing file: mocj.json")
            return
        }
        
        let json = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()

        do {
            let launchResponse = try decoder.decode(Launch.self, from: json)
            
            XCTAssertEqual((launchResponse.flight_number), 1)
            XCTAssertEqual((launchResponse.mission_name), "DemoSat")

            
        } catch {
            print(error.localizedDescription)
        }
    }
}

