//
//  Target.swift
//  MoyaUtil
//
//  Created by Lvyk on 2023/5/19.
//

import Foundation
import Moya

final class RequestTarget: TargetType {
    var baseURL: URL { factory.requestURL }

    var path: String { factory.path }

    var method: Moya.Method { factory.method() }

    var task: Moya.Task { factory.task() }

    var headers: [String: String]? { factory.headers() }

    private let factory: MoyaTargetFactory

    init(factory: MoyaTargetFactory) {
        self.factory = factory
    }
}
