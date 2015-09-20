
@testable import SwiftRegex
import Nimble
import XCTest

class StringTests: XCTestCase
{
    func testItCreatesWithBytes()
    {
        let bytes: [Int8] = [0x0068, 0x0065, 0x006C, 0x006C, 0x006F]
        expect(String(bytes: bytes)) == "hello"
        
        let uBytes = bytes.map { UInt8($0) }
        expect(String(bytes: uBytes)) == "hello"
    }
    
    func testItReplacesWithRange()
    {
        var str = "John Smith"
        str.replaceRange(0...3, with: "Ellen")
        expect(str) == "Ellen Smith"
    }
    
    func testItGetsSubstringWithRange()
    {
        let str = "John Smith"
        let sub = str.substringWithRange(0...3)
        expect(sub) == "John"
    }
}
