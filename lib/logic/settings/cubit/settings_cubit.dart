import 'package:bloc/bloc.dart';

import '../../../resources/resources.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void emitChange(bool isAvailableConnection) {
    emit(SettingsState(isAvailableConnection: isAvailableConnection));
  }
}
