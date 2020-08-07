require 'rails_helper'

RSpec.describe "produtos/new", type: :view do
  before(:each) do
    assign(:produto, Produto.new(
      :nome => "MyString",
      :preco => 1.5,
      :descricao => "MyText"
    ))
  end

  it "renders new produto form" do
    render

    assert_select "form[action=?][method=?]", produtos_path, "post" do

      assert_select "input#produto_nome[name=?]", "produto[nome]"

      assert_select "input#produto_preco[name=?]", "produto[preco]"

      assert_select "textarea#produto_descricao[name=?]", "produto[descricao]"
    end
  end
end
