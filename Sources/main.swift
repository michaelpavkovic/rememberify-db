import Foundation

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

    if let playlist = request.get() {
        print(playlist)
    }
}

coroutineDispatchQueue.startCoroutine {
    main()
}

semaphore.wait()
