// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension ToldAPI {
  class GetEverySurveyAvailableToBeTriggeredQuery: GraphQLQuery {
    static let operationName: String = "getEverySurveyAvailableToBeTriggered"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query getEverySurveyAvailableToBeTriggered($folderID: ID!, $type: String!, $os: String, $mobileApp: String, $language: String, $version: String, $listReplied: [SurveyReplied], $preview: Boolean) { getEverySurveyAvailableToBeTriggered( folderID: $folderID type: $type os: $os mobileApp: $mobileApp language: $language version: $version listReplied: $listReplied preview: $preview ) { __typename id survey kind whenData { __typename seeItOnlyOnce replyOnlyOnce } ... on SurveyTriggerScreen { onAllScreen onLoadScreen delay { __typename value active } condition { __typename variable operator value } } ... on SurveyTriggerCustomEvent { eventName conditions { __typename key operator value } } } }"#
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

    struct Data: ToldAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
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

      var getEverySurveyAvailableToBeTriggered: [GetEverySurveyAvailableToBeTriggered?]? { __data["getEverySurveyAvailableToBeTriggered"] }

      /// GetEverySurveyAvailableToBeTriggered
      ///
      /// Parent Type: `SurveyTrigger`
      struct GetEverySurveyAvailableToBeTriggered: ToldAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { ToldAPI.Interfaces.SurveyTrigger }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", ToldAPI.ID.self),
          .field("survey", ToldAPI.ID.self),
          .field("kind", String?.self),
          .field("whenData", WhenData?.self),
          .inlineFragment(AsSurveyTriggerScreen.self),
          .inlineFragment(AsSurveyTriggerCustomEvent.self),
        ] }

        var id: ToldAPI.ID { __data["id"] }
        var survey: ToldAPI.ID { __data["survey"] }
        var kind: String? { __data["kind"] }
        var whenData: WhenData? { __data["whenData"] }

        var asSurveyTriggerScreen: AsSurveyTriggerScreen? { _asInlineFragment() }
        var asSurveyTriggerCustomEvent: AsSurveyTriggerCustomEvent? { _asInlineFragment() }

        /// GetEverySurveyAvailableToBeTriggered.WhenData
        ///
        /// Parent Type: `WhenData`
        struct WhenData: ToldAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.WhenData }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("seeItOnlyOnce", Bool?.self),
            .field("replyOnlyOnce", Bool?.self),
          ] }

          var seeItOnlyOnce: Bool? { __data["seeItOnlyOnce"] }
          var replyOnlyOnce: Bool? { __data["replyOnlyOnce"] }
        }

        /// GetEverySurveyAvailableToBeTriggered.AsSurveyTriggerScreen
        ///
        /// Parent Type: `SurveyTriggerScreen`
        struct AsSurveyTriggerScreen: ToldAPI.InlineFragment {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          typealias RootEntityType = GetEverySurveyAvailableToBeTriggeredQuery.Data.GetEverySurveyAvailableToBeTriggered
          static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.SurveyTriggerScreen }
          static var __selections: [ApolloAPI.Selection] { [
            .field("onAllScreen", Bool?.self),
            .field("onLoadScreen", Bool?.self),
            .field("delay", Delay?.self),
            .field("condition", Condition?.self),
          ] }

          var onAllScreen: Bool? { __data["onAllScreen"] }
          var onLoadScreen: Bool? { __data["onLoadScreen"] }
          var delay: Delay? { __data["delay"] }
          var condition: Condition? { __data["condition"] }
          var id: ToldAPI.ID { __data["id"] }
          var survey: ToldAPI.ID { __data["survey"] }
          var kind: String? { __data["kind"] }
          var whenData: WhenData? { __data["whenData"] }

          /// GetEverySurveyAvailableToBeTriggered.AsSurveyTriggerScreen.Delay
          ///
          /// Parent Type: `SurveyTriggerDelay`
          struct Delay: ToldAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.SurveyTriggerDelay }
            static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("value", Int.self),
              .field("active", Bool.self),
            ] }

            var value: Int { __data["value"] }
            var active: Bool { __data["active"] }
          }

          /// GetEverySurveyAvailableToBeTriggered.AsSurveyTriggerScreen.Condition
          ///
          /// Parent Type: `SurveyTriggerURLCondition`
          struct Condition: ToldAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.SurveyTriggerURLCondition }
            static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("variable", String.self),
              .field("operator", String.self),
              .field("value", String.self),
            ] }

            var variable: String { __data["variable"] }
            var `operator`: String { __data["operator"] }
            var value: String { __data["value"] }
          }
        }

        /// GetEverySurveyAvailableToBeTriggered.AsSurveyTriggerCustomEvent
        ///
        /// Parent Type: `SurveyTriggerCustomEvent`
        struct AsSurveyTriggerCustomEvent: ToldAPI.InlineFragment {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          typealias RootEntityType = GetEverySurveyAvailableToBeTriggeredQuery.Data.GetEverySurveyAvailableToBeTriggered
          static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.SurveyTriggerCustomEvent }
          static var __selections: [ApolloAPI.Selection] { [
            .field("eventName", String?.self),
            .field("conditions", [Condition?]?.self),
          ] }

          var eventName: String? { __data["eventName"] }
          var conditions: [Condition?]? { __data["conditions"] }
          var id: ToldAPI.ID { __data["id"] }
          var survey: ToldAPI.ID { __data["survey"] }
          var kind: String? { __data["kind"] }
          var whenData: WhenData? { __data["whenData"] }

          /// GetEverySurveyAvailableToBeTriggered.AsSurveyTriggerCustomEvent.Condition
          ///
          /// Parent Type: `SurveyTriggerCustomEventCondition`
          struct Condition: ToldAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.SurveyTriggerCustomEventCondition }
            static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("key", String?.self),
              .field("operator", String?.self),
              .field("value", String?.self),
            ] }

            var key: String? { __data["key"] }
            var `operator`: String? { __data["operator"] }
            var value: String? { __data["value"] }
          }
        }
      }
    }
  }

}