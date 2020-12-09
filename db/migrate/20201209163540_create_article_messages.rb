class CreateArticleMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :article_messages do |t|
      t.integer :article_id
      t.integer :user_id
      t.timestamps
    end
  end
end
