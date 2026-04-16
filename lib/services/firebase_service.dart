import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moodoo/models/mood.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Mood>> getMoodsForMonth(int month, int year) {
    final uid = _auth.currentUser!.uid;
    return _firestore
        .collection("moods")
        .where("userId", isEqualTo: uid)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Mood.fromMap(doc.id, doc.data()))
              .where((mood) {
                final d = mood.day.toDate();
                return d.year == year && d.month == month;
              })
              .toList(),
        );
  }

  Stream<List<Mood>> getMoods() {
    final uid = _auth.currentUser!.uid;
    return _firestore
        .collection("moods")
        .where("userId", isEqualTo: uid)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Mood.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  Future<void> addMood(String receiverID, day, score, notes) async {
    final String currentUserID = _auth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    Mood newMood = Mood(
      id: '',
      userId: currentUserID,
      day: day,
      createdAt: timestamp,
      notes: notes,
      score: score,
    );

    await _firestore.collection("moods").add(newMood.toMap());
  }

  Future<void> updateMood(String moodId, String notes, String score) async {
    await _firestore.collection("moods").doc(moodId).update({
      "notes": notes,
      "score": score,
    });
  }

  Future<void> deleteMood(String moodId) async {
    await _firestore.collection("moods").doc(moodId).delete();
  }
}
