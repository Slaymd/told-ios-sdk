// @generated
// This file was automatically generated and should not be edited.

import Apollo

public protocol ToldAPI_SelectionSet: Apollo.SelectionSet & Apollo.RootSelectionSet
where Schema == ToldAPI.SchemaMetadata {}

public protocol ToldAPI_InlineFragment: Apollo.SelectionSet & Apollo.InlineFragment
where Schema == ToldAPI.SchemaMetadata {}

public protocol ToldAPI_MutableSelectionSet: Apollo.MutableRootSelectionSet
where Schema == ToldAPI.SchemaMetadata {}

public protocol ToldAPI_MutableInlineFragment: Apollo.MutableSelectionSet & Apollo.InlineFragment
where Schema == ToldAPI.SchemaMetadata {}

public extension ToldAPI {
  typealias ID = String

  typealias SelectionSet = ToldAPI_SelectionSet

  typealias InlineFragment = ToldAPI_InlineFragment

  typealias MutableSelectionSet = ToldAPI_MutableSelectionSet

  typealias MutableInlineFragment = ToldAPI_MutableInlineFragment

  enum SchemaMetadata: Apollo.SchemaMetadata {
    public static let configuration: Apollo.SchemaConfiguration.Type = SchemaConfiguration.self

    public static func objectType(forTypename typename: String) -> Object? {
      switch typename {
      case "Query": return ToldAPI.Objects.Query
      case "SurveyTriggerURL": return ToldAPI.Objects.SurveyTriggerURL
      case "SurveyTriggerScreen": return ToldAPI.Objects.SurveyTriggerScreen
      case "SurveyTriggerClick": return ToldAPI.Objects.SurveyTriggerClick
      case "SurveyTriggerCustomEvent": return ToldAPI.Objects.SurveyTriggerCustomEvent
      case "SurveyTriggerDelay": return ToldAPI.Objects.SurveyTriggerDelay
      case "SurveyTriggerURLScroll": return ToldAPI.Objects.SurveyTriggerURLScroll
      case "SurveyTriggerURLCondition": return ToldAPI.Objects.SurveyTriggerURLCondition
      case "SurveyTriggerCustomEventCondition": return ToldAPI.Objects.SurveyTriggerCustomEventCondition
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}