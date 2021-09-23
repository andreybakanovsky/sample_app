class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) } # Чтобы гарантировать верную последовательность, включим аргумент order в default_scope
  # the “stabby lambda” syntax for an object called a
  # Proc (procedure) or lambda, which is an anonymous function (a function cre-
  # ated without a name)

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
