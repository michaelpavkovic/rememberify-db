struct Playlist: Decodable {
    let name: String
    let owner: PlaylistOwner
    let tracks: Pagination<PlaylistItem>
    let uri: String
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
