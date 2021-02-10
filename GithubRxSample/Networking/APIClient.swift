//
//  APIClient.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 15/12/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import Moya

extension APIClient {
    static var provider: Provider {
        let configuration = NetworkLoggerPlugin.Configuration(logOptions: [.requestMethod])
        let plugin = NetworkLoggerPlugin(configuration: configuration)
        let provider = Provider(plugins: [plugin])
        return provider
    }
}

enum APIClient {
    case repositories(_ language: String, _ page: Int)
    case commits(_ repository: String)
    case commitInfo(repository: String, hash: String)
}

extension APIClient: TargetType {
    var baseURL: URL {
        return URL(string: APIEnviroment.base)!
    }

    var path: String {
        switch self {
        case .repositories:
            return "search/repositories"
        case .commits(let repository):
            return "repos/\(repository)/commits"
        case let .commitInfo(repository, hash):
            return "\(repository)/commit/\(hash)"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        switch self {
        case .repositories: return stub(.repositories)
        case .commits:      return stub(.commits)
        case .commitInfo:   return stub(.commitInfo)
        }
    }

    var task: Task {
        if case .repositories = self {
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}

private extension APIClient {
    enum APIEnviroment {
        static let base = "https://api.github.com/"
    }
    
    var parameters: [String : Any] {
        if case let .repositories(language, page) = self {
            return ["sort"     : "stars",
                    "order"    : "desc",
                    "q"        : "language:\(language)",
                    "page"     : page,
                    "per_page" : 20]
        }
        return [.empty : String.empty]
    }
}

//MARK: Stubbed response

private extension APIClient {
    enum StubName: String {
        case repositories, commits, commitInfo
    }
    
    func stub(_ name: StubName) -> Data {
        let path = { () -> URL? in
            switch name {
            case .repositories: return R.file.repositoriesJson()
            case .commits:      return R.file.commitsJson()
            case .commitInfo:   return R.file.commitInfoJson()
            }
        }()
        
        if path == nil {
            return .empty
        }
        
        let data = try? Data(contentsOf: path!)
        
        return data.orEmpty
    }
}
