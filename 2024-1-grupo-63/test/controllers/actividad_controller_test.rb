require "test_helper"

class ActividadControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  setup do
    @user = users(:bueno2)
    @other_user = users(:bueno)
    @actividad = actividads(:bueno)
    @archived_actividad = actividads(:archivada)
    sign_in @user
  end

  test "should get index" do
    get actividad_index_url
    assert_response :success
    assert_not_nil assigns(:actividades)
  end

  test "should get index with search" do
    get actividad_index_url, params: { search: 'Primera' }
    assert_response :success
    assert_not_nil assigns(:actividades)
  end

  test "should show actividad" do
    get actividad_url(@actividad)
    assert_response :success
    assert_not_nil assigns(:actividad)
    assert_not_nil assigns(:usuario)
    assert_not_nil assigns(:admin)
    assert_not_nil assigns(:resenas)
  end

  test "should create actividad" do
    assert_difference('Actividad.count') do
      post crear_actividad_url, params: {
        actividad: {
          titulo: 'Nueva actividad',
          valor: 123,
          descripcion: 'Descripción de la nueva actividad',
          user_email: @user.email
        }
      }
    end
    assert_redirected_to actividad_path(Actividad.last)
  end

  test "should not create actividad with invalid params" do
    assert_no_difference('Actividad.count') do
      post crear_actividad_url, params: {
        actividad: {
          titulo: '',
          descripcion: 'Descripción sin título',
          user_email: @user.email
        }
      }
    end
    assert_redirected_to "/crear_actividad"
  end

  test "should get ver_actividades_user" do
    get ver_actividades_user_url
    assert_response :success
    assert_not_nil assigns(:actividades_user)
  end



  test "should remove miembro from actividad" do
    assert_difference('@actividad.users.count', -1) do
      delete ver_miembros_url(id: @actividad.id, usuario_id: @user.id)
    end
    assert_redirected_to "/ver_miembros"
  end

  test "should destroy actividad" do
    sign_in users(:admin) # Asegurarse de que el usuario actual es un admin global
    assert_difference('Actividad.count', -1) do
      delete actividad_url(@actividad)
    end
    assert_redirected_to actividad_index_url
  end

  test "should not destroy actividad if not admin" do
    assert_no_difference('Actividad.count') do
      delete actividad_url(@actividad)
    end
    assert_redirected_to actividad_path(@actividad)
  end

  #test "should get archived index" do
  #  get archived_index_actividad_url
  #  assert_response :success
  #  assert_not_nil assigns(:actividades)
  #end

  test "should archive actividad" do
    @actividad.memberships.create(user_id: @user.id, admin: true) # Asegurar que el usuario es admin de la actividad
    patch archive_actividad_url(@actividad)
    assert_redirected_to actividad_path(@actividad)
    @actividad.reload
    assert @actividad.archivado
  end

  test "should not archive actividad if not admin" do
    patch archive_actividad_url(@actividad)
    assert_redirected_to actividad_path(@actividad)
    @actividad.reload
    assert_not @actividad.archivado
  end
end
