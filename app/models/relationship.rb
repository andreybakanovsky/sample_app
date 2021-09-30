class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User' # для читателей
  belongs_to :followed, class_name: 'User' # для читаемых
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
