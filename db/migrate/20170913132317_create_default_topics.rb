class CreateDefaultTopics < ActiveRecord::Migration[5.1]
  TOPICS = ['Football', 'Travel', 'Politics', 'Art', 'Dating', 'Music', 'Movies', 'Series', 'Food']
  def up
    TOPICS.each do |topic|
      Topic.create(title: topic)
    end
  end

  def down
    Topic.where(title: TOPICS).delete_all
  end
end
