import 'package:api_repository/api_repository.dart';
import 'package:just_audio/just_audio.dart';

class QueueAudioSource extends ConcatenatingAudioSource {
  QueueAudioSource({required List<Track> children}) : super(children: children);

  @Deprecated("Use addTrack(Track) instead")
  @override
  Future<void> add(AudioSource audioSource) {
    return super.add(audioSource);
  }

  Future<void> addTrack(Track track) {
    return super.add(track);
  }

  @Deprecated("Use addTracks(List<Track>) instead")
  @override
  Future<void> addAll(List<AudioSource> children) {
    return super.addAll(children);
  }

  Future<void> addTracks(List<Track> track) {
    return super.addAll(track);
  }

  @override
  Track operator [](int index) => this[index];

  List<Track> get tracks => children.cast<Track>();
}
