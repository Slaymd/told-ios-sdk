// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ToldAPI {
  class GetEverySurveyAvailableToBeTriggeredQuery: GraphQLQuery {
    public static let operationName: String = "getEverySurveyAvailableToBeTriggered"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query getEverySurveyAvailableToBeTriggered($folderID: ID!, $navigator: String, $hostname: String!, $language: String, $device: String, $listReplied: [SurveyReplied], $preview: Boolean) {
          getEverySurveyAvailableToBeTriggered(
            folderID: $folderID
            navigator: $navigator
            hostname: $hostname
            language: $language
            device: $device
            listReplied: $listReplied
            preview: $preview
          ) {
            __typename
            id
            survey
            kind
            ... on SurveyTriggerURL {
              onAllUrl
              onLoadPage
              delay {
                __typename
                value
                active
              }
              scroll {
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
            ... on SurveyTriggerClick {
              variable
              value
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
    public var navigator: GraphQLNullable<String>
    public var hostname: String
    public var language: GraphQLNullable<String>
    public var device: GraphQLNullable<String>
    public var listReplied: GraphQLNullable<[SurveyReplied?]>
    public var preview: GraphQLNullable<Bool>

    public init(
      folderID: ID,
      navigator: GraphQLNullable<String>,
      hostname: String,
      language: GraphQLNullable<String>,
      device: GraphQLNullable<String>,
      listReplied: GraphQLNullable<[SurveyReplied?]>,
      preview: GraphQLNullable<Bool>
    ) {
      self.folderID = folderID
      self.navigator = navigator
      self.hostname = hostname
      self.language = language
      self.device = device
      self.listReplied = listReplied
      self.preview = preview
    }

    public var __variables: Variables? { [
      "folderID": folderID,
      "navigator": navigator,
      "hostname": hostname,
      "language": language,
      "device": device,
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
          "navigator": .variable("navigator"),
          "hostname": .variable("hostname"),
          "language": .variable("language"),
          "device": .variable("device"),
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
          .inlineFragment(AsSurveyTriggerURL.self),
          .inlineFragment(AsSurveyTriggerScreen.self),
          .inlineFragment(AsSurveyTriggerClick.self),
          .inlineFragment(AsSurveyTriggerCustomEvent.self),
        ] }

        public var id: ToldAPI.ID { __data["id"] }
        public var survey: ToldAPI.ID { __data["survey"] }
        public var kind: String? { __data["kind"] }

        public var asSurveyTriggerURL: AsSurveyTriggerURL? { _asInlineFragment() }
        public var asSurveyTriggerScreen: AsSurveyTriggerScreen? { _asInlineFragment() }
        public var asSurveyTriggerClick: AsSurveyTriggerClick? { _asInlineFragment() }
        public var asSurveyTriggerCustomEvent: AsSurveyTriggerCustomEvent? { _asInlineFragment() }

        /// GetEverySurveyAvailableToBeTriggered.AsSurveyTriggerURL
        ///
        /// Parent Type: `SurveyTriggerURL`
        public struct AsSurveyTriggerURL: ToldAPI.InlineFragment {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public typealias RootEntityType = GetEverySurveyAvailableToBeTriggeredQuery.Data.GetEverySurveyAvailableToBeTriggered
          public static var __parentType: Apollo.ParentType { ToldAPI.Objects.SurveyTriggerURL }
          public static var __selections: [Apollo.Selection] { [
            .field("onAllUrl", Bool?.self),
            .field("onLoadPage", Bool?.self),
            .field("delay", Delay?.self),
            .field("scroll", Scroll?.self),
            .field("condition", Condition?.self),
          ] }

          public var onAllUrl: Bool? { __data["onAllUrl"] }
          public var onLoadPage: Bool? { __data["onLoadPage"] }
          public var delay: Delay? { __data["delay"] }
          public var scroll: Scroll? { __data["scroll"] }
          public var condition: Condition? { __data["condition"] }
          public var id: ToldAPI.ID { __data["id"] }
          public var survey: ToldAPI.ID { __data["survey"] }
          public var kind: String? { __data["kind"] }

          /// GetEverySurveyAvailableToBeTriggered.AsSurveyTriggerURL.Delay
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

          /// GetEverySurveyAvailableToBeTriggered.AsSurveyTriggerURL.Scroll
          ///
          /// Parent Type: `SurveyTriggerURLScroll`
          public struct Scroll: ToldAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ToldAPI.Objects.SurveyTriggerURLScroll }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("value", Int.self),
              .field("active", Bool.self),
            ] }

            public var value: Int { __data["value"] }
            public var active: Bool { __data["active"] }
          }

          /// GetEverySurveyAvailableToBeTriggered.AsSurveyTriggerURL.Condition
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

        /// GetEverySurveyAvailableToBeTriggered.AsSurveyTriggerClick
        ///
        /// Parent Type: `SurveyTriggerClick`
        public struct AsSurveyTriggerClick: ToldAPI.InlineFragment {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public typealias RootEntityType = GetEverySurveyAvailableToBeTriggeredQuery.Data.GetEverySurveyAvailableToBeTriggered
          public static var __parentType: Apollo.ParentType { ToldAPI.Objects.SurveyTriggerClick }
          public static var __selections: [Apollo.Selection] { [
            .field("variable", String.self),
            .field("value", String.self),
          ] }

          public var variable: String { __data["variable"] }
          public var value: String { __data["value"] }
          public var id: ToldAPI.ID { __data["id"] }
          public var survey: ToldAPI.ID { __data["survey"] }
          public var kind: String? { __data["kind"] }
        }

        /// GetEverySurveyAvailableToBeTriggered.AsSurveyTriggerCustomEvent
        ///
        /// Parent Type: `SurveyTriggerCustomEvent`
        public struct AsSurveyTriggerCustomEvent: ToldAPI.InlineFragment {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public typealias RootEntityType = GetEverySurveyAvailableToBeTriggeredQuery.Data.GetEverySurveyAvailableToBeTriggered
          public static var __parentType: Apollo.ParentType { ToldAPI.Objects.SurveyTriggerCustomEvent }
          public static var __selections: [Apollo.Selection] { [
            .field("eventName", String?.self),
            .field("conditions", [Condition?]?.self),
          ] }

          public var eventName: String? { __data["eventName"] }
          public var conditions: [Condition?]? { __data["conditions"] }
          public var id: ToldAPI.ID { __data["id"] }
          public var survey: ToldAPI.ID { __data["survey"] }
          public var kind: String? { __data["kind"] }

          /// GetEverySurveyAvailableToBeTriggered.AsSurveyTriggerCustomEvent.Condition
          ///
          /// Parent Type: `SurveyTriggerCustomEventCondition`
          public struct Condition: ToldAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ToldAPI.Objects.SurveyTriggerCustomEventCondition }
            public static var __selections: [Apollo.Selection] { [
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