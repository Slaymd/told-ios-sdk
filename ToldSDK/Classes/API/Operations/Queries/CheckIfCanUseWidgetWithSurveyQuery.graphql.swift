// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ToldAPI {
  class CheckIfCanUseWidgetWithSurveyQuery: GraphQLQuery {
    public static let operationName: String = "checkIfCanUseWidgetWithSurvey"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query checkIfCanUseWidgetWithSurvey($surveyID: ID!, $hostname: String!, $preview: Boolean) {
          checkIfCanUseWidgetWithSurvey(
            surveyID: $surveyID
            hostname: $hostname
            preview: $preview
          )
        }
        """#
      ))

    public var surveyID: ID
    public var hostname: String
    public var preview: GraphQLNullable<Bool>

    public init(
      surveyID: ID,
      hostname: String,
      preview: GraphQLNullable<Bool>
    ) {
      self.surveyID = surveyID
      self.hostname = hostname
      self.preview = preview
    }

    public var __variables: Variables? { [
      "surveyID": surveyID,
      "hostname": hostname,
      "preview": preview
    ] }

    public struct Data: ToldAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ToldAPI.Objects.Query }
      public static var __selections: [Apollo.Selection] { [
        .field("checkIfCanUseWidgetWithSurvey", Bool?.self, arguments: [
          "surveyID": .variable("surveyID"),
          "hostname": .variable("hostname"),
          "preview": .variable("preview")
        ]),
      ] }

      public var checkIfCanUseWidgetWithSurvey: Bool? { __data["checkIfCanUseWidgetWithSurvey"] }
    }
  }

}