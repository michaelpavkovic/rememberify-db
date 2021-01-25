public struct Categories: Codable {
    public let categories: Pagination<Category>
}

public struct Category: Codable {
    public let id: String
    public let name: String
}
