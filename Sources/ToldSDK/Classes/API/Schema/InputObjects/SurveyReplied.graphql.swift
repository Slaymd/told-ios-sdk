// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public extension ToldAPI {
  struct SurveyReplied: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      surveyId: GraphQLNullable<ID> = nil,
      date: GraphQLNullable<Date> = nil,
      replied: GraphQLNullable<Bool> = nil
    ) {
      __data = InputDict([
        "surveyId": surveyId,
        "date": date,
        "replied": replied
      ])
    }

    public var surveyId: GraphQLNullable<ID> {
      get { __data["surveyId"] }
      set { __data["surveyId"] = newValue }
    }

    public var date: GraphQLNullable<Date> {
      get { __data["date"] }
      set { __data["date"] = newValue }
    }

    public var replied: GraphQLNullable<Bool> {
      get { __data["replied"] }
      set { __data["replied"] = newValue }
    }
  }

}