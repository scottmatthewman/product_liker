class Like < ApplicationRecord
  validates :article_id, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def self.count_for(article_id)
    where(article_id:).size
  end
end
