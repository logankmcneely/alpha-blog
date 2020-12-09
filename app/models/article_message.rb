class ArticleMessage < ApplicationRecord
  belongs_to :article
  belongs_to :user

  # <ArticleMessage> uses ActionText wtih rich text to store the message body
  has_rich_text :body
end
