// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension ToldAPI {
  struct SurveyReplied: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
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

    var surveyId: GraphQLNullable<ID> {
      get { __data["surveyId"] }
      set { __data["surveyId"] = newValue }
    }

    var date: GraphQLNullable<Date> {
      get { __data["date"] }
      set { __data["date"] = newValue }
    }

    var replied: GraphQLNullable<Bool> {
      get { __data["replied"] }
      set { __data["replied"] = newValue }
    }
  }

}