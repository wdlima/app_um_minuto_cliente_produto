require 'rails_helper'

RSpec.describe "produtos/index", type: :view do
  before(:each) do
    assign(:produtos, [
      Produto.create!(
        :nome => "Nome",
        :preco => 2.5,
        :descricao => "MyText"
      ),
      Produto.create!(
        :nome => "Nome",
        :preco => 2.5,
        :descricao => "MyText"
      )
    ])
  end

  it "renders a list of produtos" do
    render
    assert_select "tr>td", :text => "Nome".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
