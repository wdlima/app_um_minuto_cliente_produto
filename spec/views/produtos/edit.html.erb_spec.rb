require 'rails_helper'

RSpec.describe "produtos/edit", type: :view do
  before(:each) do
    @produto = assign(:produto, Produto.create!(
      :nome => "MyString",
      :preco => 1.5,
      :descricao => "MyText"
    ))
  end

  it "renders the edit produto form" do
    render

    assert_select "form[action=?][method=?]", produto_path(@produto), "post" do

      assert_select "input#produto_nome[name=?]", "produto[nome]"

      assert_select "input#produto_preco[name=?]", "produto[preco]"

      assert_select "textarea#produto_descricao[name=?]", "produto[descricao]"
    end
  end
end
