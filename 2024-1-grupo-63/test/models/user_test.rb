require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user bueno" do
    usuario = users(:bueno)
    assert usuario.valid?
  end

  test "additional_table bueno" do
    usuario = users(:bueno)
    usuario.save
    additional_table = usuario.additional_table
    assert additional_table.phone == "Agrega un número de téfono"
    assert additional_table.username == "Crea un nombre"
    assert additional_table.pronouns == "Agrega pronombres"
  end

  test "user malo" do
    usuario = User.new(email: "test@example.com")
    assert_not usuario.valid?

    
  end
end
