//
//  POSTTargetFactory.swift
//  MoyaUtil
//
//  Created by Lvyk on 2023/5/19.
//

import Foundation
import Moya

class POSTFactory: BaseTargetFactory {
    override func method() -> Moya.Method {
        .post
    }

    override func task() -> Task {
        .requestCompositeParameters(bodyParameters: bodyValue,
                                    bodyEncoding: JSONEncoding.default,
                                    urlParameters: paramsValue)
    }

    override func headers() -> [String: String] {
        var headerDic = super.headers()
        headerDic["Content-Type"] = "application/json"
        return headerDic
    }
}
