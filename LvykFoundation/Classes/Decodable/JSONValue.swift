//
//  GeneralValue.swift
//  NeoLine
//
//  Created by Lvyk on 2023/4/14.
//

import Foundation

public enum GeneralValue: Codable {
    case string(String)
    case int(Int)
    case uint(UInt)
    case int8(Int8)
    case uint8(UInt8)
    case int16(Int16)
    case uint16(UInt16)
    case int32(Int32)
    case uint32(UInt32)
    case int64(Int64)
    case uint64(UInt64)
    case float(Float)
    case double(Double)
    case bool(Bool)
    case object([String: GeneralValue])
    case array([GeneralValue])

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode(Int.self) {
            self = .int(value)
        } else if let value = try? container.decode(UInt.self) {
            self = .uint(value)
        } else if let value = try? container.decode(Int32.self) {
            self = .int32(value)
        } else if let value = try? container.decode(UInt32.self) {
            self = .uint32(value)
        } else if let value = try? container.decode(Int64.self) {
            self = .int64(value)
        } else if let value = try? container.decode(UInt64.self) {
            self = .uint64(value)
        } else if let value = try? container.decode(Double.self) {
            self = .double(value)
        } else if let value = try? container.decode(Bool.self) {
            self = .bool(value)
        } else if let value = try? container.decode([String: GeneralValue].self) {
            self = .object(value)
        } else if let value = try? container.decode([GeneralValue].self) {
            self = .array(value)
        } else {
            throw DecodingError.typeMismatch(GeneralValue.self, DecodingError.Context(codingPath: container.codingPath, debugDescription: "Not a JSON"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .string(val):
            try container.encode(val)
        case let .int(val):
            try container.encode(val)
        case let .int8(val):
            try container.encode(val)
        case let .int16(val):
            try container.encode(val)
        case let .int32(val):
            try container.encode(val)
        case let .int64(val):
            try container.encode(val)
        case let .uint(val):
            try container.encode(val)
        case let .uint8(val):
            try container.encode(val)
        case let .uint16(val):
            try container.encode(val)
        case let .uint32(val):
            try container.encode(val)
        case let .uint64(val):
            try container.encode(val)
        case let .float(val):
            try container.encode(val)
        case let .double(val):
            try container.encode(val)
        case let .bool(val):
            try container.encode(val)
        case let .object(val):
            try container.encode(val)
        case let .array(val):
            try container.encode(val)
        }
    }

    public var dictionaryValue: [String: GeneralValue]? {
        if case let GeneralValue.object(v) = self {
            return v
        } else {
            return nil
        }
    }

    public var arrayValue: [GeneralValue]? {
        if case let GeneralValue.array(v) = self {
            return v
        } else {
            return nil
        }
    }

    public var intValue: Int { value() }
    public var int8Value: Int8 { value() }
    public var int16Value: Int16 { value() }
    public var int32Value: Int32 { value() }
    public var int64Value: Int64 { value() }
    public var uintValue: UInt { value() }
    public var uint8Value: UInt8 { value() }
    public var uint16Value: UInt16 { value() }
    public var uint32Value: UInt32 { value() }
    public var uint64Value: UInt64 { value() }
    public var floatValue: Float { value() }
    public var doubleValue: Double { value() }
    public var boolValue: Bool {
        switch self {
        case let .int(val):
            return val != 0
        case let .int8(val):
            return val != 0
        case let .int16(val):
            return val != 0
        case let .int32(val):
            return val != 0
        case let .int64(val):
            return val != 0
        case let .uint(val):
            return val != 0
        case let .uint8(val):
            return val != 0
        case let .uint16(val):
            return val != 0
        case let .uint32(val):
            return val != 0
        case let .uint64(val):
            return val != 0
        case let .float(val):
            return val != 0
        case let .double(val):
            return val != 0
        case let .bool(val):
            return val
        case let .string(val):
            return (val as NSString).boolValue
        case .object(_),
             .array:
            return false
        }
    }

    private func value<T>() -> T where T: BinaryInteger & LosslessStringConvertible {
        switch self {
        case let .int(val):
            return T(val)
        case let .int8(val):
            return T(val)
        case let .int16(val):
            return T(val)
        case let .int32(val):
            return T(val)
        case let .int64(val):
            return T(val)
        case let .uint(val):
            return T(val)
        case let .uint8(val):
            return T(val)
        case let .uint16(val):
            return T(val)
        case let .uint32(val):
            return T(val)
        case let .uint64(val):
            return T(val)
        case let .float(val):
            return T(val)
        case let .double(val):
            return T(val)
        case let .bool(val):
            return T(val ? 1 : 0)
        case let .string(val):
            return T(val) ?? 0
        case .object(_),
             .array:
            return 0
        }
    }

    private func value<T>() -> T where T: BinaryFloatingPoint & LosslessStringConvertible {
        switch self {
        case let .int(val):
            return T(val)
        case let .int8(val):
            return T(val)
        case let .int16(val):
            return T(val)
        case let .int32(val):
            return T(val)
        case let .int64(val):
            return T(val)
        case let .uint(val):
            return T(val)
        case let .uint8(val):
            return T(val)
        case let .uint16(val):
            return T(val)
        case let .uint32(val):
            return T(val)
        case let .uint64(val):
            return T(val)
        case let .float(val):
            return T(val)
        case let .double(val):
            return T(val)
        case let .bool(val):
            return T(val ? 1 : 0)
        case let .string(val):
            return T(val) ?? 0
        case .object(_),
             .array:
            return 0
        }
    }
}
