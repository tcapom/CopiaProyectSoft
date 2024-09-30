class SolicitudController < ApplicationController

  # Muestra las solicitudes de una actividad indicada solo si el usuario en sesión es admin
  # @param [int] id
  def ver_solicitudes_actividad
    @actividad = Actividad.find_by(id: params[:id].to_i)
    @solicitudes = Solicitud.where(actividad_id: params[:id].to_i)
    if !(@actividad.memberships.find_by(user_id: current_user.id).admin || current_user.global_admin)
      mensaje = "TRAMPOS@, NO PUEDES VER LAS SOLICITUDES SI NO ERES ADMIN >:("
      redirect_back fallback_location: actividad_path, :notice => mensaje
    end

    if @actividad.archivado
      mensaje = "La actividad esta archivada"
      redirect_back fallback_location: actividad_path, :notice => mensaje
    end
  end

  # Muestra las solicitudes del usuario en sesión
  def ver_solicitudes_user
    @solicitudes = Solicitud.where(user_id: current_user)
  end

  # Permite ir al menú de solicitud de unirse sólo si es usuario no pertenece a la actividad
  # ni ha mandado solicitud
  # @param [int] id
  def nueva_solicitud
    @actividad = Actividad.find_by(id: params[:id].to_i)
    if @actividad.archivado
      mensaje = "La actividad esta archivada"
      redirect_back fallback_location: actividad_path, :notice => mensaje
    end
    @admin = Membership.find_by(id: @actividad.user_id)
    @usuario = current_user

    if @actividad.memberships.exists?(user_id: current_user.id)
      if @actividad.memberships.find_by(user_id: current_user.id).admin
        mensaje = "TRAMPOS@, ERES ADMIN DE LA ACTIVIDAD >:("
        redirect_back fallback_location: root_path, :notice => mensaje
      elsif @actividad.solicituds.exists?(user_id: current_user.id)
        mensaje = "TRAMPOS@, YA PEDISTE ENTRAR (deja de spamear porfavor) ;)"
        redirect_back fallback_location: root_path, :notice => mensaje
      else 
        mensaje = "TRAMPOS@, YA ERES PARTE DE LA ACTIVIDAD"
        redirect_back fallback_location: root_path, :notice => mensaje
      end
    end
  end

  # Crea la solicitud a la actividad correspondiente
  # @param [int] actividad_id
  # @param [int] usuario_id
  def crear_solicitud
    @actividad = Actividad.find(params[:actividad_id].to_i)
    @usuario = User.find(params[:usuario_id].to_i)
    @new_solicitud = Solicitud.new(message: params[:message], status: 'sent', user: @usuario, actividad: @actividad)
  
    if @new_solicitud.save
      redirect_to actividad_index_path, notice: "Solicitud enviada! :)"
    else
      redirect_to root_path, alert: "Error, no se ha podido enviar la solicitud :("
    end
  end

  # Reacciona en función de si se acepta una solicitud o no
  # @param [int] id
  # @param [int] solicitud_id
  # @param [boolean] accepted
  def manejar_solicitud
    @actividad = Actividad.find(params[:id].to_i)
    @solicitud = @actividad.solicituds.find(params[:solicitud_id].to_i)

    if @actividad.memberships.exists?(user_id: @solicitud.user.id)
      @solicitud.destroy
      redirect_back fallback_location: root_path, :notice => "La persona ya está en la actividad"
    elsif params[:accepted] == "true"
      @actividad.users << @solicitud.user
      @solicitud.status = "accepted"
      @solicitud.destroy
      redirect_back fallback_location: root_path, :notice => "Solicitud aceptada :)"
    elsif params[:accepted] == "false"
      @solicitud.status = "rejected"
      @solicitud.destroy
      redirect_back fallback_location: root_path, :notice => "Solicitud rechazada :P"
    end
  end
end
