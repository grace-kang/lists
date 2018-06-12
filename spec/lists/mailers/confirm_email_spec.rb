require_relative '../../spec_helper'

describe Mailers::ConfirmEmail do
  include Import['repositories.user']

  before do
    user.clear
    Hanami::Mailer.deliveries.clear

    @user = user.create(email: 'email', hashed_pass: hashed_password('pass'), email_confirmed: false, token: 'test')
  end

  it 'delivers an email confirmation link' do
    Mailers::ConfirmEmail.deliver(user: @user)
    mail = Hanami::Mailer.deliveries.last

    expect(mail.to).must_equal ([@user.email])
    expect(mail.body.encoded).must_include ("Hi #{@user.email},")
  end
end
