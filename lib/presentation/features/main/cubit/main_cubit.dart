import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_notes/core/base/base_status/base_status.dart';
import 'package:smart_notes/core/logger/log.dart';
import 'package:smart_notes/core/response_error/response_error.dart';
import 'package:smart_notes/domain/entities/notes/note_entity.dart';
import 'package:smart_notes/domain/use_cases/notes/fetch_all_note_use_case.dart';

part 'main_cubit.freezed.dart';
part 'main_state.dart';

@injectable
class MainCubit extends Cubit<MainState> {
  MainCubit(this._fetchAllNoteUseCase) : super(const MainState());

  final FetchAllNoteUseCase _fetchAllNoteUseCase;

  Future<void> fetchAllSavedNotes() async {
    if (state.noteStatus.isLoading) {
      return;
    }

    emit(state.copyWith(noteStatus: const BaseStatus.loading()));

    try {
      final allNotes = await _fetchAllNoteUseCase.run();

      if (isClosed) {
        return;
      }

      emit(
        state.copyWith(
          noteStatus: const BaseStatus.success(),
          allNotes: allNotes,
        ),
      );

    } catch (e, s) {
      Log.error('Catch error $e\n stacktrace -> $s');

      final error = ResponseError.from(e);

      if (isClosed) {
        return;
      }

      return emit(state.copyWith(noteStatus: BaseStatus.failure(error)));
    }
  }
}
