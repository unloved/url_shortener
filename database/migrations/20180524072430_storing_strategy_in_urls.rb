class StoringStrategyInUrls < ActiveRecord::Migration[5.2]
  def change
    add_column :urls, :strategy, :string
    Url.update_all({strategy: 'SecureRandom'})
  end
end
