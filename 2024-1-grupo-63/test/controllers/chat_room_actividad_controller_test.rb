require "test_helper"

class ChatRoomActividadControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:bueno)
    @other_user = users(:bueno2)
    @actividad = actividads(:bueno)
    @chat_room_actividad = chat_room_actividads(:bueno)
    @actividad_nadie_pertenece = actividads(:nadie_pertenece)
    sign_in @user  # Inicia sesión con devise
  end

  #test "should redirect from index to home index" do
  #  get chat_room_actividad_index_url
  #  assert_redirected_to home_index_url
  #end

  test "should show chat room actividad if authorized" do
    # Agregar el usuario a la actividad para que esté autorizado
    @actividad.users << @user
    get chat_room_actividad_url(@chat_room_actividad.id)
    assert_response :success
    assert_not_nil assigns(:actividad)
    assert_not_nil assigns(:chat_room_actividad)
    assert_not_nil assigns(:actividad_messages)
  end

  #test "should redirect to actividad index if unauthorized" do
  #  # No agregamos al usuario a la actividad, por lo que no estará autorizado
  #  get chat_room_actividad_url(@chat_room_actividad.id)
  #  assert_redirected_to actividad_index_url
  #  assert_not_empty flash[:alert]
  #end

  #test "should get messages" do
  #  # Agregar el usuario a la actividad para que esté autorizado
  #  @actividad.users << @user
  #  get messages_chat_room_actividad_url(@chat_room_actividad.id)
  #  assert_response :success
  #  assert_template partial: '_messages'
  #  assert_not_nil assigns(:actividad_messages)
  #end

  test "should set actividad before show" do
    get chat_room_actividad_url(@chat_room_actividad.id)
    assert_not_nil assigns(:actividad)
  end


end
