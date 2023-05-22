//
// Created by Lvyk on 2023/5/15.
//

import Foundation
import Alamofire
import Moya

public final class NetworkManager {
    public static let manager = NetworkManager()

    private lazy var session: Moya.Session = {
        var serverTrustPolicies: [String: ServerTrustEvaluating] = [:]
        let manager = ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: serverTrustPolicies)
        return Moya.Session(serverTrustManager: manager)
    }()

    static func updateSession(for newSession: Moya.Session) {
        manager.session = newSession
    }

    public func startRequest(factory: MoyaTargetFactory,
                             progress: ProgressBlock? = .none,
                             queue: DispatchQueue? = .none,
                             completion: @escaping Moya.Completion) -> Cancellable {
        let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
            do {
                var request = try endpoint.urlRequest()
                request.timeoutInterval = factory.overTime
                done(.success(request))
            } catch {
                done(.failure(MoyaError.underlying(error, nil)))
            }
        }

        let target = RequestTarget(factory: factory)

        let provider = MoyaProvider<RequestTarget>(requestClosure: requestClosure, session: session, plugins: factory.plugins)

        return provider.request(target, callbackQueue: queue, progress: progress, completion: completion)
    }
}
