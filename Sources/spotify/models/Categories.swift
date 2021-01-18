struct Categories: Decodable {
    let categories: Pagination<Category>
}

struct Category: Decodable {
    let id: String
    let name: String
}
