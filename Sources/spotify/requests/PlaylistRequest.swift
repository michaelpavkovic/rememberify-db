// swiftlint:disable line_length

import Foundation
import SwiftCoroutine

struct PlaylistRequest: SpotifyRequest {
    typealias Response = Playlist

    let token: SpotifyAccessToken
    let playlistId: String
    let market: String

    func get() -> Response? {
        let itemsFields = "items(track(uri,name,album(name,uri),artists(name,uri)))"

        let metadataParams = [
            "market": market,
            "fields": "name,uri,owner(display_name,uri),tracks(total,limit,\(itemsFields))"
        ]

        let url = "\("https://api.spotify.com/v1/playlists/\(playlistId)")\(getQueryString(for: metadataParams))"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("\(token.tokenType) \(token.accessToken)", forHTTPHeaderField: "Authorization")

        guard let playlist = fetch(request: request, into: Playlist.self) else { return nil }

        // If no additional pages need to be fetched, return early
        if playlist.tracks.items.count == playlist.tracks.total {
            return playlist
        }

        var currentOffset = playlist.tracks.items.count

        var pages: [PlaylistPage] = []

        // Fetch additional pages of tracks
        while currentOffset < playlist.tracks.total {
            let pageParams = [
                "market": market,
                "fields": itemsFields,
                "offset": currentOffset.description
            ]

            let pageUrl = "\("https://api.spotify.com/v1/playlists/\(playlistId)/tracks")\(getQueryString(for: pageParams))"
            var pageRequest = URLRequest(url: URL(string: pageUrl)!)
            pageRequest.httpMethod = "GET"
            pageRequest.addValue("\(token.tokenType) \(token.accessToken)", forHTTPHeaderField: "Authorization")

            guard let page = fetch(request: pageRequest, into: PlaylistPage.self) else { return nil }
            pages.append(page)

            currentOffset += playlist.tracks.limit
        }

        let items = pages.reduce([]) { (current, toAdd) in current + toAdd.items }

        return Playlist(name: playlist.name,
            owner: playlist.owner,
            tracks: PlaylistTracksInfo(items: items,
                limit: playlist.tracks.limit,
                total: playlist.tracks.total),
            uri: playlist.uri)
    }
}
