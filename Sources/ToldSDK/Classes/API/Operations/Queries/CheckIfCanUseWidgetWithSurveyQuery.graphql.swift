// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension ToldAPI {
  class CheckIfCanUseWidgetWithSurveyQuery: GraphQLQuery {
    static let operationName: String = "checkIfCanUseWidgetWithSurvey"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query checkIfCanUseWidgetWithSurvey($surveyID: ID!, $preview: Boolean, $os: String!, $mobileApp: String!) { checkIfCanUseWidgetWithSurvey( surveyID: $surveyID preview: $preview os: $os mobileApp: $mobileApp ) { __typename canUse } }"#
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

    struct Data: ToldAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("checkIfCanUseWidgetWithSurvey", CheckIfCanUseWidgetWithSurvey?.self, arguments: [
          "surveyID": .variable("surveyID"),
          "preview": .variable("preview"),
          "os": .variable("os"),
          "mobileApp": .variable("mobileApp")
        ]),
      ] }

      var checkIfCanUseWidgetWithSurvey: CheckIfCanUseWidgetWithSurvey? { __data["checkIfCanUseWidgetWithSurvey"] }

      /// CheckIfCanUseWidgetWithSurvey
      ///
      /// Parent Type: `CanUseSurvey`
      struct CheckIfCanUseWidgetWithSurvey: ToldAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.CanUseSurvey }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("canUse", Bool?.self),
        ] }

        var canUse: Bool? { __data["canUse"] }
      }
    }
  }

}