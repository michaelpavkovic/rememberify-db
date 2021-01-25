import Foundation

private let spotifyDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    return decoder
}()

public protocol SpotifyRequest {
    associatedtype Response

    var token: SpotifyAccessToken { get }

    func get() -> Response?
}

public extension SpotifyRequest {
    var decoder: JSONDecoder { return spotifyDecoder }

    func fetch<Body: Decodable>(request: URLRequest, into type: Body.Type) -> Body? {
        let dataFuture = URLSession.shared.dataTaskFuture(for: request)

        let data: Data
        do {
            data = try dataFuture.await().data
        } catch let error {
            print("[SpotifyRequest] [Network Error] \(error)")
            
            return nil
        }

        do {
            return try decoder.decode(Body.self, from: data)
        } catch let error {
            print("[SpotifyRequest] [Parsing Error] \(error)")
            print(String(data: data, encoding: .utf8) ?? "")

            return nil
        }
    }
}
