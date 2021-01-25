public struct Track: Codable {
    public let album: Album
    public let artists: [Artist]
    public let name: String
    public let uri: String
}

public struct Album: Codable {
    public let name: String
    public let uri: String
}

public struct Artist: Codable {
    public let name: String
    public let uri: String
}
