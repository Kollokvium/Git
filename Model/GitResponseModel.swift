import Foundation

struct GitResponseModel: Decodable {
    let items: [Items]?
    
    enum CodingKeys: String, CodingKey {
        case items = "items"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        items = try values.decodeIfPresent([Items].self, forKey: .items)
    }
}

struct Owner: Decodable {
    let avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl)
    }
}

struct Items: Decodable {
    let owner: Owner?
    let fullName: String
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case description = "description"
        case owner = "owner"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fullName = try values.decode(String.self, forKey: .fullName)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        owner = try values.decodeIfPresent(Owner.self, forKey: .owner)
    }
}
