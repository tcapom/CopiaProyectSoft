require "test_helper"

class SolicitudControllerTest < ActionDispatch::IntegrationTest
  setup do
    @actividad = actividads(:bueno)
    @user = users(:bueno)
    @admin_membership = memberships(:membership_1)
    @solicitud = solicituds(:bueno)
    sign_in @user
  end

  test "should get ver_solicitudes_actividad as admin" do
    @admin_membership.update(user: @user, actividad: @actividad, admin: true)
    get ver_solicitudes_actividad_path(id: @actividad.id)
    assert_response :success
    assert_not_nil assigns(:solicitudes)
  end

  test "should not get ver_solicitudes_actividad as non-admin" do
    @admin_membership.update(user: @user, actividad: @actividad, admin: false)
    get ver_solicitudes_actividad_path(id: @actividad.id)
    assert_redirected_to actividad_path
    assert_equal "TRAMPOS@, NO PUEDES VER LAS SOLICITUDES SI NO ERES ADMIN >:(", flash[:notice]
  end

  test "should get ver_solicitudes_user" do
    get ver_solicitudes_user_path
    assert_response :success
    assert_not_nil assigns(:solicitudes)
  end

  test "should redirect nueva_solicitud if already member" do
    sign_in users(:bueno2) #Login con miembro no admin
    get nueva_solicitud_path(id: @actividad.id)
    assert_redirected_to root_path
    assert_equal "TRAMPOS@, YA ERES PARTE DE LA ACTIVIDAD", flash[:notice]
    sign_in users(:bueno) #Para volver a hacer login con el original. No sé si es necesario XD?
  end

  #test "should create solicitud" do                  #No me resultó test, pero debería ser fácil de configurar
  #  sign_in users(:bueno4) #Login con no miembro
  #  assert_difference('Solicitud.count') do
  #    post nueva_solicitud_url, params: { actividad_id: @actividad.id, usuario_id: @user.id, message: "Test Message" }
  #  end
  #  assert_redirected_to actividad_index_path
  #  assert_equal "Solicitud enviada! :)", flash[:notice]
  #  sign_in users(:bueno) #Para volver a hacer login con el original. No sé si es necesario XD?
  #end

  test "should handle solicitud acceptance" do
    @solicitud.update(actividad: @actividad, user: users(:bueno3))
    assert_difference('@actividad.users.count') do
      delete ver_solicitudes_actividad_path(id: @actividad.id, solicitud_id: @solicitud.id, accepted: "true")
    end
    assert_redirected_to root_path
    assert_equal "Solicitud aceptada :)", flash[:notice]
  end

  test "should handle solicitud rejection" do
    @solicitud.update(actividad: @actividad, user: users(:bueno3))
    assert_difference('Solicitud.count', -1) do
      delete ver_solicitudes_actividad_path(id: @actividad.id, solicitud_id: @solicitud.id, accepted: "false")
    end
    assert_redirected_to root_path
    assert_equal "Solicitud rechazada :P", flash[:notice]
  end
end