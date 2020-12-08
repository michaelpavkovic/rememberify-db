struct Track: Decodable {
    let album: Album
    let artists: [Artist]
    let name: String
    let uri: String
}

struct Album: Decodable {
    let name: String
    let uri: String
}

struct Artist: Decodable {
    let name: String
    let uri: String
}
