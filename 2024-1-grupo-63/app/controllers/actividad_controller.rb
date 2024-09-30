class ActividadController < ApplicationController

    # Enlista todas las actividades no archivadas
    def index
        if params[:search]
          @actividades = Actividad.where("titulo LIKE ?", "%#{params[:search]}%")
        else
          @actividades = Actividad.all
        end
      end
    
    # Muestra toda la información pertinente de una actividad particular
    # @param [int] id
    def show
      if params[:id] == "crear_actividad"
        redirect_to "/crear_actividad"
      else
        @actividad = Actividad.find(params[:id])
        @usuario = current_user
        @admin = User.all.find_by(id: @actividad.memberships.find_by(admin: true).user_id)
        @resenas = @actividad.resenas 
        @suma_calificaciones = @resenas.sum(:calificacion)
        @contador_calificaciones = @resenas.count
      end
    end
    
    # Crea una nueva actividad, asignando que el usuario quien la creó es miembro y owner de la actividad
    # @param [string] titulo
    # @param [string] descripcion
    # @param [string] url_imagen
    # @param [int] valor
    def create
        @actividad = Actividad.new(titulo: params[:actividad][:titulo], 
                           descripcion: params[:actividad][:descripcion], 
                           url_imagen: params[:actividad][:url_imagen],
                           valor: params[:actividad][:valor])
        user_email = params[:actividad][:user_email]
        usuario_pillado = User.find_by(email: user_email)
        puts params[:id]
        @actividad.users << usuario_pillado
        @actividad.user_id = usuario_pillado.id
        if @actividad.descripcion == ""
          @actividad.descripcion = "(Sin descripción)"
        end
        @chat_room_actividad = ChatRoomActividad.new(name: @actividad.titulo)
        
        if @actividad.save
          relacion = @actividad.memberships.find_by(user_id: usuario_pillado.id)
          relacion.update(admin: true)
          @chat_room_actividad.actividad_id = @actividad.id
          if @chat_room_actividad.save
            @actividad.chat_room_actividad = @chat_room_actividad
            redirect_to actividad_path(@actividad), notice: 'Actividad creada exitosamente.'
          end
        else
          redirect_to "/crear_actividad", alert: 'Error al crear la actividad.'
        end
      end

    # Enlista las actividades a las que pertenece el usuario en sesión
    def ver_actividades_user
      @usuario = current_user
      @actividades_user = @usuario.actividads
    end

    # Enlista todos los miembros perteneciones a una actividad específica
    # @param [int] id
    def ver_miembros
      puts params
      @actividad = Actividad.find_by(id: params[:id])
      @admin_actividad = Membership.find_by(id: @actividad.user_id)
      @admin_actividad_user
    end

    # Elimina un usuario de una actividad
    # @param [int] id
    # @param [int] usuario_id 
    def sacar_miembro
      @actividad = Actividad.find_by(id: params[:id])
      @user_deleted = User.find_by(id: params[:usuario_id])
      @actividad.users.delete(@user_deleted)
      redirect_to "/ver_miembros"
    end

    # Elimina una actividad
    def destroy
      @actividad = Actividad.find(params[:id])
      if current_user.global_admin
        @actividad.destroy
        respond_to do |format|
          format.html { redirect_to actividad_index_path, notice: 'La actividad fue eliminada exitosamente.' }
        end
      else
        redirect_to actividad_path(@actividad), alert: 'No tienes permiso para realizar esta acción.'
      end
    end
    # Enlista todas las actividades archivadas
    # @param [int] id
    def archived_index
      @actividades = Actividad.where(archivado: true)
    end

    # Archiva una actividad, tal que no aparezca en el buscador principal de actividades
    def archive
      @actividad = Actividad.find(params[:id])
      if @actividad.memberships.exists?(user_id: current_user.id, admin: true)
        @actividad.update(archivado: true)
        redirect_to actividad_path(@actividad), notice: 'La actividad fue archivada exitosamente.'
      else
        redirect_to actividad_path(@actividad), alert: 'No tienes permiso para realizar esta acción.'
      end
    end

  # Actualiza la foto de una actividad
  # @param [int] id
  def update_photo
    @actividad = Actividad.find(params[:id])
    @actividad.url_imagen.attach(params[:actividad][:url_imagen])
    if @actividad.save
      redirect_to actividad_path(@actividad), notice: 'Foto actualizada exitosamente.'
    else
      redirect_to actividad_path(@actividad), alert: 'Error al actualizar la foto.'
    end

  end
end
