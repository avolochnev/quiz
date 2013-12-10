class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :topic
      t.integer :cost
      t.text :q
      t.text :a
      t.boolean :answered

      t.timestamps
    end
  end
end
