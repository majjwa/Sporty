//
//  Decoder.swift
//  Sporty
//
//  Created by marwa maky on 21/08/2024.
//

import Foundation
import Alamofire

class DecoderFunc {
  
    static func decode<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
