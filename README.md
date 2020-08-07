# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



heroku pg:backups:capture
heroku pg:backups:download

heroku pg:backups:restore https://trello-attachments.s3.amazonaws.com/591c663440dbfb6eec3e842b/59f8b0b55ba395ee54d443e3/b3098ce418e1a97886b89651ad0f7955/latest.dump --confirm homolog-expert



heroku pg:promote green

heroku pg:backups:restore https://trello-attachments.s3.amazonaws.com/58ae528e80159300fa82bace/5bb3b5c9aac1dd5f69a9b452/4db48d5f2f904e6cd4be71caf3e26347/f549584e-81dd-4503-92ee-fe605a271fb5 --confirm admin-personalnapratica