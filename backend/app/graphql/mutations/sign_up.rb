require_relative '../types/user_type'
module Mutations
  class SignUp < BaseMutation
    argument :name, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true
    argument :business_name, String, required: false
    argument :business_address, String, required: false
    argument :phone, String, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(name:, email:, password:, business_name: nil, business_address: nil, phone: nil)
      user = User.new(
        name: name,
        email: email,
        password: password,
        business_name: business_name,
        business_address: business_address,
        phone: phone,
        role: 'merchant'
      )
      if user.save
        token, _payload = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil)
        {token: token, user: user, errors: []}
      else
        {token: nil, user: nil, errors: user.errors.full_messages}
      end
    end
  end
end