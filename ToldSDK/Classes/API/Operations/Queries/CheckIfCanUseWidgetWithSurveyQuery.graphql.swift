// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ToldAPI {
  class CheckIfCanUseWidgetWithSurveyQuery: GraphQLQuery {
    public static let operationName: String = "checkIfCanUseWidgetWithSurvey"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query checkIfCanUseWidgetWithSurvey($surveyID: ID!, $preview: Boolean, $os: String!, $mobileApp: String!) {
          checkIfCanUseWidgetWithSurvey(
            surveyID: $surveyID
            preview: $preview
            os: $os
            mobileApp: $mobileApp
          )
        }
        """#
      ))

    public var surveyID: ID
    public var preview: GraphQLNullable<Bool>
    public var os: String
    public var mobileApp: String

    public init(
      surveyID: ID,
      preview: GraphQLNullable<Bool>,
      os: String,
      mobileApp: String
    ) {
      self.surveyID = surveyID
      self.preview = preview
      self.os = os
      self.mobileApp = mobileApp
    }

    public var __variables: Variables? { [
      "surveyID": surveyID,
      "preview": preview,
      "os": os,
      "mobileApp": mobileApp
    ] }

    public struct Data: ToldAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ToldAPI.Objects.Query }
      public static var __selections: [Apollo.Selection] { [
        .field("checkIfCanUseWidgetWithSurvey", Bool?.self, arguments: [
          "surveyID": .variable("surveyID"),
          "preview": .variable("preview"),
          "os": .variable("os"),
          "mobileApp": .variable("mobileApp")
        ]),
      ] }

      public var checkIfCanUseWidgetWithSurvey: Bool? { __data["checkIfCanUseWidgetWithSurvey"] }
    }
  }

}