// swiftlint:disable line_length

import Foundation

struct CategoriesRequest: SpotifyRequest {
    typealias Response = Categories

    let token: SpotifyAccessToken
    let country: String
    let locale: String

    func get() -> Response? {
        // Get is very similar to PlaylistRequest get, may be good to generalize in the future
        let params = [
            "country": country,
            "locale": locale,
            "limit": "50"
        ]

        let url = "https://api.spotify.com/v1/browse/categories\(getQueryString(for: params))"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("\(token.tokenType) \(token.accessToken)", forHTTPHeaderField: "Authorization")

        guard let categories = fetch(request: request, into: Categories.self) else { return nil }

        // If no additional pages need to be fetched, return early
        if categories.categories.items.count == categories.categories.total {
            return categories
        }

        var currentOffset = categories.categories.items.count

        var pages: [Categories] = []

        // Fetch additional pages of categories
        while currentOffset < categories.categories.total {
            let pageParams = [
                "country": country,
                "locale": locale,
                "limit": "\(categories.categories.limit)"
            ]

            let pageUrl = "https://api.spotify.com/v1/browse/categories\(getQueryString(for: pageParams))"
            var pageRequest = URLRequest(url: URL(string: pageUrl)!)
            pageRequest.httpMethod = "GET"
            pageRequest.addValue("\(token.tokenType) \(token.accessToken)", forHTTPHeaderField: "Authorization")

            guard let page = fetch(request: pageRequest, into: Categories.self) else { return nil }
            pages.append(page)

            currentOffset += categories.categories.limit
        }

        let items = pages.reduce([]) { (current, toAdd) in current + toAdd.categories.items }

        return Categories(categories: Pagination<Category>(items: items, limit: categories.categories.limit, total: categories.categories.total))
    }
}
