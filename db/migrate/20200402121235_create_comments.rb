class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :comment_id
      t.string :commented_by
      t.text :commented_text

      t.timestamps
    end
  end
end
