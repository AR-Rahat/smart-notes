import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_notes/core/logger/log.dart';
import 'package:smart_notes/data/services/ai_processing/data_sources/note_local_data_source.dart';
import 'package:smart_notes/data/services/ai_processing/dtos/ai_processed_response.dart';
import 'package:smart_notes/data/services/ai_processing/remapper/ai_processing_remapper.dart';
import 'package:smart_notes/domain/entities/notes/note_entity.dart';
import 'package:smart_notes/domain/services/ai_processing/note_processing_service.dart';

@LazySingleton(as: NoteProcessingService)
class NoteProcessingServiceImpl implements NoteProcessingService {
  NoteProcessingServiceImpl(this._remapper, this._localDataSource);

  final AiProcessingRemapper _remapper;
  final NoteLocalDataSource _localDataSource;

  @override
  Future<NoteEntity> processWithAi({required PlatformFile file}) async {
    await Future.delayed(const Duration(seconds: 3));

    final response = AiProcessedResponse.fromJson(mockResponse);
    final resultEntity = _remapper.fromResponse(response: response, title: file.name);

    List<NoteEntity> notes = fetchAllNotes();
    notes.add(resultEntity);

    Log.info("Current Note length -> ${notes.length}");

    await saveAllNotes(notes: notes);

    return resultEntity;
  }

  @override
  Future<void> saveAllNotes({required List<NoteEntity> notes}) async {
    // Map<String, dynamic> -> each note keyed by title
    final Map<String, dynamic> jsonMap = {
      for (final note in notes) note.noteTitle: note.toJson(),
    };

    // Save as JSON string
    final String jsonString = jsonEncode(jsonMap);
    await _localDataSource.saveLocalNotes(notes: jsonString);
  }

  @override
  List<NoteEntity> fetchAllNotes() {
    final String? rawJson = _localDataSource.fetchLocalNotes();
    if (rawJson == null) return [];

    try {
      final Map<String, dynamic> decoded = jsonDecode(rawJson);
      return decoded.entries.map((entry) {
        final Map<String, dynamic> noteJson = Map<String, dynamic>.from(entry.value);
        return NoteEntity.fromJson(noteJson);
      }).toList();
    } catch (e) {
      Log.error("Failed to parse notes: $e");
      return [];
    }
  }
}


const mockResponse = {
  "metadata": {
    "language": null,
    "content": null,
    "topics": null,
    "duration": 146.94,
  },
  "segments": [
    {
      "start_time": 0,
      "end_time": 24.88,
      "content":
      " After reading tons of productivity books, I came across so many rules..."
    },
    {
      "start_time": 24.88,
      "end_time": 45.5,
      "content":
      " getting things done by David Allen. He says if it takes two minutes..."
    },
    {
      "start_time": 45.5,
      "end_time": 67.86,
      "content":
      " So here's a list of things that might take two minutes..."
    },
    {
      "start_time": 67.86,
      "end_time": 91.27,
      "content":
      " task down to two minutes or less. So doing your entire reading..."
    },
    {
      "start_time": 91.27,
      "end_time": 117.33,
      "content":
      " So back in med school, I wanted to build a habit of studying..."
    },
    {
      "start_time": 117.33,
      "end_time": 137.99,
      "content":
      " I was mastering the habit of just showing up because a habit..."
    },
    {
      "start_time": 138.15,
      "end_time": 146.94,
      "content":
      " I cover more here in this video on three books and three minutes..."
    },
  ],
};

