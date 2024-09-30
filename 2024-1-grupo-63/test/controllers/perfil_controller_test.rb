require "test_helper"

class PerfilControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:bueno)
    @mutuals1 = users(:mutuals1)
    @mutuals2 = users(:mutuals2)
    @additional_table = additional_tables(:additional_table_bueno)
    sign_in @user  # Inicia sesión con devise
  end

  test "should get perfil_usuario" do
    get perfil_url
    assert_response :success
  end

  test "should get modificar" do
    get perfil_modificar_url
    assert_response :success
  end

  test "should redirect ver_perfil to perfil if current_user" do
    get ver_perfil_url(@user)
    assert_redirected_to perfil_url
  end

  test "should show ver_perfil for other user" do
    get ver_perfil_url(@mutuals1)
    assert_response :success
    assert_not_nil assigns(:user_buscado)
  end

  test "should send follow request" do
    assert_difference('FollowRequest.count') do
      post request_follow_user_url(@mutuals2)
    end
    assert_redirected_to ver_perfil_url(@mutuals2)
  end

  test "should unfollow user" do
    delete unfollow_user_url(@mutuals1)
    assert_redirected_to ver_perfil_url(@mutuals1)
  end

  #test "should accept follow request" do  #Solucionable??
  #  follow_request = FollowRequest.create(follower: @mutuals2, followed: @user, status: "pending")
  #  post accept_follow_user_url(follow_request)
  #  assert_redirected_to perfil_url
  #  assert_equal "accepted", follow_request.reload.status
  #  assert_includes @user.followers, @mutuals1
  #end

  test "should reject follow request" do
    follow_request = FollowRequest.create(follower: @mutuals1, followed: @user, status: "pending")
    post reject_follow_user_url(follow_request)
    assert_redirected_to perfil_url
    assert_equal "rejected", follow_request.reload.status
  end

  test "should get followers_especifico" do
    get followers_url
    assert_response :success
    assert_not_nil assigns(:followers)
  end

  test "should get followers" do
    get followers_url
    assert_response :success
    assert_not_nil assigns(:followers)
  end

  test "should get followers_de_otro" do
    get followers_de_otro_url(@mutuals1)
    assert_response :success
    assert_not_nil assigns(:followers)
  end

  test "should destroy user account" do
    assert_difference('User.count', -1) do
      delete destroy_user_url(@user)
    end
    assert_redirected_to root_url
  end

  test "should not destroy other user account" do
    assert_no_difference('User.count') do
      delete destroy_user_url(@mutuals1)
    end
  end
end
