# Flutter Minesweeper

Minesweeper built using Flutter Web, ready to run on a web browser. The app can also be built for Android/iOS, and Mac/Windows/Linux. 

Features include:
* A responsive layout for desktop and mobile
* Beginner, intermediate, expert, and custom difficulties
* Material Design with Light and Dark modes
* High scores saved during the current session

Deployed on Heroku using an NGINX server + Docker.

Live demo: https://flutter-mines.herokuapp.com/

## Disclaimer

Straight from Google:

> Warning: As of 1.9, web support is available as a tech preview. As web support hasn’t yet reached alpha, you can expect to experience crashes and missing features.

It seems to be working fairly well though, minus some bugs in the dartlang compiler that I encountered and other build issues.

## Architecture

The state management solution used in this app is Provider + ChangeNotifier. [This solution is suggested as the pragmatic state management solution by Google.](https://www.youtube.com/watch?v=d_m5csmrf7I) It's an easy and lightweight way to rebuild widgets only when state changes and have your UI respond to state changes reactively.

## Deployment

There's not much documentation on how to deploy a webapp built with Flutter since the web framework is still pre-alpha.

When you generate a Flutter web release build, you end up with a static site under `build/web`. The easiest way for me to deploy to Heroku was to create a Docker container which copies the static web files over and starts an NGINX server.

See the [Dockerfile](https://github.com/shaynekellyii/flutter_minesweeper/blob/master/Dockerfile) and the [basic build script](https://github.com/shaynekellyii/flutter_minesweeper/blob/master/push_to_heroku.sh) for more details.

## Tests

The project includes basic widget tests and unit tests.
