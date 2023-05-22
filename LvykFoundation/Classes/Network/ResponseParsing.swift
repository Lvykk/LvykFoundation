//
// Created by Lvyk on 2023/5/15.
//

import Foundation
import Moya

public enum ResponseParsing<Result> {
    case success(Result)
    case error(Error)
    case failure(MoyaError)

    var value: Result? {
        guard case .success(let result) = self else {
            return nil
        }
        return result
    }

    var moyaError: MoyaError? {
        guard case .failure(let moyaError) = self else {
            return nil
        }
        return moyaError
    }

    var error: Error? {
        guard case .error(let error) = self else {
            return nil
        }
        return error
    }

    var errorDetails: (code: Int, msg: String)? {
        switch self {
        case .success:
            return nil
        case .error(let error):
            let error = error as NSError
            return (error.code, error.localizedDescription)
        case .failure(let moyaError):
            return (moyaError.response?.statusCode ?? 0, moyaError.errorDescription!)
        }
    }
}
