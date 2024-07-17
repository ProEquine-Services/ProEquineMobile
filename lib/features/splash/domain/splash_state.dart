part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}
class RefreshSuccessfully extends SplashState {
  final String? message;
  RefreshSuccessfully({this.message});
}
class RefreshError extends SplashState {
  final String? message;
  RefreshError({this.message});
}

class GetEnvSuccessfully extends SplashState {
  final EnvResponseModel? responseModel;
  GetEnvSuccessfully({this.responseModel});
}
class GetEnvError extends SplashState {
  final String? message;
  GetEnvError({this.message});
}


// class VersionSuccessful extends SplashState{
//   final VersionResponseModel versionModel;
//   VersionSuccessful({required this.versionModel});
// }
// class VersionError extends SplashState{
//   final String message;
//   VersionError({required this.message});
// }