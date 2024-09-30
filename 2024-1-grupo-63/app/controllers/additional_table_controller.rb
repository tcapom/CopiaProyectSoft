class AdditionalTableController < ApplicationController

    # Remanente
    def agregar_info
    end


    # Modifica la información indicada en los parámetros
    # @param [string] phone
    # @param [string] username
    # @param [string] pronouns
    # @param [string] biografia
    # @param [picture] picture
    def modificar_info
        puts params.inspect
        user = current_user
        additional_table = AdditionalTable.find_by(user_id: current_user.id)

        if additional_table
        # Si ya existe un registro en AdditionalTable para este usuario, actualiza los valores
        additional_table.update(
            phone: params[:phone].presence || additional_table.phone,
            username: params[:username].presence || additional_table.username,
            pronouns: params[:pronouns].presence || additional_table.pronouns,
            biografia: params[:biografia].presence || additional_table.biografia,
           
        )

        if params[:picture]
          additional_table.picture.attach(params[:picture])
        end

            if additional_table.errors.empty?
                puts 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
                redirect_to '/perfil'
            else
                puts 'Error al guardar el registro:'
                puts additional_table.errors.full_messages.inspect
            end
        end
            
    end

  # Busca la id de un usuario según su email
  # @param [string] email
  def search
    user_buscado = User.find_by(email: params[:email])
    if user_buscado
        puts user_buscado.id
      redirect_to ver_perfil_path(user_buscado.id)
    else
      flash[:error] = "Usuario no encontrado"
      redirect_to root_path
    end
  end

end
  