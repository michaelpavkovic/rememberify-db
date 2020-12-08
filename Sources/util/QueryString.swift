import Foundation

public func urlEncode(_ string: String) -> String? {
    return string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
}

public func getQueryString(for params: [String: CustomStringConvertible]) -> String {
    return params
        .map { (key, value) in
            "\(urlEncode(key)!)=\(urlEncode(value.description)!)&"
        }
        .reduce("?", +)
        .dropLast()
        .description
}
