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

  List<NoteEntity> storedAllNotes = [];

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

      storedAllNotes = allNotes;

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

  Future<void> filterNotes({String? query}) async {
    if(state.noteStatus.isLoading) return;

    emit(state.copyWith(noteStatus: const BaseStatus.loading()));

    if(query == null || query.isEmpty){
      return emit(state.copyWith(allNotes: storedAllNotes, noteStatus: const BaseStatus.success()));
    }
    final allNote =  storedAllNotes;
    List<NoteEntity> filteredNote = [];
    for(NoteEntity note in allNote){
      if(note.noteTitle.toLowerCase().contains(query.toLowerCase()) || note.segments.any((seg) => seg.content.toLowerCase().contains(query.toLowerCase()))){
        filteredNote.add(note);
      }
    }
    return emit(state.copyWith(allNotes: filteredNote, noteStatus: const BaseStatus.success()));
  }
}
