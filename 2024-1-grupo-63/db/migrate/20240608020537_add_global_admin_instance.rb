class AddGlobalAdminInstance < ActiveRecord::Migration[7.1]
  def change
    user = User.new(email: 'taylorswift@grupo63.grupo63',
     password: "taylorbacan63", global_admin: true)
    user.save
  end
end
