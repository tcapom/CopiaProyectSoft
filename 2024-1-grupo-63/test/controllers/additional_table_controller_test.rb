require "test_helper"

class AdditionalTableControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:bueno)
    @additional_table = additional_tables(:additional_table_bueno)
    sign_in @user  # Inicia sesión con devise
  end

  test "should get agregar_info" do
    get agregar_info_url
    assert_response :success
  end

  test "should modify additional table info" do
    patch nueva_info_url, 
          params: { phone: "123456789", username: "new_username", pronouns: "they/them", biografia: "New biography" }
    assert_redirected_to perfil_url
    @additional_table.reload
    assert_equal "123456789", @additional_table.phone
    assert_equal "new_username", @additional_table.username
    assert_equal "they/them", @additional_table.pronouns
    assert_equal "New biography", @additional_table.biografia
  end

  test "should search and find user by email" do
    get search_url, params: { email: @user.email }
    assert_redirected_to ver_perfil_url(@user.id)
  end

  test "should display error when user not found in search" do
    get search_url, params: { email: "nonexistent@example.com" }
    assert_redirected_to root_url
    assert_not_empty flash[:error]
  end



  test "should preserve existing info if not provided in params" do
    original_phone = @additional_table.phone
    patch nueva_info_url, params: { username: "another_username" }
    assert_redirected_to perfil_url
    @additional_table.reload
    assert_equal original_phone, @additional_table.phone
    assert_equal "another_username", @additional_table.username
  end
end