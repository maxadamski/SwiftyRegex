
infix operator =~ { precedence 130 }

public func =~ (lhs: String, rhs: String) -> Bool
{
    return Regex(rhs).matches(lhs)
}

public func =~ (lhs: String, rhs: Regex) -> Bool
{
    return rhs.matches(lhs)
}
