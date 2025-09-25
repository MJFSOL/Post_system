module Mutations
  class SignIn < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(email:, password:)
      user = User.find_by(email: email)

      if user&.valid_password?(password)
        begin
          # Check the return value carefully. The method returns an array.
          token, _payload = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil)
          return { token: token, user: user, errors: [] }
        rescue StandardError => e
          # Catch any error during token generation
          return { token: nil, user: nil, errors: ["Failed to generate authentication token: #{e.message}"] }
        end
      else
        { token: nil, user: nil, errors: ['Invalid email or password'] }
      end
    end
  end
end