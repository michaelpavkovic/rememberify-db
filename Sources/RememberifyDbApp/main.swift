import Foundation
import RememberifyDbLib
import SwiftCoroutine

let coroutineDispatchQueue = DispatchQueue(label: "com.rememberify.rememberify-db.coroutine-dispatch-queue")

func main() {
    guard let spotifyAccessToken = SpotifyAccessToken.getAccessToken(spotifyClientId, spotifyClientSecret) else {
        print("Cannot authenticate spotify")
        return
    }

    print(spotifyAccessToken.accessToken)
    let categoriesRequest = CategoriesRequest(token: spotifyAccessToken, country: "US", locale: "en_US")

    if let categories = categoriesRequest.get() {
        var playlists: [Playlist] = []
        for category in categories.categories.items! {
            let playlistsRequest = CategoryPlaylistsRequest(token: spotifyAccessToken,
                categoryId: category.id, country: "SE")

            do {
                try Coroutine.delay(.milliseconds(100))
            } catch _ {}

            if let playlistsInCategory = playlistsRequest.get(), let items = playlistsInCategory.playlists.items {
                playlists.append(contentsOf: items)
            } else {
                print("Error getting category: \(category.id)")
            }
        }

        print(playlists.count)

        do {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            encoder.outputFormatting = .prettyPrinted

            if let data = try? encoder.encode(playlists) {
                do {
                    try data.write(to: FileManager.default.urls(for: .desktopDirectory,
                        in: .userDomainMask)[0].appendingPathComponent("playlists.json"))
                } catch let error {
                    print(error)
                }
            }
        }
    }
}

runBlocking(in: coroutineDispatchQueue, main)
