class Mailers::ConfirmEmail
  include Hanami::Mailer
  include Hanami::Helpers

  from    'listswebapp@gmail.com'
  to      :recipient
  subject 'Confirm Your Email Address'

  def recipient
    user.email
  end
end
