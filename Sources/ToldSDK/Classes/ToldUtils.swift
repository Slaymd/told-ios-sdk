//
//  ToldUtils.swift
//  ToldSDK
//
//  Created by Darius MARTIN on 20/05/2023.
//

#if !os(macOS)

import UIKit
import Foundation

internal class ToldUtils {
    
    static func isTriggerConditionTrue(condition: ToldAPI.GetEverySurveyAvailableToBeTriggeredQuery.Data.GetEverySurveyAvailableToBeTriggered.AsSurveyTriggerScreen.Condition?, arg: String) -> Bool {
        
        if condition == nil { return false }
        
        switch (condition!.operator) {
        case "isEqualTo":
            return condition!.value == arg
        case "contain":
            return arg.lowercased().contains(condition!.value.lowercased())
        case "isNotEqualTo":
            return condition!.value != arg
        case "doesNotContain":
            return !arg.lowercased().contains(condition!.value.lowercased())
        default:
            return false
        }
        
    }
    
    static func isCustomTriggerConditionTrue(condition: ToldAPI.GetEverySurveyAvailableToBeTriggeredQuery.Data.GetEverySurveyAvailableToBeTriggered.AsSurveyTriggerCustomEvent.Condition?, arg: String) -> Bool {
        
        if condition == nil { return false }
        
        switch (condition!.operator) {
        case "isEqualTo":
            return condition!.value == arg
        case "contain":
            return arg.lowercased().contains(condition!.value?.lowercased() ?? "")
        case "isNotEqualTo":
            return condition!.value != arg
        case "doesNotContain":
            return !arg.lowercased().contains(condition!.value?.lowercased() ?? "")
        default:
            return false
        }
        
    }
    
    static func convertToStringQueryParams(_ data: [String: String]) -> String {
        var queryItems: [String] = []
        
        for (key, value) in data {
            if let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let encodedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                queryItems.append("\(encodedKey)=\(encodedValue)")
            }
        }
        
        return queryItems.joined(separator: "&")
    }
    
    static func convertToJSONString(_ dictionary: [String: String]) -> String {
        do {
            if (dictionary.isEmpty) { return "[]" }
            let jsonArray = dictionary.map { ["key": $0.key, "value": $0.value] }

            let jsonData = try JSONSerialization.data(withJSONObject: jsonArray, options: [])
            return String(data: jsonData, encoding: .utf8) ?? "[]"
        } catch {
            print("Error: JSONSerialization issue: \(error)")
            return "[]"
        }
    }
    
    static func getScreenHeight(widget: ToldWidget) -> CGFloat {
        var screenHeight = CGFloat(500)
        if #available(iOS 13.0, *) {
            screenHeight = widget.window?.windowScene?.screen.bounds.height ?? 500
        } else {
            screenHeight = UIScreen.main.bounds.height
        }
        return screenHeight
    }
    
}

#endif
