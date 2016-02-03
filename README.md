# SwiftyJSONDecodable

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

SwiftyJSONDecodable is a Swift framework that extends [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) to provide simple typesafe decoding of JSON into objects/values via the SwiftyJSONDecodable protocol and helper methods on a JSON extension.

## Requirements

- iOS 9.0+
- Xcode 7.2+

## Installation

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

To integrate SwiftyJSONDecodable into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "pollarm/SwiftyJSONDecodable"
```

Run `carthage update --platform iOS --no-use-binaries` to build the framework and it's dependencies and drag the built `SwiftyJSON.framework and SwiftyJSONDecodable.framework` into your Xcode project.


## Getting started

At the heart of the SwiftyJSONDecodable framework is the SwiftyJSONDecodable protocol:

```swift
/// Conform to this if you can be instantiated from a json representation
/// in the form of a SwiftyJSON.JSON
public protocol SwiftyJSONDecodable {

    /// An initialiser that take a JSON and throws
    ///
    /// The intention here is that the implementation can `throw` if the json
    /// is malformatted, missing required fields etc.
    init(json: JSON) throws

}
```

Extensions on Int, String, Double, Bool are provided in the framework.

An extension on SwiftyJSON provides the following helper methods:

```swift
public func decodeArrayForKey<T: SwiftyJSONDecodable>(key: String) throws -> Array<T>?

public func decodeArrayForKey<T: SwiftyJSONDecodable>(key: String) throws -> Array<T>

public func decodeValueForKey<T: SwiftyJSONDecodable>(key: String) throws -> T?

public func decodeValueForKey<T: SwiftyJSONDecodable>(key: String) throws -> T

public func decodeAsValue<T: SwiftyJSONDecodable>() throws -> T?

public func decodeAsValue<T: SwiftyJSONDecodable>() throws -> T

public func decodeAsDictionaryForKey<V: SwiftyJSONDecodable>(key: String) throws -> Dictionary<String, V>
```

## Example

Say you have the following json that you want to decode into values:

```
{
    person: {
        firstName: "Tim",
        surname: "Cook",
        address: {
            line1: "1 Infinite Loop"
            line2: "null"
            city: "Cupertino"
    }
}
```

And the following types you want to create:

```swift
struct Person {
    let firstName : String
    let surname : String
    let address : Address
}

struct Address {
    let line1 : String
    let line2 : String?
    let city : String
```

SwiftyJSONDecodable allows you to define the following:

```swift
extension Person : SwiftyJSONDecodable {

    init(json: JONS) throws {
        firstName = try json.decodeValueFromKey("firstName")
        surname = try json.decodeValueFromKey("surname")
        address = try json.decodeValueFromKey("address")
    }
}

extension Address : SwiftyJSONDecodable {

    init(json: JONS) throws {
        line1 = try json.decodeValueFromKey("line1")
        line2 = try json.decodeValueFromKey("line2")
        city = try json.decodeValueFromKey("city")
    }
}
```

Then:

```swift
let person : Person = try json.decodeValueFromKey("person")
```

As you can see you can nest complex types as long as they conform to SwiftyJSONDecodable.

The reason to use the helper functions on JSON such as `decodeValueFromKey` rather than use the initializer directly is that the keys can then be built into a keypath as the levels are decoded. This allows detailed error reporting in the ErrorType thrown.

The following `ErrorType` is used
```swift
public indirect enum SwiftyJSONDecodeError : ErrorType {

case NullValue
case WrongType
case InvalidValue(String?)
case ErrorForKey(key: String, error: SwiftyJSONDecodeError)
}
```

So for example if `line2` in `Address` was made non-optional, the attempt to decode the above example would result in a SwiftyJSONDecodeError.ErrorForKey being thrown with the following debugDescription: 'person.address.line2.NullValue'