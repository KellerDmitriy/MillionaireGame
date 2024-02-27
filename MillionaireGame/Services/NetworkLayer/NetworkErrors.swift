//
//  NetworkErrors.swift
//  MillionaireGame
//
//  Created by Polina on 26.02.2024.
//

import Foundation


enum NetworkErrors: Error, LocalizedError{
    case invalidURL
    case invalidResponse
    case invalidData
    case unknow(Error)
    
    var errorDescription: String?{
        switch self{
        case .invalidURL:
            return "Wrong URL"
        case .invalidResponse:
            return  "Wrong Response"
        case .invalidData:
            return "Can not to decode Data"
        case .unknow(let error):
            return error.localizedDescription
        }
    }
}
