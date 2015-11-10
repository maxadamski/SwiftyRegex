# SwiftyRegex [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

SwiftyRegex is a regular expression micro framework written in pure Swift. The goal is to make it compatible with Linux and other POSIX compliant systems. Of course don’t use it in apps where you have access to NSRegularExpression.

# Example

```swift
// Use shorthand operator to test for match
"http://something.com/users/13/profile" =~ "/users/[0-9]"

// Get matching substrings
let words = "RegEx is tough, but useful."
Regex("[a-zA-Z]+").matches(words)

// Replace matching substring
Regex("<name>").replace("Hi <name>.", with: "Jane")
```

For more see `Playground.playground`

# License

MIT. See the `LICENSE` for details.
