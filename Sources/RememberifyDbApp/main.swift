import Foundation
import RememberifyDbLib

let coroutineDispatchQueue = DispatchQueue(label: "com.rememberify.rememberify-db.coroutine-dispatch-queue")

func main() {
    guard let spotifyAccessToken = SpotifyAccessToken.getAccessToken(spotifyClientId, spotifyClientSecret) else {
        print("Cannot authenticate spotify")
        return
    }

    print(spotifyAccessToken.accessToken)

    let request = PlaylistRequest(token: spotifyAccessToken, playlistId: "6142ikHFmQeIqgwv2xKltV", market: "US")
    let request2 = CategoriesRequest(token: spotifyAccessToken, country: "US", locale: "en_US")

    if let playlist = request.get() {
        print(playlist)
    }

    if let categories = request2.get() {
        categories.categories.items.forEach { print($0.id) }
    }
}

runBlocking(in: coroutineDispatchQueue, main)
