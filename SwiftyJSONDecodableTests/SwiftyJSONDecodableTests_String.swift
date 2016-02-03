//
//  SwiftyJSONDecodableTests_String.swift
//  SwiftyJSONDecodable
//
//  Created by Mike Pollard on 03/02/2016.
//  Copyright © 2016 Mike Pollard. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import SwiftyJSONDecodable

class SwiftyJSONDecodableTests_String: XCTestCase {
    
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
    
    func testString() {
        
        do{
            let s : String = try testJson.decodeValueForKey("string")
            XCTAssert(s == "hello", "Expected 'string' to decode as 'hello'")
            
        }
        catch let error as CustomDebugStringConvertible {
            XCTFail(error.debugDescription)
        }
        catch {
            XCTFail("Unknow error")
        }
        
        
    }
    
    func testOptionalString() {
        
        do{
            let s2 : Int? = try testJson.decodeValueForKey("string2")
            XCTAssert(s2 == nil, "Expected 'string2' to decode as nil")
            
            let s3 : Int? = try testJson.decodeValueForKey("aNull")
            XCTAssert(s3 == nil, "Expected 'aNull' to decode as nil")
            
        }
        catch let error as CustomDebugStringConvertible {
            XCTFail(error.debugDescription)
        }
        catch {
            XCTFail("Unknow error")
        }
    }
    
    func testStringFailures() {
        
        var swiftyJSONDecodeError : SwiftyJSONDecodeError?
        do {
            let _ : String? = try testJson.decodeValueForKey("int")
            XCTFail("Expected attempt to decode 'int' as String to throw and not reach here")
        }
        catch let error as SwiftyJSONDecodeError {
            swiftyJSONDecodeError = error
        }
        catch {
            XCTFail("Unknow error")
        }
        
        XCTAssertTrue(swiftyJSONDecodeError == SwiftyJSONDecodeError.ErrorForKey(key: "int", error: SwiftyJSONDecodeError.WrongType), "")
        
        swiftyJSONDecodeError = nil
        do {
            let _ : String = try testJson.decodeValueForKey("aNull")
            XCTFail("Expected attempt to decode 'aNull' as String to throw and not reach here")
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
            let _ : String = try testJson.decodeValueForKey("bool")
            XCTFail("Expected attempt to decode 'bool' as String to throw and not reach here")
        }
        catch let error as SwiftyJSONDecodeError {
            swiftyJSONDecodeError = error
        }
        catch {
            XCTFail("Unknow error")
        }
        
        XCTAssertTrue(swiftyJSONDecodeError == SwiftyJSONDecodeError.ErrorForKey(key: "bool", error: SwiftyJSONDecodeError.WrongType), "")
        
        swiftyJSONDecodeError = nil
        do {
            let _ : String = try testJson.decodeValueForKey("double")
            XCTFail("Expected attempt to decode 'double' as String to throw and not reach here")
        }
        catch let error as SwiftyJSONDecodeError {
            swiftyJSONDecodeError = error
        }
        catch {
            XCTFail("Unknow error")
        }
        
        XCTAssertTrue(swiftyJSONDecodeError == SwiftyJSONDecodeError.ErrorForKey(key: "double", error: SwiftyJSONDecodeError.WrongType), "")
    }
    
}
