//
// Created by Lvyk on 2023/5/15.
//

import Foundation
import Moya

public protocol MoyaTargetFactory {
    var requestURL: URL { get }
    var path: String { get }
    var overTime: TimeInterval { get }
    var plugins: [PluginType] { get }

    func method() -> Moya.Method
    func task() -> Moya.Task
    func headers() -> [String: String]
}
