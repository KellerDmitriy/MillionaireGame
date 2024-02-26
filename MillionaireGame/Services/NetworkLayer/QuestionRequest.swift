//
//  EasyQuestionRequest.swift
//  MillionaireGame
//
//  Created by Polina on 26.02.2024.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol QuestionRequestProtocol {
    associatedtype Response

    var url: String { get }
    var method: HTTPMethod { get }
    var headers: [String : String]? { get }
    var queryItems: [String : String]? { get }
    
    func decode(_ data: Data) throws -> Response
}

extension QuestionRequestProtocol where Response: Decodable {
    func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Response.self, from: data)
    }
}

struct QuestionRequest: QuestionRequestProtocol{
    typealias Response = QuestionsModel
    
    let amount: Int
    let difficulty: String
    
    var url: String {
        let baseUrl = "https://opentdb.com/api.php"
        return baseUrl
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String : String]?{
        return nil
    }
    
    var queryItems: [String : String]?{
        let params = [
            "amount": "\(amount)",
            "difficulty": "\(difficulty)"
        ]
        return params
    }
}
