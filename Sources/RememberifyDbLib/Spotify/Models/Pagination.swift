///
/// A struct representing a paginated response in the Spotify Web API
///
public struct Pagination<PaginatedItem: Codable>: Codable {
    public let items: [PaginatedItem]?
    public let limit: Int?
    public let total: Int
}
