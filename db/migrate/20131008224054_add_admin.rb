class AddAdmin < ActiveRecord::Migration
  def change
    User.all.each { |user| user.update(role: "registered") }
    User.create(email: "admin@example.com", password: "foobar11", password_confirmation: "foobar11")
  end
end
