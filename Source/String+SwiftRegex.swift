
extension String
{
    init(bytes: [UInt8])
    {
        self = bytes.reduce("") {
            $0 + String(UnicodeScalar($1))
        }
    }
    
    init(bytes: [Int8])
    {
        let uBytes = bytes.map { UInt8($0) }
        self = String(bytes: uBytes)
    }
    
    mutating func replaceRange(range: Range<Int>, with sub: String)
    {
        let s = startIndex.advancedBy(range.startIndex)
        let e = startIndex.advancedBy(range.endIndex)
        replaceRange(s..<e, with: sub)
    }
    
    func substringWithRange(range: Range<Int>) -> String
    {
        let s = startIndex.advancedBy(range.startIndex)
        let e = startIndex.advancedBy(range.endIndex)
        return substringWithRange(s..<e)
    }
}
