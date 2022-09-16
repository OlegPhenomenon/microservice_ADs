module Ads
  class BaseService
    extend Dry::Initializer[undefined: false]

    def wrap(state)
      return type_error unless state.kind_of?(Array)

      result = state[0]
      instance = state[1]
      errors = state[2]

      OpenStruct.new(result: result,
                    instance: instance,
                    errors: errors)
    end
    
    def type_error
      OpenStruct.new(result: false,
                     instance: nil,
                     errors: "Type error. Expected array!")
    end
  end
end
