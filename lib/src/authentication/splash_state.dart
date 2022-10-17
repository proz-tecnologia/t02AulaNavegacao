abstract class SplashState {}

class SplashStateEmpty extends SplashState {}

class SplashStateAuthenticated extends SplashState {
  final String username;

  SplashStateAuthenticated(this.username);
}

class SplashStateUnauthenticated extends SplashState {}
