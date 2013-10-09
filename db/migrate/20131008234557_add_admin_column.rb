class AddAdminColumn < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean
    User.all.each do |user| 
      if user.role == "admin"
        user.update(admin: true)
      else 
        user.update(admin: false)
      end
    end
    remove_column :users, :role
  end
end
