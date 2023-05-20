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
    
}
