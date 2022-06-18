import 'package:api_repository/api_repository.dart';
import 'package:just_audio/just_audio.dart';

class QueueAudioSource extends ConcatenatingAudioSource {
  QueueAudioSource({
    required List<Track> children,
    required this.apiRepo,
  }) : super(children: children);

  final ApiRepository apiRepo;

  @Deprecated("Use addTrack(Track) or addTrackId(String) instead")
  @override
  Future<void> add(AudioSource audioSource) {
    return super.add(audioSource);
  }

  Future<void> addTrack(Track track) async {
    return super.add(track);
  }

  Future<void> addTrackId(String trackId) async {
    return super.add(await apiRepo.getTrack(trackId));
  }

  @Deprecated("Use addTracks(List<Track>) or addTrackIds(List<String>) instead")
  @override
  Future<void> addAll(List<AudioSource> children) {
    return super.addAll(children);
  }

  Future<void> addTracks(List<Track> tracks) async {
    return super.addAll(tracks);
  }

  Future<void> addTrackIds(List<String> trackIds) async {
    return super.addAll(await Future.wait<Track>(trackIds.map(apiRepo.getTrack)));
  }

  @override
  Track operator [](int index) => this[index];

  List<Track> get tracks => children.cast<Track>();
}
