# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
TOPICS = ['Football', 'Travel', 'Politics', 'Art', 'Dating', 'Music', 'Movies', 'Series', 'Food']
Topic.create(TOPICS.map { |t| {title: t} })

