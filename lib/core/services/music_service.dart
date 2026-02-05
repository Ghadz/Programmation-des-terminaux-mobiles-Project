import 'package:just_audio/just_audio.dart';

/// Service to manage background music playback
class MusicService {
  static final MusicService _instance = MusicService._internal();
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  double _volume = 0.3; // Default volume at 30%

  factory MusicService() {
    return _instance;
  }

  MusicService._internal() {
    _audioPlayer = AudioPlayer();
  }

  /// Get the audio player instance
  AudioPlayer get audioPlayer => _audioPlayer;

  /// Check if music is currently playing
  bool get isPlaying => _isPlaying;

  /// Get current volume (0.0 - 1.0)
  double get volume => _volume;

  /// Play background music from URL with loop
  ///
  /// [audioUrl] - The URL of the audio file (must be MP3 or supported format)
  /// [volume] - Volume level (0.0 - 1.0), default is 0.3
  Future<void> playBackgroundMusic({
    required String audioPath,
    double volume = 0.3,
  }) async {
    try {
      // Set volume first
      await _audioPlayer.setVolume(volume);
      _volume = volume;

      // Set loop mode to repeat continuously
      await _audioPlayer.setLoopMode(LoopMode.all);

      // Set the URL and start playing
      // await _audioPlayer.setUrl(audioUrl);
      await _audioPlayer.setAsset(audioPath);
      await _audioPlayer.play();
      _isPlaying = true;

      print('✅ Background music started playing');
    } catch (e) {
      print('❌ Error playing music: $e');
      _isPlaying = false;
    }
  }

  /// Pause the music
  Future<void> pauseMusic() async {
    try {
      await _audioPlayer.pause();
      _isPlaying = false;
      print('⏸️ Music paused');
    } catch (e) {
      print('❌ Error pausing music: $e');
    }
  }

  /// Resume playing music from where it was paused
  Future<void> resumeMusic() async {
    try {
      await _audioPlayer.play();
      _isPlaying = true;
      print('▶️ Music resumed');
    } catch (e) {
      print('❌ Error resuming music: $e');
    }
  }

  /// Stop music completely
  Future<void> stopMusic() async {
    try {
      await _audioPlayer.stop();
      _isPlaying = false;
      print('⏹️ Music stopped');
    } catch (e) {
      print('❌ Error stopping music: $e');
    }
  }

  /// Change volume level
  ///
  /// [volume] - Volume level (0.0 - 1.0)
  Future<void> setVolume(double volume) async {
    try {
      if (volume < 0.0 || volume > 1.0) {
        throw ArgumentError('Volume must be between 0.0 and 1.0');
      }
      await _audioPlayer.setVolume(volume);
      _volume = volume;
      print('🔊 Volume set to ${volume * 100}%');
    } catch (e) {
      print('❌ Error setting volume: $e');
    }
  }

  /// Increase volume by 10%
  Future<void> increaseVolume() async {
    double newVolume = (_volume + 0.1).clamp(0.0, 1.0);
    await setVolume(newVolume);
  }

  /// Decrease volume by 10%
  Future<void> decreaseVolume() async {
    double newVolume = (_volume - 0.1).clamp(0.0, 1.0);
    await setVolume(newVolume);
  }

  /// Get current playback position
  Duration? getCurrentPosition() {
    return _audioPlayer.position;
  }

  /// Get total duration of the audio
  Duration? getTotalDuration() {
    return _audioPlayer.duration;
  }

  /// Dispose and cleanup resources
  Future<void> dispose() async {
    try {
      await _audioPlayer.dispose();
      print('🗑️ Music service disposed');
    } catch (e) {
      print('❌ Error disposing music service: $e');
    }
  }
}