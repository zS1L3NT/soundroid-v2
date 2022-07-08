import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listen_repository/src/models/models.dart';

/// The Listen Repository contains all Firebase calls regarding user listening data.
class ListenRepository {
  final _authenticationRepo = AuthenticationRepository();
  final _collection = FirebaseFirestore.instance.collection("listens").withConverter<Listen>(
        fromFirestore: (snap, _) => Listen.fromJson(snap.data()!),
        toFirestore: (listen, _) => listen.toJson(),
      );

  /// Record a track listen
  ///
  /// This will record that you have listened to a specific [trackId].
  ///
  /// If a record exists for today, append the [trackId] to the array
  /// If not, create a new record for today with the [trackId] as the only element in the array.
  Future<void> addRecord(String trackId) async {
    final timestamp = Timestamp.fromDate(
      DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
    );

    final snaps = await _collection
        .where("userRef", isEqualTo: _authenticationRepo.currentUserRef)
        .where("timestamp", isEqualTo: timestamp)
        .limit(1)
        .get();

    if (snaps.docs.length == 1) {
      await snaps.docs.first.reference.update({
        "trackIds": snaps.docs.first.data().trackIds + [trackId],
      });
    } else {
      await _collection.add(
        Listen(
          userRef: _authenticationRepo.currentUserRef,
          trackIds: [trackId],
          timestamp: timestamp,
        ),
      );
    }
  }

  Future<bool> deleteAll() async {
    try {
      final listens = await _collection
          .where(
            "userRef",
            isEqualTo: _authenticationRepo.currentUserRef,
          )
          .get();
      final batch = FirebaseFirestore.instance.batch();
      for (final listen in listens.docs) {
        batch.delete(listen.reference);
      }
      await batch.commit();
      return true;
    } catch (e) {
      debugPrint("ERROR Delete all listens: $e");
      return false;
    }
  }
}
