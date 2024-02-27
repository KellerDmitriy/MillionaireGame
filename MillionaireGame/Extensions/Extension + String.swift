//
//  Extension + String.swift
//  MillionaireGame
//
//  Created by Polina on 26.02.2024.
//

import Foundation
extension String {
    var htmlAttributedString: NSAttributedString? {
          return try? NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
      }
}
