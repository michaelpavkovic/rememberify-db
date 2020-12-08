import Foundation

/// Access token response from Spotify's authorization endpoint
struct SpotifyAccessToken: Decodable {
    /// Token used for accessing spotify web API
    let accessToken: String

    /// Type of `accessToken`
    let tokenType: String

    /// `accessToken` lifetime in seconds
    let expiresIn: Int

    /// Scope (abilities) of `accessToken`
    let scope: String

    static func from(_ data: Data) -> SpotifyAccessToken? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return try? decoder.decode(SpotifyAccessToken.self, from: data)
    }

    static func getAccessToken(_ id: String, _ secret: String) -> SpotifyAccessToken? {
        var request = URLRequest(url: URL(string: "https://accounts.spotify.com/api/token")!)

        let encoded = "\(id):\(secret)".toBase64()

        request.httpMethod = "POST"
        request.addValue("Basic \(encoded)", forHTTPHeaderField: "Authorization")
        request.httpBody = "grant_type=client_credentials".data(using: .utf8)

        let dataFuture = URLSession.shared.dataTaskFuture(for: request)
        if let data = try? dataFuture.await().data {
            return SpotifyAccessToken.from(data)
        } else {
            return nil
        }
    }
}
