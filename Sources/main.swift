import Foundation
import SwiftCoroutine

let semaphore = DispatchSemaphore(value: 0)
let coroutineDispatchQueue = DispatchQueue(label: "com.rememberify.rememberify-db.coroutine-dispatch-queue")

func main() {
    defer {
        semaphore.signal()
    }

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
        print(categories)
    }
}

coroutineDispatchQueue.startCoroutine {
    main()
}

semaphore.wait()
