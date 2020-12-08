struct Playlist: Decodable {
    let name: String
    let owner: PlaylistOwner
    let tracks: PlaylistTracksInfo
    let uri: String
}

struct PlaylistTracksInfo: Decodable {
    let items: [PlaylistItem]
    let limit: Int
    let total: Int
}

struct PlaylistOwner: Decodable {
    let displayName: String
    let uri: String
}

struct PlaylistPage: Decodable {
    let items: [PlaylistItem]
}

struct PlaylistItem: Decodable {
    let track: Track
}
