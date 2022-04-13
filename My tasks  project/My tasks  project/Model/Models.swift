//
//  Models.swift
//  My tasks  project
//
//  Created by Mahia113
//

import Foundation

/**
 Types of network errors
 ### Properties
 - **invalidURL**: URL request error.
 - **invalidResponse**: HTTP request error.
 - **apiError**: API request error.
 - **decodingError**: Decoding request error.
 */
public enum NetworkHandlerError: Error {
    case invalidURL
    case invalidResponse(error: ErrorMessage)
    case apiError
    case decodingError
}

public struct ErrorMessage: Codable {
    let error: String
}

public struct RootChartsModel: Codable {
    let colors: [String]
    let questions: [QuestionModel]
}

public struct ColorsModel: Codable {
    let colors: String
}

public struct QuestionModel: Codable {
    let total: Int
    let text: String
    let chartData: [ChartData]
}

public struct ChartData: Codable {
    let text: String
    let percetnage: Int
}
