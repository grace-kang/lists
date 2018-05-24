require_relative '../../../../spec_helper'

describe Web::Views::Home::Index do
  let(:exposures) { Hash[lists: []] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/home/index.html.erb') }
  let(:view)      { Web::Views::Home::Index.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #lists' do
    view.lists.must_equal exposures.fetch(:lists)
  end

  describe 'when there are no lists' do
    it 'shows a placeholder message' do
      rendered.must_include('<p class="placeholder">There are no lists yet.</p>')
    end
  end

  describe 'when there are lists' do
    let(:list1)     { List.new(name: 'Groceries') }
    let(:list2)     { List.new(name: 'Homework') }
    let(:exposures) { Hash[lists: [list1, list2]] }

    it 'lists them all' do
      rendered.scan(/class="list"/).count.must_equal 2
      rendered.must_include('Groceries')
      rendered.must_include('Homework')
    end

    it 'hides the placeholder message' do
      rendered.wont_include('<p class="placeholder">There are no lists yet.</p>')
    end
  end
end