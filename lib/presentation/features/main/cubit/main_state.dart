part of 'main_cubit.dart';

@freezed
sealed class MainState with _$MainState {
  const factory MainState({
    @Default(BaseStatus.initial()) BaseStatus noteStatus,
    @Default([]) List<NoteEntity> allNotes,
  }) = _MainState;
}
