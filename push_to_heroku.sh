flutter pub get
flutter build web

heroku container:push web
heroku container:release web
