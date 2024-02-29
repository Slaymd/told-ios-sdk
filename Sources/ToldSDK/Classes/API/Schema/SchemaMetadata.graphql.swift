// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

protocol ToldAPI_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == ToldAPI.SchemaMetadata {}

protocol ToldAPI_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == ToldAPI.SchemaMetadata {}

protocol ToldAPI_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == ToldAPI.SchemaMetadata {}

protocol ToldAPI_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == ToldAPI.SchemaMetadata {}

extension ToldAPI {
  typealias ID = String

  typealias SelectionSet = ToldAPI_SelectionSet

  typealias InlineFragment = ToldAPI_InlineFragment

  typealias MutableSelectionSet = ToldAPI_MutableSelectionSet

  typealias MutableInlineFragment = ToldAPI_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
      switch typename {
      case "Query": return ToldAPI.Objects.Query
      case "SurveyTriggerURL": return ToldAPI.Objects.SurveyTriggerURL
      case "SurveyTriggerScreen": return ToldAPI.Objects.SurveyTriggerScreen
      case "SurveyTriggerClick": return ToldAPI.Objects.SurveyTriggerClick
      case "SurveyTriggerCustomEvent": return ToldAPI.Objects.SurveyTriggerCustomEvent
      case "whenData": return ToldAPI.Objects.WhenData
      case "SurveyTriggerDelay": return ToldAPI.Objects.SurveyTriggerDelay
      case "SurveyTriggerURLCondition": return ToldAPI.Objects.SurveyTriggerURLCondition
      case "SurveyTriggerCustomEventCondition": return ToldAPI.Objects.SurveyTriggerCustomEventCondition
      case "CanUseSurvey": return ToldAPI.Objects.CanUseSurvey
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}