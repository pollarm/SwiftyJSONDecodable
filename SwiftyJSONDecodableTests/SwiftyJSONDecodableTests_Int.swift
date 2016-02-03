//
//  SwiftyJSONDecodableTests_Int.swift
//  SwiftyJSONDecodable
//
//  Created by Mike Pollard on 03/02/2016.
//  Copyright © 2016 Mike Pollard. All rights reserved.
//

import XCTest
import XCTest
import SwiftyJSON
@testable import SwiftyJSONDecodable

class SwiftyJSONDecodableTests_Int: XCTestCase {
    
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
    
    func testInt() {
        
        do{
            let i : Int = try testJson.decodeValueForKey("int")
            XCTAssert(i == 42, "Expected 'int' to decode as 42")
            
        }
        catch let error as CustomDebugStringConvertible {
            XCTFail(error.debugDescription)
        }
        catch {
            XCTFail("Unknow error")
        }
        
        
    }
    
    func testOptionalInt() {
        
        do{
            let i2 : Int? = try testJson.decodeValueForKey("int2")
            XCTAssert(i2 == nil, "Expected 'int2' to decode as nil")
            
            let i3 : Int? = try testJson.decodeValueForKey("aNull")
            XCTAssert(i3 == nil, "Expected 'aNull' to decode as nil")
            
        }
        catch let error as CustomDebugStringConvertible {
            XCTFail(error.debugDescription)
        }
        catch {
            XCTFail("Unknow error")
        }
    }
    
    func testIntFailures() {
        
        var swiftyJSONDecodeError : SwiftyJSONDecodeError?
        do {
            let _ : Int? = try testJson.decodeValueForKey("string")
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
            let _ : Int = try testJson.decodeValueForKey("aNull")
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
            let _ : Int = try testJson.decodeValueForKey("bool")
            XCTFail("Expected attempt to decode 'bool' as Int to throw and not reach here")
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
            let i_: Int = try testJson.decodeValueForKey("double")
            XCTFail("Expected attempt to decode 'double' as Int to throw and not reach here")
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
