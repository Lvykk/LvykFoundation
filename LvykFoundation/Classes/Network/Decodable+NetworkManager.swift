//
// Created by Lvyk on 2023/5/15.
//

import Foundation
import Moya

extension Decodable {
    @discardableResult
    static func request(factory: MoyaTargetFactory,
                        atKeyPath keyPath: String? = nil,
                        using decoder: JSONDecoder = JSONDecoder(),
                        failsOnEmptyData: Bool = true,
                        complete: @escaping (ResponseParsing<Self>) -> Void) -> Cancellable {
        let responseParsing: (Swift.Result<Moya.Response, MoyaError>) -> Void = { res in
            switch res {
            case let .success(response):
                do {
                    _ = try response.filterSuccessfulStatusAndRedirectCodes()
                    guard let value = try? response.map(self,
                                                        atKeyPath: keyPath,
                                                        using: decoder,
                                                        failsOnEmptyData: failsOnEmptyData) else {
                        throw NSError(domain: NSURLErrorDomain, code: 400, userInfo: [NSUnderlyingErrorKey: "Deserialization failed"])
                    }
                    complete(.success(value))
                } catch let error as MoyaError {
                    complete(.failure(error))
                } catch {
                    complete(.error(error))
                }
            case let .failure(error):
                complete(.failure(error))
            }
        }
        return NetworkManager.manager.startRequest(factory: factory, completion: responseParsing)
    }
}
