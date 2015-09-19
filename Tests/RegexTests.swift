
@testable import SwiftRegex
import Nimble
import XCTest

class RegexTests: XCTestCase
{
    func testItCreates()
    {
        let regex = Regex("hello")
        expect(regex.expression) == "hello"
        expect(regex.flags) == [.Extended]
    }
}
