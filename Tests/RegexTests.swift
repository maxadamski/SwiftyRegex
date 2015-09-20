
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
    
    func testItMatches()
    {
        let regex = Regex("Hello, world!")
        expect(regex.matches("Hello, world!")) == true
        expect(regex.matches("hello, world!")) == false
    }
    
    func testItMatches_Numbers()
    {
        let regex = Regex("hello[0-9]")
        expect(regex.matches("hello1")) == true
        expect(regex.matches("hello")) == false
    }
    
    func testItMatches_Or_Optional()
    {
        let regex = Regex("test(ed|er)?")
        expect(regex.matches("tested")) == true
        expect(regex.matches("test")) == true
    }
    
    func testItMatches_IgnoreCase()
    {
        let regex = Regex("Hello, world!", flags: [.Extended, .IgnoreCase])
        expect(regex.matches("Hello, world!")) == true
        expect(regex.matches("hello, world!")) == true
    }
    
    func testItGetsRange()
    {
        let regex = Regex("hello")
        expect(regex.ranges("hello, world")) == [0...4]
    }
    
    func testItGetsRange_Multiple()
    {
        let regex = Regex("hello")
        expect(regex.ranges("_hello_hello")) == [1...5, 7...11]
    }
    
    func testItReportsInvalidExpression()
    {
        let regex = Regex("[a-Z]")
        expect(regex.matches("a")) == false
    }
    
    func testOperator()
    {
        let regex = Regex("[A-Z]")
        expect("ABC" =~ regex) == true
        expect("ABC" =~ "[A-Z]") == true
    }
}
