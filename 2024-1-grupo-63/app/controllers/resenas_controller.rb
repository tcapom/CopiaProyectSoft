class ResenasController < ApplicationController

  # Crea una reseña para una actividad particular
  # @param [int] actividad_id
  # @param [int] calificacion
  # @param [string] contenido
  def create
      @actividad = Actividad.find(params[:actividad_id])
      @resena = @actividad.resenas.build(resenas_params)
      @resena.user = current_user

      puts resenas_params[:calificacion]
      if @resena.save
        redirect_to @actividad, notice: 'Comentario publicado con éxito.'
      else
        flash.now[:error_messages] = @resena.errors.full_messages
        redirect_to @actividad, alert: 'Error al publicar el comentario.'
      end
  

  end


  # Borra una reseña según su id y el id de la actividad a la cual pertenece
  # @param [int] actividad_id
  # @param [int] id
  def destroy
    @actividad = Actividad.find(params[:actividad_id])
    @resena = @actividad.resenas.find(params[:id])
    if @resena.destroy
      redirect_to @actividad, notice: 'Reseña eliminada exitosamente.'
    else
      redirect_to @actividad, alert: 'Error al eliminar la reseña.'
    end
  end

  private 

  def resenas_params
    params.require(:resena).permit(:contenido, :calificacion)
  end
end
