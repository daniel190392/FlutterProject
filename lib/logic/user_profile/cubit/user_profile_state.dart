part of 'user_profile_cubit.dart';

@immutable
sealed class UserProfileState extends Equatable {}

final class UserProfileInitial extends UserProfileState {
  @override
  List<Object?> get props => [];
}

final class UserProfileLoading extends UserProfileState {
  @override
  List<Object?> get props => [];
}

final class UserProfileLoaded extends UserProfileState {
  final UserModel user;
  final bool wasUpdated;
  UserProfileLoaded(this.user, {bool? wasUpdated})
      : wasUpdated = wasUpdated ?? false;

  @override
  List<Object?> get props => [user];
}

final class UserProfileLError extends UserProfileState {
  @override
  List<Object?> get props => [];
}
