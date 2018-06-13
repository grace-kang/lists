require_relative '../../../spec_helper'

describe Web::Views::Home::Login do
  let(:exposures) { Hash[flash: {}, params: {}] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/home/login.html.erb') }
  let(:view)      { Web::Views::Home::Login.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'displays the login  and signup button' do
    rendered.must_include '<div class="login button">'
    rendered.must_include '<div class="signup button">'
  end

  describe 'with flash message' do
    let(:exposures) { Hash[flash: { signup_success: 'Successfully signed up! Please log in.' }, params: {}] }

    it 'displays the flash message' do
      rendered.must_include 'Successfully signed up! Please log in.'
    end
  end
end
