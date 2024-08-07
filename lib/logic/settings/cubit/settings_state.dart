part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool isAvailableConnection;

  const SettingsState({bool? isAvailableConnection})
      : isAvailableConnection = isAvailableConnection ?? true;

  @override
  List<Object?> get props => [isAvailableConnection];
}
