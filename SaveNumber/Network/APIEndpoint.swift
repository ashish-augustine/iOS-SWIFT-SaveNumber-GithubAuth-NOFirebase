//
//  APIEndpoint.swift
//  SaveNumber
//
//  Created by Benjamin Wong on 2024/5/14.
//

import Foundation
import Foundation
import Moya

enum APIEndpoint {
  case getNumber
  case saveNumber(String)
}

extension APIEndpoint: TargetType {
  var baseURL: URL {
    return Constant.baseURL
  }
  
  var path: String {
    switch self {
    case .getNumber:
      return "/user/getNumber"
    case .saveNumber:
      return "/user/saveNumber"
    }
  }
  
  var method: Moya.Method {
    return .get
  }
  
  var task: Moya.Task {
    switch self {
    case .getNumber:
      return .requestPlain
    case .saveNumber(let number):
      return .requestParameters(parameters: ["number": number], encoding: URLEncoding.default)
    }
  }
  
  var headers: [String : String]? {
    if let token = Client.shared.accessToken, let userID = Client.shared.userID {
      return ["Authorization": "Bearer \(token)", "user-id": userID]
    } else {
      return nil
    }
  }
}
