class ChangeOptionContentsToTitleObjects < ActiveRecord::Migration[5.1]
  def self.up

    bank = Bank.where(name:"Monivalintakysymyspankki").first

    Option.all.each do |option|
      if Title.where(text:option.content).empty?
        bank.titles.create(text:option.content)
      end

      option.title = Title.where(text:option.content).first
      option.save
    end

    remove_column :options, :content
  end

  def self.down
    Option.all.each { |o| o.update_attribute(:title_id, nil) }
  end
end
