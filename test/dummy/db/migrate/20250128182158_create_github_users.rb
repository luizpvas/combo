class CreateGithubUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :github_users do |t|
      t.string :login, null: false
      t.string :avatar_url
      t.string :name
      t.string :company
      t.string :location
      t.string :email
      t.boolean :hireable
      t.string :bio
      t.string :twitter_username

      t.timestamps
    end
  end
end
