class BaseService
  extend Dry::Initializer[undefined: false]

  def wrap(**kwargs)
    result = kwargs[:result]
    instance = kwargs[:instance]
    errors = kwargs[:errors]

    OpenStruct.new(result?: result,
                   instance: instance,
                   errors: errors)
  end
end
