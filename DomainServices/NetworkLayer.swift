import Foundation
import Moya

struct NetworkLayer {
    let provider = MoyaProvider<GitDomainService>()

    func getGitInfo(completion: @escaping (_ result: GitResponseModel?, _ error: Error?) -> ()) {
        provider.request(.getGitInfo) { result in
            switch result {
            case .success(let data):
                do {
                    let filteredResponse = try data.filterSuccessfulStatusCodes()
                    let gitInfoModel = try filteredResponse.map(GitResponseModel.self)
                    completion(gitInfoModel, nil)
                } catch {
                    print("Status Code: \(data.statusCode) Error: \(error.localizedDescription)")
                    completion(nil, result.error)
                }
            case .failure(let failure):
                completion(nil, failure)
            }
        }
    }
}
