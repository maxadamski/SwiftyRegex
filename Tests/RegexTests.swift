
@testable import SwiftyRegex
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
        expect(regex.test("Hello, world!")) == true
        expect(regex.test("hello, world!")) == false
    }
    
    func testItMatches_Numbers()
    {
        let regex = Regex("hello[0-9]")
        expect(regex.test("hello1")) == true
        expect(regex.test("hello")) == false
    }
    
    func testItMatches_Or_Optional()
    {
        let regex = Regex("test(ed|er)?")
        expect(regex.test("tested")) == true
        expect(regex.test("test")) == true
    }
    
    func testItMatches_IgnoreCase()
    {
        let regex = Regex("Hello, world!", flags: [.Extended, .IgnoreCase])
        expect(regex.test("Hello, world!")) == true
        expect(regex.test("hello, world!")) == true
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
    
    func testItGetsSubstrings()
    {
        let regex = Regex("hello")
        expect(regex.matches("hello, world")) == ["hello"]
    }
    
    func testItGetsSubstrings_Multiple()
    {
        let regex = Regex("hello")
        expect(regex.matches("_hello_hello")) == ["hello", "hello"]
    }
    
    func testItReplacesFirstMatch()
    {
        let regex = Regex("John")
        expect(regex.replaceIn("John Smith", with: "Ellen")) == "Ellen Smith"
    }
    
    func testItReplacesAllMatches()
    {
        let regex = Regex("2")
        expect(regex.replaceAllIn("102022", with: "1")) == "101011"
    }
    
    func testItReportsInvalidExpression()
    {
        let regex = Regex("[a-Z]")
        expect(regex.test("a")) == false
    }
    
    func testOperator()
    {
        let regex = Regex("[A-Z]")
        expect("ABC" =~ regex) == true
        expect("ABC" =~ "[A-Z]") == true
    }
}
