public struct Track: Decodable {
    public let album: Album
    public let artists: [Artist]
    public let name: String
    public let uri: String
}

public struct Album: Decodable {
    public let name: String
    public let uri: String
}

public struct Artist: Decodable {
    public let name: String
    public let uri: String
}
