require_relative '../../../spec_helper'                                                                          
                                                                                                                 
describe Web::Views::Users::New do
  let(:exposures) { Hash[flash: {}, params: {}] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/users/new.html.erb') }
  let(:view)      { Web::Views::Users::New.new(template, exposures) }
  let(:rendered)  { view.render }
                                                                                                                 
  it 'displays the email and password fields' do
    rendered.must_include '<div class="email-input">'
    rendered.must_include '<div class="password-input">'
		rendered.must_include '<div class="password-confirmation-input">'
  end

  describe 'with flash messages' do
    let(:exposures) { Hash[flash: { email: 'Email has been taken', input_errors: ['Email must be filled', 'Password must be filled'] }, params: {}] }

    it 'displays the email taken flash message' do
      rendered.must_include 'Email has been taken'
    end
		
		it 'dispalys the fields missing flash messages' do
			rendered.must_include 'Email must be filled'
			rendered.must_include 'Password must be filled'
		end
  end
end

