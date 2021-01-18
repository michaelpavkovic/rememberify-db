///
/// A struct representing a paginated response in the Spotify Web API
///
struct Pagination<PaginatedItem: Decodable>: Decodable {
    let items: [PaginatedItem]
    let limit: Int
    let total: Int
}
