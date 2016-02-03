//
//  SwiftyJSONDecodableTests_Array.swift
//  SwiftyJSONDecodable
//
//  Created by Mike Pollard on 03/02/2016.
//  Copyright © 2016 Mike Pollard. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import SwiftyJSONDecodable

class SwiftyJSONDecodableTests_Array: XCTestCase {
    
    var testJson : JSON!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        testJson = JSON(["bool":true, "int":42, "double": 3.14, "string":"hello", "aNull": NSNull(),
            "array":["a","b","c"], "hetroarray":["a","b",1]])
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testArray() {
        
        do{
            let a : [String] = try testJson.decodeArrayForKey("array")
            XCTAssert(a == ["a","b","c"], "Expected 'double' to decode as ['a','b','c']")
            
        }
        catch let error as CustomDebugStringConvertible {
            XCTFail(error.debugDescription)
        }
        catch {
            XCTFail("Unknow error")
        }
        
        
    }
    
    func testOptionalArray() {
        
        do{
            let a2 : [String]? = try testJson.decodeArrayForKey("array2")
            XCTAssert(a2 == nil, "Expected 'array2' to decode as nil")
            
            let a3 : [String]? = try testJson.decodeArrayForKey("aNull")
            XCTAssert(a3 == nil, "Expected 'aNull' to decode as nil")
            
        }
        catch let error as CustomDebugStringConvertible {
            XCTFail(error.debugDescription)
        }
        catch {
            XCTFail("Unknow error")
        }
    }
    
    func testArrayFailures() {
        
        var swiftyJSONDecodeError : SwiftyJSONDecodeError?
        
        do {
            let _ : [String] = try testJson.decodeArrayForKey("hetroarray")
            XCTFail("Expected attempt to decode 'hetroarray' as [String] to throw and not reach here")
        }
        catch let error as SwiftyJSONDecodeError {
            swiftyJSONDecodeError = error
        }
        catch {
            XCTFail("Unknow error")
        }

        XCTAssertTrue(swiftyJSONDecodeError == SwiftyJSONDecodeError.ErrorForKey(key: "hetroarray", error: SwiftyJSONDecodeError.ErrorForKey(key: "[2]", error: SwiftyJSONDecodeError.WrongType)), "")
        
        swiftyJSONDecodeError = nil
        do {
            let _ : [String]? = try testJson.decodeArrayForKey("string")
            XCTFail("Expected attempt to decode 'string' as [String]? to throw and not reach here")
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
            let _ : [String] = try testJson.decodeArrayForKey("aNull")
            XCTFail("Expected attempt to decode 'aNull' as [String] to throw and not reach here")
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
            let _ : [String] = try testJson.decodeArrayForKey("bool")
            XCTFail("Expected attempt to decode 'bool' as [String] to throw and not reach here")
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
