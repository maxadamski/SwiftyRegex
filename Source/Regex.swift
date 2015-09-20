
import Darwin

/// POSIX Regular Expression wrapper structure.
public struct Regex
{
    typealias CMatch = regmatch_t
    typealias CRegex = regex_t
    
    public var expression: String
    public var flags: Flags

    public init(_ expression: String, flags: Flags = [.Extended])
    {
        self.expression = expression
        self.flags = flags
    }
    
    /// Returns compiled expression
    func compile() -> CRegex
    {
        var cRegex = CRegex()
        let result = regcomp(&cRegex, expression, flags.rawValue)
        if result != 0 {
            var buffer = [Int8](count: 128, repeatedValue: 0)
            regerror(result, &cRegex, &buffer, sizeof(buffer.dynamicType))
            let error = buffer.reduce("") { $0 + String(UnicodeScalar(UInt8($1))) }
            print("@Regex.compile() - Compilation error { \(error) }")
        }
        return cRegex
    }
    
    /// Checks if given string matches expression.
    /// - returns:
    ///     * isMatching - true if string matches expression
    ///     * range - first matching substring range
    func match(string: String) -> (matches: Bool, range: Range<Int>?)
    {
        var cMatches = [CMatch()]
        var cRegex = compile()
        
        defer { regfree(&cRegex) }
        
        let result = regexec(&cRegex, string, 1, &cMatches, 0)
        if result == 0 {
            // String matching
            let s = Int(cMatches.first!.rm_so)
            let e = Int(cMatches.first!.rm_eo)
            return (true, s..<e)
        } else if result == REG_NOMATCH {
            // String not matching
            return (false, nil)
        } else {
            var buffer = [Int8](count: 128, repeatedValue: 0)
            regerror(result, &cRegex, &buffer, sizeof(buffer.dynamicType))
            let error = buffer.reduce("") { $0 + String(UnicodeScalar(UInt8($1))) }
            print("@Regex.match() - Execution error { \(error) }")
            return (false, nil)
        }
    }

    /// - returns: Matching substring ranges.
    public func ranges(var string: String) -> [Range<Int>]
    {
        var ranges = [Range<Int>]()
        var offset = 0
        while var range = match(string).range {
            // Delete match from string
            let s = string.startIndex.advancedBy(range.startIndex)
            let e = string.startIndex.advancedBy(range.endIndex)
            string.replaceRange(s..<e, with: "")
            
            range.startIndex += offset
            range.endIndex += offset
            ranges.append(range)
            offset += range.endIndex - range.startIndex
        }
        return ranges
    }
    
    /// - returns: Matching substrings.
    public func matches(string: String) -> [String]
    {
        let ranges = self.ranges(string)
        var matches = [String]()
        for r in ranges {
            let s = string.startIndex.advancedBy(r.startIndex)
            let e = string.startIndex.advancedBy(r.endIndex)
            matches.append(string.substringWithRange(s..<e))
        }
        return matches
    }
    
    /// - returns: `string` with the first matching substring replaced by `sub`.
    public func replace(var string: String, with sub: String) -> String
    {
        let match = self.match(string)
        if match.matches == true && match.range != nil {
            let s = string.startIndex.advancedBy(match.range!.startIndex)
            let e = string.startIndex.advancedBy(match.range!.endIndex)
            string.replaceRange(s..<e, with: sub)
        }
        return string
    }
    
    /// - returns: `string` with all matching substrings replaced by `sub`.
    public func replaceAll(var string: String, with sub: String) -> String
    {
        let ranges = self.ranges(string)
        for r in ranges {
            let s = string.startIndex.advancedBy(r.startIndex)
            let e = string.startIndex.advancedBy(r.endIndex)
            string.replaceRange(s..<e, with: sub)
        }
        return string
    }
    
    /// Checks if given string matches expression.
    public func test(string: String) -> Bool
    {
        return match(string).matches
    }
}
