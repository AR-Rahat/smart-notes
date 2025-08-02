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
    final resultEntity = _remapper.fromResponse(
      response: response,
      title: file.name,
      path: file.path,
    );

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
        final Map<String, dynamic> noteJson = Map<String, dynamic>.from(
          entry.value,
        );
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
          " After reading tons of productivity books, I came across so many rules, like the two-year rule, the five-minute rule, the five-second rule. No, not that five second rule. The problem is that these rules were meant for companies or entrepreneurs, but I was able to adapt them to my studies during med school and drastically cut down to my procrastination. So I'm going to share with you two different two minute rules for the next two minutes. The first two minute rule comes from",
    },
    {
      "start_time": 24.88,
      "end_time": 45.5,
      "content":
          " getting things done by David Allen. He says if it takes two minutes to do, get it done right now. For example, if I need to take out the trash today, it takes two minutes to do. So if I'm thinking about it now, might as well just do it now. Instead of writing it down on a to-do list or probably forgetting about it or having to come back to it later, which takes more than two minutes. That's how I see it.",
    },
    {
      "start_time": 45.5,
      "end_time": 67.86,
      "content":
          " So here's a list of things that might take two minutes throughout the day, like organizing your desk or watering your plants or clipping those nasty nails. I just do it when I notice it, but these little things start to add up, so this rule biases my brain towards taking action and away from procrastination. The second two-minute rule comes from atomic habits by James Clear. He says, when you're trying to do something you don't really want to do, simplify the",
    },
    {
      "start_time": 67.86,
      "end_time": 91.27,
      "content":
          " task down to two minutes or less. So doing your entire reading assignment becomes just reading one paragraph or memorizing the entire periodic table becomes memorizing just 10 flashcards. Now, some of you might think, yeah, this is just a Jedi mind trick. Like, why would I fall for it? How is this at all sustainable? And to that, he says, when you're starting out, limit yourself to only two minutes.",
    },
    {
      "start_time": 91.27,
      "end_time": 117.33,
      "content":
          " So back in med school, I wanted to build a habit of studying for one hour every day before dinner. So I tried this trick, but I limited myself to just two minutes. I'd sit down, open my laptop, study for two minutes, and then close my laptop and went to do something else. It seems unproductive at first, right? It seems stupid. But staying consistent with this two-minute routine day after day meant that I was becoming the type of person who studies daily.",
    },
    {
      "start_time": 117.33,
      "end_time": 137.99,
      "content":
          " I was mastering the habit of just showing up because a habit needs to be established before it can be expanded upon. If I can't become a person who studies for just two minutes a day, I'd never be able to become the person that studies for an hour a day. You've got to start somewhere, but starting small is easier. There's a lot of other useful tips from books.",
    },
    {
      "start_time": 138.15,
      "end_time": 146.94,
      "content":
          " I cover more here in this video on three books and three minutes. Check it out. And if you guys like these types of videos, let me know in the comments below. I'll see you there. Bye.",
    },
  ],
};
