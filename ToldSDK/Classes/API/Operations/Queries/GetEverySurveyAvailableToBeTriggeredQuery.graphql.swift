// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ToldAPI {
  class GetEverySurveyAvailableToBeTriggeredQuery: GraphQLQuery {
    public static let operationName: String = "getEverySurveyAvailableToBeTriggered"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query getEverySurveyAvailableToBeTriggered($folderID: ID!, $type: String!, $os: String, $language: String, $version: String, $listReplied: [SurveyReplied], $preview: Boolean) {
          getEverySurveyAvailableToBeTriggered(
            folderID: $folderID
            type: $type
            os: $os
            language: $language
            version: $version
            listReplied: $listReplied
            preview: $preview
          ) {
            __typename
            id
            survey
            kind
            ... on SurveyTriggerScreen {
              onAllScreen
              onLoadScreen
              delay {
                __typename
                value
                active
              }
              condition {
                __typename
                variable
                operator
                value
              }
            }
          }
        }
        """#
      ))

    public var folderID: ID
    public var type: String
    public var os: GraphQLNullable<String>
    public var language: GraphQLNullable<String>
    public var version: GraphQLNullable<String>
    public var listReplied: GraphQLNullable<[SurveyReplied?]>
    public var preview: GraphQLNullable<Bool>

    public init(
      folderID: ID,
      type: String,
      os: GraphQLNullable<String>,
      language: GraphQLNullable<String>,
      version: GraphQLNullable<String>,
      listReplied: GraphQLNullable<[SurveyReplied?]>,
      preview: GraphQLNullable<Bool>
    ) {
      self.folderID = folderID
      self.type = type
      self.os = os
      self.language = language
      self.version = version
      self.listReplied = listReplied
      self.preview = preview
    }

    public var __variables: Variables? { [
      "folderID": folderID,
      "type": type,
      "os": os,
      "language": language,
      "version": version,
      "listReplied": listReplied,
      "preview": preview
    ] }

    public struct Data: ToldAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ToldAPI.Objects.Query }
      public static var __selections: [Apollo.Selection] { [
        .field("getEverySurveyAvailableToBeTriggered", [GetEverySurveyAvailableToBeTriggered?]?.self, arguments: [
          "folderID": .variable("folderID"),
          "type": .variable("type"),
          "os": .variable("os"),
          "language": .variable("language"),
          "version": .variable("version"),
          "listReplied": .variable("listReplied"),
          "preview": .variable("preview")
        ]),
      ] }

      public var getEverySurveyAvailableToBeTriggered: [GetEverySurveyAvailableToBeTriggered?]? { __data["getEverySurveyAvailableToBeTriggered"] }

      /// GetEverySurveyAvailableToBeTriggered
      ///
      /// Parent Type: `SurveyTrigger`
      public struct GetEverySurveyAvailableToBeTriggered: ToldAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ToldAPI.Interfaces.SurveyTrigger }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("id", ToldAPI.ID.self),
          .field("survey", ToldAPI.ID.self),
          .field("kind", String?.self),
          .inlineFragment(AsSurveyTriggerScreen.self),
        ] }

        public var id: ToldAPI.ID { __data["id"] }
        public var survey: ToldAPI.ID { __data["survey"] }
        public var kind: String? { __data["kind"] }

        public var asSurveyTriggerScreen: AsSurveyTriggerScreen? { _asInlineFragment() }

        /// GetEverySurveyAvailableToBeTriggered.AsSurveyTriggerScreen
        ///
        /// Parent Type: `SurveyTriggerScreen`
        public struct AsSurveyTriggerScreen: ToldAPI.InlineFragment {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public typealias RootEntityType = GetEverySurveyAvailableToBeTriggeredQuery.Data.GetEverySurveyAvailableToBeTriggered
          public static var __parentType: Apollo.ParentType { ToldAPI.Objects.SurveyTriggerScreen }
          public static var __selections: [Apollo.Selection] { [
            .field("onAllScreen", Bool?.self),
            .field("onLoadScreen", Bool?.self),
            .field("delay", Delay?.self),
            .field("condition", Condition?.self),
          ] }

          public var onAllScreen: Bool? { __data["onAllScreen"] }
          public var onLoadScreen: Bool? { __data["onLoadScreen"] }
          public var delay: Delay? { __data["delay"] }
          public var condition: Condition? { __data["condition"] }
          public var id: ToldAPI.ID { __data["id"] }
          public var survey: ToldAPI.ID { __data["survey"] }
          public var kind: String? { __data["kind"] }

          /// GetEverySurveyAvailableToBeTriggered.AsSurveyTriggerScreen.Delay
          ///
          /// Parent Type: `SurveyTriggerDelay`
          public struct Delay: ToldAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ToldAPI.Objects.SurveyTriggerDelay }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("value", Int.self),
              .field("active", Bool.self),
            ] }

            public var value: Int { __data["value"] }
            public var active: Bool { __data["active"] }
          }

          /// GetEverySurveyAvailableToBeTriggered.AsSurveyTriggerScreen.Condition
          ///
          /// Parent Type: `SurveyTriggerURLCondition`
          public struct Condition: ToldAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ToldAPI.Objects.SurveyTriggerURLCondition }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("variable", String.self),
              .field("operator", String.self),
              .field("value", String.self),
            ] }

            public var variable: String { __data["variable"] }
            public var `operator`: String { __data["operator"] }
            public var value: String { __data["value"] }
          }
        }
      }
    }
  }

}