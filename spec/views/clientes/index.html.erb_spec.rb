require 'rails_helper'

RSpec.describe "clientes/index", type: :view do
  before(:each) do
    assign(:clientes, [
      Cliente.create!(
        :nome => "Nome",
        :telefone => "Telefone",
        :cpf => "Cpf"
      ),
      Cliente.create!(
        :nome => "Nome",
        :telefone => "Telefone",
        :cpf => "Cpf"
      )
    ])
  end

  it "renders a list of clientes" do
    render
    assert_select "tr>td", :text => "Nome".to_s, :count => 2
    assert_select "tr>td", :text => "Telefone".to_s, :count => 2
    assert_select "tr>td", :text => "Cpf".to_s, :count => 2
  end
end
