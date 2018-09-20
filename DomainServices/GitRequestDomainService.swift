import Foundation
import Moya
import Alamofire

enum GitDomainService {
    case getGitInfo
}

extension GitDomainService: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.github.com/search/") else { fatalError() }
        return url
    }
    
    var path: String {
        return "repositories"
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getGitInfo:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getGitInfo:
            return .requestParameters(parameters: ["q" : "swift"], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type" : "application/json",
                "User-Agent"   : "request"]
    }
}
