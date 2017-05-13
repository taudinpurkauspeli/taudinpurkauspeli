class ChangeQuestionTitlesToTitleObjects < ActiveRecord::Migration
  def self.up

    bank = Bank.where(name:"Yleispankki").first

    Question.all.each do |question|
      if Title.where(text:question.title_string).empty?
        bank.titles.create(text:question.title_string)
      end

      question.title = Title.where(text:question.title_string).first
      question.save
    end

    remove_column :questions, :title_string
  end

  def self.down
    Question.all.each { |q| q.update_attribute(:title_id, nil) }

    Title.destroy_all
  end

end
