
import Darwin

public struct Regex
{
    public var expression: String
    public var flags: Flags
    
    public init(_ expression: String, flags: Flags = [.Extended])
    {
        self.expression = expression
        self.flags = flags
    }
}
