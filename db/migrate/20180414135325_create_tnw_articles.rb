class CreateTnwArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :tnw_articles do |t|
      t.string :site
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
