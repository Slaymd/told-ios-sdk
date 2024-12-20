//
//  Told.swift
//  ToldSDK
//
//  Created by Darius MARTIN on 27/04/2023.
//

#if !os(macOS)

import Apollo
import Foundation
import UIKit

//let SERVER_API_URL = "http://192.168.1.55:7700"
//let SERVER_API_URL = "https://preprodapi.told.club"
//let SERVER_API_URL = "https://api.told.club"
//let WIDGET_URL = "http://192.168.1.55:3001"
//let WIDGET_URL = "https://preprodwidget.told.club"
//let WIDGET_URL = "https://widget.told.club"

public class Told {
    
    internal static var SERVER_API_URL = "https://api.told.club"
    internal static var WIDGET_URL = "https://widget.told.club"
    
//    internal static var SERVER_API_URL = "http://localhost:7700/graphql"
//    internal static var WIDGET_URL = "http://localhost:3001"
    
    internal static var currentViewController: UIViewController?
    internal static var currentViewControllerName: String? {
        didSet {
            checkScreenTriggers(currentViewControllerName ?? "", currentViewController)
        }
    }
        
    private static var apiClient = ApolloClient(url: URL(string: "\(SERVER_API_URL)/graphql")!)
    
    private static let storage = ToldStorage()
    
    private static var widgets: [ToldWidget] = []
    
    private static var loadingTriggers = false
    private static var triggers: [ToldAPI.GetEverySurveyAvailableToBeTriggeredQuery.Data.GetEverySurveyAvailableToBeTriggered?] = []
    
    private static var currentProjectId: String = ""
    private static var defaultParams: [ToldSurveyParams] = []
    
    internal static var currentHiddenFields: [String: String] = [:]
    internal static var currentHiddenFieldsFormatted: String?
    
    public static var enableScreenPrefixReplace = true
    
    // MARK: Public methods
            
    public static func initSDK(projectId: String, params: [ToldSurveyParams] = [], hiddenFields: [String: String] = [:], language: String = "fr") {
                
        if (loadingTriggers) { return }
        
        UIViewController.swizzleViewDidAppear()

        currentProjectId = projectId
        currentHiddenFields = hiddenFields
        //            currentHiddenFieldsFormatted = ToldUtils.convertToStringQueryParams(hiddenFields)
        currentHiddenFieldsFormatted = ToldUtils.convertToJSONString(hiddenFields)
        defaultParams = params
                        
        loadingTriggers = true
        
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        let bundleIdentifier = Bundle.main.bundleIdentifier

        apiClient.fetch(query: ToldAPI.GetEverySurveyAvailableToBeTriggeredQuery(folderID: projectId, type: "IN_APP_MOBILE", os: "IOS", mobileApp: bundleIdentifier ?? "", language: .some(language), version: .some(version), listReplied: .some(storage.getRepliedSurveys()), preview: .some(params.contains(.preview)))) { result in
                                    
            if let errors = try? result.get().errors {
                if (errors.count > 0) {
                    print("Told SDK not loaded correctly :", errors[0].message ?? "(unknown)")
                    return
                }
            }
                                  
            guard let data = try? result.get().data else {
                loadingTriggers = false
                return
            }
                        
            triggers = data.getEverySurveyAvailableToBeTriggered ?? []
            
            print("Initializing \(data.getEverySurveyAvailableToBeTriggered?.count ?? 0) survey triggers.")
            
            loadingTriggers = false
            
            return
        }
                
    }
    
    public static func setServerAPI(apiRootUrl: String, widgetRootUrl: String) {
        SERVER_API_URL = apiRootUrl
        WIDGET_URL = widgetRootUrl
        apiClient = ApolloClient(url: URL(string: "\(SERVER_API_URL)/graphql")!)
    }
    
    public static func addHiddenFields(hiddenFields: [String: String], setData: Bool = true) {
        if (setData) {
            currentHiddenFields = hiddenFields
//            currentHiddenFieldsFormatted = ToldUtils.convertToStringQueryParams(hiddenFields)
            currentHiddenFieldsFormatted = ToldUtils.convertToJSONString(hiddenFields)
            return
        }
        
        currentHiddenFields += hiddenFields
        currentHiddenFieldsFormatted = ToldUtils.convertToJSONString(hiddenFields)
        
        print(currentHiddenFields)
    }
    
