// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension ToldAPI {
  class GetEverySurveyAvailableToBeTriggeredQuery: GraphQLQuery {
    public static let operationName: String = "getEverySurveyAvailableToBeTriggered"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query getEverySurveyAvailableToBeTriggered($folderID: ID!, $type: String!, $os: String, $mobileApp: String, $language: String, $version: String, $listReplied: [SurveyReplied], $preview: Boolean) {
          getEverySurveyAvailableToBeTriggered(
            folderID: $folderID
            type: $type
            os: $os
            mobileApp: $mobileApp
            language: $language
            version: $version
            listReplied: $listReplied
            preview: $preview
          ) {
            __typename
            id
            survey
            kind
            whenData {
              __typename
              seeItOnlyOnce
              replyOnlyOnce
            }
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
            ... on SurveyTriggerCustomEvent {
              eventName
              conditions {
                __typename
                key
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
    public var mobileApp: GraphQLNullable<String>
    public var language: GraphQLNullable<String>
    public var version: GraphQLNullable<String>
    public var listReplied: GraphQLNullable<[SurveyReplied?]>
    public var preview: GraphQLNullable<Bool>

    public init(
      folderID: ID,
      type: String,
      os: GraphQLNullable<String>,
      mobileApp: GraphQLNullable<String>,
      language: GraphQLNullable<String>,
      version: GraphQLNullable<String>,
      listReplied: GraphQLNullable<[SurveyReplied?]>,
      preview: GraphQLNullable<Bool>
    ) {
      self.folderID = folderID
      self.type = type
      self.os = os
      self.mobileApp = mobileApp
      self.language = language
      self.version = version
      self.listReplied = listReplied
      self.preview = preview
    }

    public var __variables: Variables? { [
      "folderID": folderID,
      "type": type,
      "os": os,
      "mobileApp": mobileApp,
      "language": language,
      "version": version,
      "listReplied": listReplied,
      "preview": preview
    ] }

    public struct Data: ToldAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.Query }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("getEverySurveyAvailableToBeTriggered", [GetEverySurveyAvailableToBeTriggered?]?.self, arguments: [
          "folderID": .variable("folderID"),
          "type": .variable("type"),
          "os": .variable("os"),
          "mobileApp": .variable("mobileApp"),
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

        public static var __parentType: ApolloAPI.ParentType { ToldAPI.Interfaces.SurveyTrigger }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", ToldAPI.ID.self),
          .field("survey", ToldAPI.ID.self),
          .field("kind", String?.self),
          .field("whenData", WhenData?.self),
          .inlineFragment(AsSurveyTriggerScreen.self),
          .inlineFragment(AsSurveyTriggerCustomEvent.self),
        ] }

        public var id: ToldAPI.ID { __data["id"] }
        public var survey: ToldAPI.ID { __data["survey"] }
        public var kind: String? { __data["kind"] }
        public var whenData: WhenData? { __data["whenData"] }

        public var asSurveyTriggerScreen: AsSurveyTriggerScreen? { _asInlineFragment() }
        public var asSurveyTriggerCustomEvent: AsSurveyTriggerCustomEvent? { _asInlineFragment() }

        /// GetEverySurveyAvailableToBeTriggered.WhenData
        ///
        /// Parent Type: `WhenData`
        public struct WhenData: ToldAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.WhenData }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("seeItOnlyOnce", Bool?.self),
            .field("replyOnlyOnce", Bool?.self),
          ] }

          public var seeItOnlyOnce: Bool? { __data["seeItOnlyOnce"] }
          public var replyOnlyOnce: Bool? { __data["replyOnlyOnce"] }
        }

        /// GetEverySurveyAvailableToBeTriggered.AsSurveyTriggerScreen
        ///
        /// Parent Type: `SurveyTriggerScreen`
        public struct AsSurveyTriggerScreen: ToldAPI.InlineFragment {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public typealias RootEntityType = GetEverySurveyAvailableToBeTriggeredQuery.Data.GetEverySurveyAvailableToBeTriggered
          public static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.SurveyTriggerScreen }
          public static var __selections: [ApolloAPI.Selection] { [
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
          public var whenData: WhenData? { __data["whenData"] }

          /// GetEverySurveyAvailableToBeTriggered.AsSurveyTriggerScreen.Delay
          ///
          /// Parent Type: `SurveyTriggerDelay`
          public struct Delay: ToldAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.SurveyTriggerDelay }
            public static var __selections: [ApolloAPI.Selection] { [
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

            public static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.SurveyTriggerURLCondition }
            public static var __selections: [ApolloAPI.Selection] { [
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

        /// GetEverySurveyAvailableToBeTriggered.AsSurveyTriggerCustomEvent
        ///
        /// Parent Type: `SurveyTriggerCustomEvent`
        public struct AsSurveyTriggerCustomEvent: ToldAPI.InlineFragment {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public typealias RootEntityType = GetEverySurveyAvailableToBeTriggeredQuery.Data.GetEverySurveyAvailableToBeTriggered
          public static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.SurveyTriggerCustomEvent }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("eventName", String?.self),
            .field("conditions", [Condition?]?.self),
          ] }

          public var eventName: String? { __data["eventName"] }
          public var conditions: [Condition?]? { __data["conditions"] }
          public var id: ToldAPI.ID { __data["id"] }
          public var survey: ToldAPI.ID { __data["survey"] }
          public var kind: String? { __data["kind"] }
          public var whenData: WhenData? { __data["whenData"] }

          /// GetEverySurveyAvailableToBeTriggered.AsSurveyTriggerCustomEvent.Condition
          ///
          /// Parent Type: `SurveyTriggerCustomEventCondition`
          public struct Condition: ToldAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.SurveyTriggerCustomEventCondition }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("key", String?.self),
              .field("operator", String?.self),
              .field("value", String?.self),
            ] }

            public var key: String? { __data["key"] }
            public var `operator`: String? { __data["operator"] }
            public var value: String? { __data["value"] }
          }
        }
      }
    }
  }

}