require "test_helper"

class ResenasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:bueno)
    @actividad = actividads(:bueno)
    @resena = resenas(:resena_one)
    sign_in @user
  end

  test "should create resena" do
    assert_difference('Resena.count') do
      post actividad_resenas_url(@actividad), params: { resena: { contenido: "Nueva reseña", calificacion: 4 } }
    end

    assert_redirected_to actividad_url(@actividad)
    follow_redirect!
    assert_not_nil flash[:notice]
    assert_equal 'Comentario publicado con éxito.', flash[:notice]
  end

  test "should not create resena with invalid params" do
    assert_no_difference('Resena.count') do
      post actividad_resenas_url(@actividad), params: { resena: { contenido: "no calificacion", calificacion: "" } }
    end

    assert_redirected_to actividad_url(@actividad)
    follow_redirect!
    assert_not_nil flash[:alert]
    assert_equal 'Error al publicar el comentario.', flash[:alert]
  end

  test "should destroy resena" do
    assert_difference('Resena.count', -1) do
      delete actividad_resena_url(@actividad, @resena)
    end

    assert_redirected_to actividad_url(@actividad)
    follow_redirect!
    assert_not_nil flash[:notice]
    assert_equal 'Reseña eliminada exitosamente.', flash[:notice]
  end


end