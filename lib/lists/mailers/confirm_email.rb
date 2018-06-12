class Mailers::ConfirmEmail
  include Hanami::Mailer
  include Hanami::Helpers

  from    'grace@stembolt.com'
  to      :recipient
  subject 'Confirm Your Email Address'

  private

  def recipient
    user.email
  end
end
