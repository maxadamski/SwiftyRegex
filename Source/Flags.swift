
import Darwin

public extension Regex
{
    public struct Flags: OptionSetType
    {
        public let rawValue: Int32
        
        public init(rawValue: Int32)
        {
            self.rawValue = rawValue
        }
        
        /// Do not differentiate case.
        public static let IgnoreCase = Flags(rawValue: REG_ICASE)
        
        /// Use POSIX Extended Regular Expression syntax.
        public static let Extended = Flags(rawValue: REG_EXTENDED)
        
        /// Treat a newline in string as dividing string into multiple lines, so that `$` can match before the newline and `^` can match after. Also, don't permit `.` to match a newline, and don't permit `[^...]` to match a newline.
        public static let Newline = Flags(rawValue: REG_NEWLINE)
        
        /// Do not report position of matches.
        public static let NoRanges = Flags(rawValue: REG_NOSUB)
    }
}
