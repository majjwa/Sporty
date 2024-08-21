//
//  Result.swift
//  Sporty
//
//  Created by marwa maky on 21/08/2024.
//

import Foundation

enum ResultEnum<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}
