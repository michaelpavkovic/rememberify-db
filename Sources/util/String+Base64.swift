import Foundation

public extension String {
    func toBase64() -> String {
        return Data(utf8).base64EncodedString()
    }
}
