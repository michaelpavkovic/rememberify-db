public struct Playlist: Decodable {
    public let name: String
    public let owner: PlaylistOwner
    public let tracks: Pagination<PlaylistItem>
    public let uri: String
}

public struct PlaylistOwner: Decodable {
    public let displayName: String
    public let uri: String
}

public struct PlaylistPage: Decodable {
    public let items: [PlaylistItem]
}

public struct PlaylistItem: Decodable {
    public let track: Track
}
