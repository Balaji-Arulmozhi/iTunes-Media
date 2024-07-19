//
//  AppStrings.swift
//  iTunesMedia
//
//  Created by Kumararaja Krishnan on 7/17/24.
//

import Foundation

enum NetworkErrorStrings:String{
    case InvalidURL
    case RequestFailed
    case InvalidResponse
    case DecodingFailedWithError
    case UnAuthorizedError
    case NoNetwork
    
    var localized: String{
        NSLocalizedString("\(rawValue)", comment: "Network Error Strings")
    }
}
