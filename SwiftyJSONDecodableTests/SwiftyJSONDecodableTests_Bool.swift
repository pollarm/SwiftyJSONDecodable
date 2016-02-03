//
//  SwiftyJSONDecodableTests.swift
//  SwiftyJSONDecodableTests
//
//  Created by Mike Pollard on 02/02/2016.
//  Copyright © 2016 Mike Pollard. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import SwiftyJSONDecodable

class SwiftyJSONDecodableTests_Bool: XCTestCase {
    
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
    
    func testBool() {

        do{
            let b : Bool = try testJson.decodeValueForKey("bool")
            XCTAssert(b == true, "Expected 'bool' to decode as true")
            
        }
        catch let error as CustomDebugStringConvertible {
            XCTFail(error.debugDescription)
        }
        catch {
            XCTFail("Unknow error")
        }
        
        
    }
    
    func testOptionalBool() {
        
        do{
            let b2 : Bool? = try testJson.decodeValueForKey("bool2")
            XCTAssert(b2 == nil, "Expected 'bool2' to decode as nil")
            
            let b3 : Bool? = try testJson.decodeValueForKey("aNull")
            XCTAssert(b3 == nil, "Expected 'aNull' to decode as nil")
            
        }
        catch let error as CustomDebugStringConvertible {
            XCTFail(error.debugDescription)
        }
        catch {
            XCTFail("Unknow error")
        }
    }
    
    func testBoolFailures() {
        
        var swiftyJSONDecodeError : SwiftyJSONDecodeError?
        do {
            let _ : Bool? = try testJson.decodeValueForKey("int")
            XCTFail("Expected attempt to decode 'int' as bool to throw and not reach here")
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
            let _ : Bool = try testJson.decodeValueForKey("aNull")
            XCTFail("Expected attempt to decode 'aNull' as bool to throw and not reach here")
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
            let _ : Bool = try testJson.decodeValueForKey("int")
            XCTFail("Expected attempt to decode 'int' as bool to throw and not reach here")
        }
        catch let error as SwiftyJSONDecodeError {
            swiftyJSONDecodeError = error
        }
        catch {
            XCTFail("Unknow error")
        }
        
        XCTAssertTrue(swiftyJSONDecodeError == SwiftyJSONDecodeError.ErrorForKey(key: "int", error: SwiftyJSONDecodeError.WrongType), "")
    }

    
}
