//
//  BAseTargetFactory.swift
//  MoyaUtil
//
//  Created by Lvyk on 2023/5/19.
//

import Foundation
import Moya

class BaseTargetFactory: MoyaTargetFactory {
    private(set) var path: String = ""
    private(set) var overTime: TimeInterval = 15.0
    private(set) var plugins: [Moya.PluginType] = []

    let requestURL: URL
    let paramsValue: [String: Any]
    let bodyValue: [String: Any]

    init?(baseURL: String,
          path: String = "",
          params: [String: Any] = [:],
          body: [String: Any] = [:],
          overTime: TimeInterval = 15.0,
          plugins: [Moya.PluginType] = []) {
        guard let url = URL(string: baseURL) else {
            return nil
        }
        self.requestURL = url
        self.path = path
        self.paramsValue = params
        self.bodyValue = body
        self.overTime = overTime
        self.plugins = plugins
    }

    init(requestURL: URL,
         path: String = "",
         params: [String: Any] = [:],
         body: [String: Any] = [:],
         overTime: TimeInterval = 15.0,
         plugins: [Moya.PluginType] = []) {
        self.requestURL = requestURL
        self.path = path
        self.paramsValue = params
        self.bodyValue = body
        self.overTime = overTime
        self.plugins = plugins
    }

    private var customizeMethod: Moya.Method? = nil

    func setMethod(method: Moya.Method) -> Self {
        customizeMethod = method
        return self
    }

    private var customizeTask: Moya.Task? = nil

    func setTask(task: Moya.Task) -> Self {
        customizeTask = task
        return self
    }

    private var customizeHeaders: [String: String]? = nil

    func increaseHeaders(task: Moya.Task) -> Self {
        customizeTask = task
        return self
    }

    func method() -> Moya.Method {
        guard let customizeMethod else {
            return .get
        }
        return customizeMethod
    }

    func task() -> Moya.Task {
        guard let customizeTask else {
            return .requestParameters(parameters: paramsValue,
                                      encoding: URLEncoding.default)
        }
        return customizeTask
    }

    func headers() -> [String: String] {
        guard let customizeHeaders else {
            return [:]
        }
        return customizeHeaders
    }
}
