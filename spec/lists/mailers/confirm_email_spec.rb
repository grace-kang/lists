require_relative '../../spec_helper'

describe Mailers::ConfirmEmail do
  include Import['repositories.user']
  before { Hanami::Mailer.deliveries.clear}

  let(:user) { user.create(email: 'email', hashed_pass: hasahed_password('pass'), email_confirmed: false, token: 'test') }

  it 'delivers an email confirmation link' do
    Mailers::ConfirmEmail.deliver(user: user)
    mail = Hanami::Mailer.deliveries.last

    expect(mail.to).to eq([user.email])
    expect(mail.body.encoded).to eq("Confirm Your Email Address")
  end
end
