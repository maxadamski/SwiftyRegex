
import SwiftRegex

//: Check if contains one or more alphanumeric words
var words = "RegEx is tough, but useful."
let wordsMatcher = Regex("[a-zA-Z]+")
wordsMatcher.test(words)

//: Show which substrings match
wordsMatcher.matches(words)

//: Replace one matching substring
var greeting = "Hi <name>."
let nameMatcher = Regex("<name>")
nameMatcher.replace(greeting, with: "Jane")

//: Replace all matching substrings
var color = "I like color, color is my favourite."
var blueMatcher = Regex("color")
blueMatcher.replaceAll(color, with: "green")

//: Use shorthand operator to test for match
"http://something.com/users/13/profile" =~ "/users/[0-9]"

//: It works with Regex objects too
let userMatcher = Regex("/users/[0-9]")
"http://something.com/users/13/profile" =~ userMatcher

//: POSIX limitations
// Find four letter words
let fourLetter = Regex("\\b\\w{5}\\b")
fourLetter.matches(words)
// Sorry, POSIX regex doesn't support \b \w and others
// (at least in the OS X implementation)

