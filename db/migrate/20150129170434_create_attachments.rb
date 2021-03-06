class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.text :description
      t.string :file
      t.references :attachable, :polymorphic => true, index: true

      t.timestamps null: false
    end
  end
end
