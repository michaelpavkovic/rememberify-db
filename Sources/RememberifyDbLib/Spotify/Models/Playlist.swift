public struct Playlist: Codable {
    public let name: String
    public let owner: PlaylistOwner
    public let tracks: Pagination<PlaylistItem>
    public let uri: String
}

public struct PlaylistCollection: Codable {
    public let playlists: Pagination<Playlist>
}

public struct PlaylistOwner: Codable {
    public let displayName: String
    public let uri: String
}

public struct PlaylistPage: Codable {
    public let items: [PlaylistItem]
}

public struct PlaylistItem: Codable {
    public let track: Track
}
