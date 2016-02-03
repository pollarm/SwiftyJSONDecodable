//
//  SwiftyJSONDecodableTests_Double.swift
//  SwiftyJSONDecodable
//
//  Created by Mike Pollard on 03/02/2016.
//  Copyright © 2016 Mike Pollard. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import SwiftyJSONDecodable

class SwiftyJSONDecodableTests_Double: XCTestCase {
    
    var testJson : JSON!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        testJson = JSON(["bool":true, "int":42, "double": 3.14, "string":"hello", "aNull": NSNull()])
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDouble() {
        
        do{
            let d : Double = try testJson.decodeValueForKey("double")
            XCTAssert(d == 3.14, "Expected 'double' to decode as 3.14")
            
            let d2 : Double = try testJson.decodeValueForKey("int")
            XCTAssert(d2 == 42, "Expected 'double' to decode as 42")
            
        }
        catch let error as CustomDebugStringConvertible {
            XCTFail(error.debugDescription)
        }
        catch {
            XCTFail("Unknow error")
        }
        
        
    }
    
    func testOptionalDouble() {
        
        do{
            let d2 : Double? = try testJson.decodeValueForKey("double2")
            XCTAssert(d2 == nil, "Expected 'double2' to decode as nil")
            
            let d3 : Double? = try testJson.decodeValueForKey("aNull")
            XCTAssert(d3 == nil, "Expected 'aNull' to decode as nil")
            
        }
        catch let error as CustomDebugStringConvertible {
            XCTFail(error.debugDescription)
        }
        catch {
            XCTFail("Unknow error")
        }
    }
    
    func testDoubleFailures() {
        
        var swiftyJSONDecodeError : SwiftyJSONDecodeError?
        do {
            let _ : Double? = try testJson.decodeValueForKey("string")
            XCTFail("Expected attempt to decode 'string' as Int to throw and not reach here")
        }
        catch let error as SwiftyJSONDecodeError {
            swiftyJSONDecodeError = error
        }
        catch {
            XCTFail("Unknow error")
        }
        
        XCTAssertTrue(swiftyJSONDecodeError == SwiftyJSONDecodeError.ErrorForKey(key: "string", error: SwiftyJSONDecodeError.WrongType), "")
        
        swiftyJSONDecodeError = nil
        do {
            let _ : Double = try testJson.decodeValueForKey("aNull")
            XCTFail("Expected attempt to decode 'aNull' as Int to throw and not reach here")
        }
        catch let error as SwiftyJSONDecodeError {
            swiftyJSONDecodeError = error
        }
        catch {
            XCTFail("Unknow error")
        }
        
        XCTAssertTrue(swiftyJSONDecodeError == SwiftyJSONDecodeError.ErrorForKey(key: "aNull", error: SwiftyJSONDecodeError.NullValue), "")
        
        swiftyJSONDecodeError = nil
        do {
            let _ : Double = try testJson.decodeValueForKey("bool")
            XCTFail("Expected attempt to decode 'bool' as Int to throw and not reach here")
        }
        catch let error as SwiftyJSONDecodeError {
            swiftyJSONDecodeError = error
        }
        catch {
            XCTFail("Unknow error")
        }
        
        XCTAssertTrue(swiftyJSONDecodeError == SwiftyJSONDecodeError.ErrorForKey(key: "bool", error: SwiftyJSONDecodeError.WrongType), "")
        
    }
}
