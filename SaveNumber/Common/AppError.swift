//
//  AppError.swift
//  SaveNumber
//
//  Created by Benjamin Wong on 2024/5/14.
//

import Foundation

struct APIErrorResponse: Decodable {
    var statusCode: Int
    var code: String
    var error: String
    var message: String
}

enum AppError: Error {
    case objectReleased
    case apiError(errorResponse: APIErrorResponse)
    case custom(description: String)
    case nested(error: Error)
}

extension AppError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .objectReleased:
            return "object released"
        case .apiError(let errorResponse):
            return "\(errorResponse)"
        case .custom(let description):
            return description
        case .nested(let error):
            return error.localizedDescription
        }
    }
    
    var errorDescription: String? {
        return localizedDescription
    }
}
