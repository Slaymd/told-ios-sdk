//
//  ToldDateExtension.swift
//  ToldSDK
//
//  Created by Darius MARTIN on 14/05/2023.
//

#if !os(macOS)

internal extension Date {
    
    func getISODateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.string(from: self)
    }
    
}

#endif