    public static func sendCustomEvent(eventName: String, eventProperties: [String: String]?) {
        let matchingTriggers = triggers.filter { surveyTrigger in
            guard let customTrigger = surveyTrigger?.asSurveyTriggerCustomEvent else {
                return false
            }
            
            if customTrigger.eventName != nil && customTrigger.eventName == eventName { return true }
            return false
        }
        
        for eventTrigger in matchingTriggers {
            guard let customEventTrigger = eventTrigger?.asSurveyTriggerCustomEvent else { continue }
                        
            // If no conditions, start survey
            if (customEventTrigger.conditions == nil || customEventTrigger.conditions!.isEmpty) {
                Told.start(id: customEventTrigger.survey, projectId: currentProjectId, params: defaultParams)
                break
            }
            
            var conditionsAreMet = false
            
            // Check conditions
            for condition in customEventTrigger.conditions! {
                if let eventProperty = eventProperties?.first(where: { (key: String, value: String) in
                    if (condition?.key == key) { return true }
                    return false
                }) {
                    if (!ToldUtils.isCustomTriggerConditionTrue(condition: condition!, arg: eventProperty.value)) {
                        // eventProperty value doesnt corresponds to the condition, so cancel survey trigger
                        break
                    }
                    conditionsAreMet = true
                } else {
                    // No eventProperty corresponding to condition, so cancel survey trigger
                    break
                }
            }
            
            if (conditionsAreMet) {
                Told.start(id: customEventTrigger.survey, projectId: currentProjectId, params: defaultParams)
                break
            }
        }
    }
    
    public static func start(id surveyId: String, projectId: String) {
        start(id: surveyId, projectId: projectId, params: [])
    }
    
    public static func start(id surveyId: String, projectId: String, params: [ToldSurveyParams]) {
        if currentViewController != nil {
            start(id: surveyId, projectId: projectId, params: params, viewController: currentViewController!)
        } else {
            print("Cannot display survey \(surveyId) because no view controller appeared.")
        }
    }
    
    public static func start(id surveyId: String, projectId: String, params: [ToldSurveyParams], viewController vc: UIViewController) {
        
        for view in vc.view.subviews {
            if (String(describing: view.classForCoder) == "ToldWidget") {
                print("Cannot display survey \(surveyId) because a survey is already displayed.")
                return
            }
        }

        checkIfCanUseThisSurvey(surveyId: surveyId, params: params) { canUse in

            if (!canUse) {
                print("Cannot display survey \(surveyId). Check if survey is correctly configured and enabled on website. Or already seen ?")
                return
            }
            
            let widget = ToldWidget(surveyId: surveyId, projectId: projectId, mode: params.contains(.preview) ? .preview : params.contains(.debug) ? .debug : .production) { replied in
                if (replied) {
                    storage.setReplied(surveyId: surveyId)
                }
            }
            
            widgets.append(widget)
            vc.view.addSubview(widget)
            widget.setup()
            
            storage.setSeen(surveyId: surveyId)
        }
    }
    
    // MARK: Private methods
    
    private static func checkIfCanUseThisSurvey(surveyId: String, params: [ToldSurveyParams], completion: @escaping (Bool) -> ()) {
        
        if (params.contains(.seeItOnlyOnce) && storage.isSeen(surveyId: surveyId)) {
            completion(false)
            return
        }
        
        let bundleIdentifier = Bundle.main.bundleIdentifier
   
        apiClient.fetch(query: ToldAPI.CheckIfCanUseWidgetWithSurveyQuery(surveyID: surveyId, preview: .some(params.contains(.preview)), os: "IOS", mobileApp: bundleIdentifier ?? "")) { result in
            
            if let errors = try? result.get().errors {
                if (errors.count > 0) {
                    print("Told SDK Error while checking if can use widget :", errors[0].message ?? "(unknown)")
                    return
                }
            }
            
            guard let data = try? result.get().data else {
                completion(false)
                return
            }
            if let checkIfCanUseWidgetWithSurvey = data.checkIfCanUseWidgetWithSurvey?.canUse {
                completion(checkIfCanUseWidgetWithSurvey)
                return
            }
            
            completion(false)
            return
        }
        
    }
    
    private static func waitForLoading(completion: @escaping () -> Void) {
        DispatchQueue.global().async {
            while loadingTriggers {
                // Wait
                Thread.sleep(forTimeInterval: 0.1)
            }
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    
    
    private static func checkScreenTriggers(_ screenName: String, _ viewController: UIViewController?) {
        
        if (viewController == nil) { return }
        
        if (screenName.contains("ToldWidget")) { return }
        
        // Wait while init isn't finished
        waitForLoading {
                                    
            for surveyTrigger in triggers {
                
                guard let screenTrigger = surveyTrigger?.asSurveyTriggerScreen else {
                    continue
                }
                                
                if ((screenTrigger.whenData?.seeItOnlyOnce ?? false) && storage.isSeen(surveyId: screenTrigger.survey)) { continue }
                if ((screenTrigger.whenData?.replyOnlyOnce ?? false) && storage.isReplied(surveyId: screenTrigger.survey)) { continue }

                if screenTrigger.onAllScreen ?? false || ToldUtils.isTriggerConditionTrue(condition: screenTrigger.condition, arg: screenName) {
                    
                    let delayEnabled = screenTrigger.delay?.active ?? false
                    let delayValue = delayEnabled ? screenTrigger.delay?.value ?? 0 : 0
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(delayValue)) {
                        
                        print("Triggered survey: \(screenTrigger.survey) on screen \(screenName)")
                                                
                        Told.start(id: screenTrigger.survey, projectId: currentProjectId, params: defaultParams, viewController: viewController!)
                        
                    }
                                        
                }
                                
            }
        }
        
    }
    
}

#endif
