//
//  Client.swift
//  SaveNumber
//
//  Created by Ashish Augustine on 2024/5/14.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import Alamofire
import SafariServices
import SwifterSwift

class Client {
  static let shared = Client()
  var currentUser: BehaviorRelay<User?> = BehaviorRelay(value: nil)
  var accessToken: String? {
    return currentUser.value?.githubAccessToken
  }
  var userID: String? {
    return currentUser.value?.id
  }
  var logined: Bool = false
  var disposeBag = DisposeBag()
  var apiProvider: MoyaProvider<MultiTarget>
  var apiProviderCallbackQueue: DispatchQueue
  var apiProviderCallbackScheduler: ConcurrentDispatchQueueScheduler
  
  private init() {
    let configuration = URLSessionConfiguration.default
    configuration.headers = .default
    let session = Alamofire.Session(
      configuration: configuration,
      startRequestsImmediately: false)
    apiProvider = MoyaProvider(session: session, plugins: [NetworkLoggerPlugin(configuration: .init(output: Client._moyaLoggerOutput, logOptions: .verbose))])
    apiProviderCallbackQueue = DispatchQueue(label: "com.iBenjamin.SaveNumber.API-callback-queue", qos: .userInteractive, attributes: .concurrent)
    apiProviderCallbackScheduler = ConcurrentDispatchQueueScheduler(queue: apiProviderCallbackQueue)
  }
  
  func login(viewController: UIViewController) {
    let url = Constant.baseURL.appending(path: "/login/github")
    UIApplication.shared.openURL(url)
  }
  
  func saveNumber(number: String) -> Completable {
    let endpoint = APIEndpoint.saveNumber(number).asMultiTarget
    return apiProvider.rx.request(endpoint).asCompletable().do(onCompleted: { [weak self] in
      guard let self = self, var user = self.currentUser.value else {
        return
      }
      user.myNumber = number
      self.currentUser.accept(user)
    })
  }
  
  func getNumber() -> Single<Int?> {
    let endpoint = APIEndpoint.getNumber.asMultiTarget
    return apiProvider.rx.request(endpoint).map(Int?.self)
  }
  
  @discardableResult
  func handleOpen(url: URL) -> Bool {
    print(url)
    if url.scheme == "com.ibenjamin.savenumber" && url.host == "auth" && url.path == "/github" {
      guard let queryItems = url.queryParameters, let id = queryItems["id"],
            let name = queryItems["name"], let githubAccessToken = queryItems["githubAccessToken"],
            let githubId = queryItems["githubId"] else {
        print("error")
        return true
      }
      print("query: \(queryItems)")
      let myNumber: String? = queryItems["myNumber"]
      let user = User(id: id, name: name, myNumber: myNumber, githubAccessToken: githubAccessToken, githubId: githubId.int)
      currentUser.accept(user)
      return true
    } else {
      return true
    }
  }
  
  // MARK: - Private
  private static var _moyaLoggerOutput: (TargetType, [String]) -> Void =  { targetType, items in
  #if DEBUG
    print(items.joined(separator: ","))
  #endif
  }
}
