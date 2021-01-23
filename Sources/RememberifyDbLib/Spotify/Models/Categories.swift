public struct Categories: Decodable {
    public let categories: Pagination<Category>
}

public struct Category: Decodable {
    public let id: String
    public let name: String
}
