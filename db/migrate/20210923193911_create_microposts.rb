class CreateMicroposts < ActiveRecord::Migration[6.1]
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    # Так как мы собираемся получать все микросообщения, связанные с заданным
    # user_id, в порядке, обратном их созданию, добавим также индекс для
    # столбцов user_id и created_at
    add_index :microposts, %i[user_id created_at]
  end
end
