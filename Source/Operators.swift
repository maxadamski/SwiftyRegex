
infix operator =~ { precedence 130 }

/// Checks if string on the left matches expression on the right.
public func =~ (lhs: String, rhs: String) -> Bool
{
    return Regex(rhs).test(lhs)
}

/// Checks if string on the left matches expression on the right.
public func =~ (lhs: String, rhs: Regex) -> Bool
{
    return rhs.test(lhs)
}
