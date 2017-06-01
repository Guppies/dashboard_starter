FactoryGirl.define do
  factory :email do
    body    '<h1>Hello</h1>'
    subject 'Hola!'

    # after(:build) { |email| email.class.skip_callback(:create, :after, :send_mailgun) }
  end
end
