class PerfilController < ApplicationController
  # Remanente
  def perfil_usuario
  end
  # Remanente
  def modificar
  end

  
  # Muestra un perfil en función de su id
  # @param [int] id
  def ver_perfil
      if params[:id].to_i == current_user.id
        redirect_to perfil_path
      else
        @user_buscado = User.find(params[:id])
        @followers = @user_buscado.followers
      end
    
  end

  # El usuario en sesión manda una solicitud de seguimiento a otro usuario especificado por el id
  # @param [int] id
  def request_follow
    @user = User.find(params[:id])
    FollowRequest.create(follower: current_user, followed: @user, status: "pending")
    redirect_to ver_perfil_path(@user), notice: "Solicitud de seguimiento enviada."
  end

  # El usuario en sesión deja de seguir a otro usuario especificado por el id
  # @param [int] id
  def unfollow
    @user = User.find(params[:id])
    current_user.following_users.delete(@user)
    redirect_to ver_perfil_path(@user), notice: "Has dejado de seguir a este usuario."
  end

  # El usuario en sesión acepta una solicitud de seguimiento de otro usuario especificado por el id de la solicitud
  # @param [int] id
  def accept_follow
    @follow_request = FollowRequest.find(params[:id])
    
    # Verifica si la solicitud de seguimiento se encuentra y carga correctamente
    puts "Follow request found: #{@follow_request}"
    
    if @follow_request.followed == current_user && @follow_request.status == "pending"
      # Actualiza el estado de la solicitud de seguimiento a 'accepted'
      @follow_request.update(status: "accepted")
    
      # Agrega al usuario que envió la solicitud a la lista de seguidores del usuario actual
      current_user.followers << @follow_request.follower
      puts "Added follower: #{@follow_request.follower.email}"
    
      # Agrega al usuario actual a la lista de seguidos del usuario que envió la solicitud
      @follow_request.follower.following_users << current_user
      puts "Added current user to following list of follower"
    
      redirect_to perfil_path, notice: "Solicitud de seguimiento aceptada."
    else
      redirect_to perfil_path, alert: "No tienes permiso para aceptar esta solicitud."
    end
  end
  
  
  # El usuario en sesión rechaza una solicitud de seguimiento de otro usuario especificado por el id de la solicitud
  # @param [int] id
  def reject_follow
    @follow_request = FollowRequest.find(params[:id])
    if @follow_request.followed == current_user && @follow_request.status == "pending"
      @follow_request.update(status: "rejected")
      redirect_to perfil_path, notice: "Solicitud de seguimiento rechazada."
    else
      redirect_to perfil_path, alert: "No tienes permiso para rechazar esta solicitud."
    end
  end


  # Se visualizan los seguidores de un usuario al especificar su id
  # @param [int] id
  def followers_especifico
    user_buscado = User.find(params[:id])
    @followers = user_buscado.followers
  end

  # Se visualizan los followers del usuario en sesión
  def followers
    @followers = current_user.followers
  end

  # Se visualizan los seguidores de un usuario al especificar su id
  # @param [int] id
  def followers_de_otro
    @user_buscado = User.find(params[:id])
    @followers = @user_buscado.followers
  end

  # El usuario con admin global elimina una cuenta especificada según su id
  # @param [int] id
  def destroy
    @user = User.find(params[:id])
    if current_user.global_admin || @user == current_user
      @user.destroy
      redirect_to root_path, notice: 'Tu cuenta ha sido eliminada con éxito.'
    else
      redirect_to perfil_path, alert: 'No tienes permiso para eliminar esta cuenta.'
    end
  end
end

