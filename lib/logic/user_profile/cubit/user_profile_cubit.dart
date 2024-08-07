import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/models/user_model.dart';
import '../../../domain/usecase/usecase.dart';
import '../../../resources/resources.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  GetUserUseCase getUserUseCase;
  UpdateUserUseCase updateUserUseCase;
  GetUserIdUseCase getUserIdUseCase;

  UserProfileCubit(
    this.getUserUseCase,
    this.updateUserUseCase,
    this.getUserIdUseCase,
  ) : super(UserProfileInitial());

  void emitFecthUser(bool availableConnection) async {
    try {
      emit(UserProfileLoading());
      final userId = await getUserIdUseCase.execute();
      final result = await getUserUseCase.execute(userId, availableConnection);
      emit(UserProfileLoaded(result));
    } catch (error) {
      emit(UserProfileLError());
    }
  }

  void emitEditAvatar(String avatarImage) async {
    if (state is UserProfileLoaded) {
      final user = (state as UserProfileLoaded).user;
      emit(
        UserProfileLoaded(user.copyWith(avatarImage: avatarImage)),
      );
    } else {
      emit(UserProfileLError());
    }
  }

  void emitEditUserName(String userName) async {
    if (state is UserProfileLoaded) {
      final user = (state as UserProfileLoaded).user;
      emit(
        UserProfileLoaded(user.copyWith(name: userName)),
      );
    }
  }

  void emitEditAdress(String adress, double latitude, double longitude) async {
    if (state is UserProfileLoaded) {
      final user = (state as UserProfileLoaded).user;
      emit(
        UserProfileLoaded(user.copyWith(
          address: adress,
          latitude: latitude,
          longitude: longitude,
        )),
      );
    }
  }

  void emitUpdateUser(UserModel user) async {
    try {
      emit(UserProfileLoading());
      final userId = await getUserIdUseCase.execute();
      await updateUserUseCase.execute(userId, user);
      emit(UserProfileLoaded(user.copyWith(), wasUpdated: true));
    } catch (_) {
      emit(UserProfileLError());
    }
  }
}
