//
//  SwiftyJSONDecodableTests_Object.swift
//  SwiftyJSONDecodable
//
//  Created by Mike Pollard on 03/02/2016.
//  Copyright © 2016 Mike Pollard. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import SwiftyJSONDecodable

class SwiftyJSONDecodableTests_Object: XCTestCase {
    
    struct Person : SwiftyJSONDecodable {
        
        let name : String
        let age : Int
        let height : Double?
        let male : Bool
        
        init(json: JSON) throws {
            name = try json.decodeValueForKey("name")
            age = try json.decodeValueForKey("age")
            height = try json.decodeValueForKey("height")
            male = try json.decodeValueForKey("male")
        }
    }
    
    var testJson : JSON!
    var badTestJson : JSON!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        testJson = JSON(["peeps":[["name":"bob", "age":21, "height":1.97, "male":true], ["name":"sue", "age":21, "male":false]]])
        
        badTestJson = JSON(["peeps":[["name":"bob", "age":21, "height":1.97, "male":true], ["_name":"sue", "age":21, "male":false]]])
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testObject() {
        
        do{
            let peeps : [Person] = try testJson.decodeArrayForKey("peeps")
            XCTAssert(peeps.count == 2, "Expected 2 Persons")
            let peep0 = peeps[0]
            XCTAssert(peep0.name == "bob", "Expected name 'bob'")
            XCTAssert(peep0.age == 21, "Expected age 21")
            XCTAssert(peep0.height == 1.97, "Expected height 1.97")
            XCTAssert(peep0.male == true, "Expected male true")
            let peep1 = peeps[1]
            XCTAssert(peep1.name == "sue", "Expected name 'sue'")
            XCTAssert(peep1.age == 21, "Expected age 21")
            XCTAssert(peep1.height == nil, "Expected height nil")
            XCTAssert(peep1.male == false, "Expected male true")
            
        }
        catch let error as CustomDebugStringConvertible {
            XCTFail(error.debugDescription)
        }
        catch {
            XCTFail("Unknow error")
        }
        
    }
    
    func testObjectFailures() {
        
        var swiftyJSONDecodeError : SwiftyJSONDecodeError?
        
        do {
            let _ : [Person] = try badTestJson.decodeArrayForKey("peeps")
            XCTFail("Expected attempt to decode 'peeps' as [Person] to throw and not reach here")
        }
        catch let error as SwiftyJSONDecodeError {
            swiftyJSONDecodeError = error
        }
        catch {
            XCTFail("Unknow error")
        }
        debugPrint(swiftyJSONDecodeError)
        XCTAssertTrue(swiftyJSONDecodeError == SwiftyJSONDecodeError.ErrorForKey(key: "peeps", error: SwiftyJSONDecodeError.ErrorForKey(key: "[1]", error: SwiftyJSONDecodeError.ErrorForKey(key: "name", error:SwiftyJSONDecodeError.NullValue))), "")
    }
    
}
