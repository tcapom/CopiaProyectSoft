class ApplicationController < ActionController::Base

  # Indica que sólo el usuario "taylorswift@grupo63.grupo63" es admin global
  def self.global_admin
    @global_admin = User.find_by(email: "taylorswift@grupo63.grupo63")
  end

end
