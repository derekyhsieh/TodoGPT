//
//  MessageModels.swift
//  SwiftUI-Auth
//
//  Created by Derek Hsieh on 5/13/23.
//

import Foundation

struct MessageData: Hashable {
    var content: String
    var user: UserType
}

enum UserType {
    case user
    case system
}

