
import Darwin

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
    
    public func matches(string: String) -> Bool
    {
        return match(string).matches
    }
}
