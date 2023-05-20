//
//  ToldStorage.swift
//  ToldSDK
//
//  Created by Darius MARTIN on 07/05/2023.
//

internal class ToldStorage {
    
    private var surveys: [ToldSurveyData] = []
    private let userDefaults = UserDefaults.standard
    private let surveyKey = "ToldSurveyData"

    init() {
        if let savedSurveysData = userDefaults.data(forKey: surveyKey),
            let savedSurveys = try? JSONDecoder().decode([ToldSurveyData].self, from: savedSurveysData) {
            surveys = savedSurveys
        }
    }
    
    func getRepliedSurveys() -> [ToldAPI.SurveyReplied] {
        surveys.map { data in
            return ToldAPI.SurveyReplied(InputDict(["surveyId": data.surveyId, "date": data.date, "replied": data.replied > 0]))
        }
    }

    func setSeen(surveyId: String) {
        // Already exist
        if let index = surveys.firstIndex(where: { $0.surveyId == surveyId }) {
            surveys[index].seenCount += 1
            saveSurveys()
            return
        }
        
        // Create new one
        surveys.append(ToldSurveyData(surveyId: surveyId, seenCount: 1, replied: 0))
        saveSurveys()
    }
    
    func setReplied(surveyId: String) {
        // Already exist
        if let index = surveys.firstIndex(where: { $0.surveyId == surveyId }) {
            surveys[index].replied += 1
            surveys[index].date = Date().getISODateString()
            saveSurveys()
            return
        }
        
        // Create new one
        surveys.append(ToldSurveyData(surveyId: surveyId, seenCount: 1, replied: 1))
        saveSurveys()
    }
    
    func isSeen(surveyId: String) -> Bool {
        if let surveyData = surveys.first(where: { $0.surveyId == surveyId }) {
            return surveyData.seenCount > 0
        }
        
        return false
    }
    
    func isReplied(surveyId: String) -> Bool {
        if let surveyData = surveys.first(where: { $0.surveyId == surveyId }) {
            return surveyData.replied > 0
        }
        
        return false
    }

    private func saveSurveys() {
        if let surveysData = try? JSONEncoder().encode(surveys) {
            userDefaults.set(surveysData, forKey: surveyKey)
        }
    }
}

internal struct ToldSurveyData: Codable {
    let surveyId: String
    var seenCount: Int
    var replied: Int
    var date: String?

    init(surveyId: String, seenCount: Int = 0, replied: Int = 0, date: String? = nil) {
        self.surveyId = surveyId
        self.seenCount = seenCount
        self.replied = replied
        self.date = date
    }
}


