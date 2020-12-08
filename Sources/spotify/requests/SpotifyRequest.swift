import Foundation

private let spotifyDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    return decoder
}()

protocol SpotifyRequest {
    associatedtype Response

    var token: SpotifyAccessToken { get }

    func get() -> Response?
}

extension SpotifyRequest {
    var decoder: JSONDecoder { return spotifyDecoder }

    func fetch<Body: Decodable>(request: URLRequest, into type: Body.Type) -> Body? {
        let dataFuture = URLSession.shared.dataTaskFuture(for: request)

        do {
            let data = try dataFuture.await().data

            return try? decoder.decode(Body.self, from: data)
        } catch let error {
            // TODO: print it for real
            print(error)
        }

        return nil
    }
}
