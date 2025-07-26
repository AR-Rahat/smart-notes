import 'dart:io';

abstract class AudioRecorder {
  Future<void> init();
  Future<void> start(String path);
  Future<void> pause();
  Future<void> resume();
  Future<void> stop();
  Future<void> dispose();
  Future<Directory> getTempDirectory();
}