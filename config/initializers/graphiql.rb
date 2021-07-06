if Rails.env.development?
  GraphiQL::Rails.config.headers['Auth'] = -> (_ctx) {
    "#{ENV['JWT_TOKEN']}"
  }
end
