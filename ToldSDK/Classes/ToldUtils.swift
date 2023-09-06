//
//  ToldUtils.swift
//  ToldSDK
//
//  Created by Darius MARTIN on 20/05/2023.
//

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
    
}
