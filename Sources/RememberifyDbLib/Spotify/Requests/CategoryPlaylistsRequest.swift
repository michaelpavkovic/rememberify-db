// swiftlint:disable line_length

import Foundation

public struct CategoryPlaylistsRequest: SpotifyRequest {
    public typealias Response = PlaylistCollection

    public let token: SpotifyAccessToken
    public let categoryId: String
    public let country: String
    

    public init(token: SpotifyAccessToken, categoryId: String, country: String) {
        self.token = token
        self.categoryId = categoryId
        self.country = country
        
    }

    public func get() -> Response? {
        // Get is very similar to PlaylistRequest get, may be good to generalize in the future
        let params = [
            "country": country,
            "limit": "50"
        ]

        let url = "https://api.spotify.com/v1/browse/categories/\(categoryId)/playlists\(getQueryString(for: params))"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("\(token.tokenType) \(token.accessToken)", forHTTPHeaderField: "Authorization")

        guard let playlists = fetch(request: request, into: PlaylistCollection.self) else { return nil }

        // If no additional pages need to be fetched, return early
        if playlists.playlists.items!.count == playlists.playlists.total {
            return playlists
        }

        var currentOffset = playlists.playlists.items!.count

        var pages: [[Playlist]] = [playlists.playlists.items!]

        // Fetch additional pages of playlists
        while currentOffset < playlists.playlists.total {
            let pageParams = [
                "country": country,
                "limit": playlists.playlists.limit!.description,
                "offset": currentOffset.description
            ]

            let pageUrl = "https://api.spotify.com/v1/browse/categories/\(categoryId)/playlists\(getQueryString(for: pageParams))"
            var pageRequest = URLRequest(url: URL(string: pageUrl)!)
            pageRequest.httpMethod = "GET"
            pageRequest.addValue("\(token.tokenType) \(token.accessToken)", forHTTPHeaderField: "Authorization")

            guard let page = fetch(request: pageRequest, into: PlaylistCollection.self) else { return nil }
            pages.append(page.playlists.items!)

            currentOffset += playlists.playlists.limit!
        }

        return PlaylistCollection(playlists: Pagination<Playlist>(items: pages.flatMap { $0 },
            limit: playlists.playlists.limit, total: playlists.playlists.total))
    }
}
