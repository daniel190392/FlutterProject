import 'package:continental_app/domain/models/user_model.dart';
import 'package:continental_app/logic/logic.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../mocks/mocks.dart';

void main() {
  late UserProfileCubit userProfileCubit;
  late GetUserUseCaseMock getUserUseCaseMock;
  late UpdateUserUseCaseMock updateUserUseCaseMock;
  late GetUserIdUseCaseMock getUserIdUseCaseMock;
  const userId = '000';
  const userModel = UserModel(
    userId: userId,
    name: 'name',
    latitude: 0,
    longitude: 0,
    address: 'address',
  );

  setUp(() {
    getUserUseCaseMock = GetUserUseCaseMock();
    updateUserUseCaseMock = UpdateUserUseCaseMock();
    getUserIdUseCaseMock = GetUserIdUseCaseMock();
    userProfileCubit = UserProfileCubit(
      getUserUseCaseMock,
      updateUserUseCaseMock,
      getUserIdUseCaseMock,
    );
  });

  test('The initial state for the UserProfileCubit', () {
    expect(userProfileCubit.state, UserProfileInitial());
  });

  group('Fetch user on UserProfile Cubit', () {
    blocTest(
      'Fetch success',
      setUp: () {
        getUserIdUseCaseMock.executeResult = userId;
        getUserUseCaseMock.executeResult = userModel;
      },
      build: () => userProfileCubit,
      act: (cubit) => cubit.emitFecthUser(true),
      expect: () => [
        UserProfileLoading(),
        UserProfileLoaded(userModel),
      ],
      verify: (_) {
        expect(getUserIdUseCaseMock.executeWasCalled, true);
        expect(getUserUseCaseMock.executeWasCalled, true);
      },
    );

    blocTest(
      'Fetch failed',
      build: () => userProfileCubit,
      act: (cubit) => cubit.emitFecthUser(true),
      expect: () => [
        UserProfileLoading(),
        UserProfileLError(),
      ],
      verify: (_) {
        expect(getUserIdUseCaseMock.executeWasCalled, true);
      },
    );
  });

  group('Edit user on UserProfile Cubit', () {
    blocTest(
      'Edit Avatar',
      setUp: () {
        userProfileCubit.emit(UserProfileLoaded(userModel));
      },
      build: () => userProfileCubit,
      act: (cubit) => cubit.emitEditAvatar('avatarImage'),
      expect: () => [
        UserProfileLoaded(userModel.copyWith(avatarImage: 'avatarImage')),
      ],
    );

    blocTest(
      'Edit user name',
      setUp: () {
        userProfileCubit.emit(UserProfileLoaded(userModel));
      },
      build: () => userProfileCubit,
      act: (cubit) => cubit.emitEditUserName('userName'),
      expect: () => [
        UserProfileLoaded(userModel.copyWith(name: 'userName')),
      ],
    );

    blocTest(
      'Edit user address',
      setUp: () {
        userProfileCubit.emit(UserProfileLoaded(userModel));
      },
      build: () => userProfileCubit,
      act: (cubit) => cubit.emitEditAdress('adress', 1, 1),
      expect: () => [
        UserProfileLoaded(userModel.copyWith(
          address: 'adress',
          latitude: 1,
          longitude: 1,
        )),
      ],
    );
  });

  group('Update user on UserProfile Cubit', () {
    blocTest(
      'Fetch success',
      setUp: () {
        getUserIdUseCaseMock.executeResult = userId;
        updateUserUseCaseMock.executeResult = true;
      },
      build: () => userProfileCubit,
      act: (cubit) => cubit.emitUpdateUser(userModel),
      expect: () => [
        UserProfileLoading(),
        UserProfileLoaded(userModel, wasUpdated: true),
      ],
      verify: (_) {
        expect(getUserIdUseCaseMock.executeWasCalled, true);
        expect(updateUserUseCaseMock.executeWasCalled, true);
      },
    );

    blocTest(
      'Fetch failed',
      setUp: () {
        getUserIdUseCaseMock.executeResult = userId;
      },
      build: () => userProfileCubit,
      act: (cubit) => cubit.emitUpdateUser(userModel),
      expect: () => [
        UserProfileLoading(),
        UserProfileLError(),
      ],
      verify: (_) {
        expect(getUserIdUseCaseMock.executeWasCalled, true);
        expect(updateUserUseCaseMock.executeWasCalled, true);
      },
    );
  });
}
