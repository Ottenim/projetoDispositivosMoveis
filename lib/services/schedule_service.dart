import 'package:barber/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String SCHEDULES_COLLECTION = "schedules";

class ScheduleService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference<Scheduling> _scheduleCollection;

  ScheduleService() {
    _scheduleCollection = _firestore.collection(SCHEDULES_COLLECTION).withConverter<Scheduling>(
          fromFirestore: (snapshot, options) => Scheduling.fromMap(snapshot.id, snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toMap(),
        );
  }

  //CREATE
  Future<String> addSchedule(Scheduling schedule) async {
    return (await _scheduleCollection.add(schedule)).id;
  }

  //READ
  Future<Scheduling?> getScheduleById(String id) async {
    final scheduleStream = await _scheduleCollection.where('id', isEqualTo: id).get();

    Scheduling? schedule;

    if (scheduleStream.docs.isNotEmpty) {
      schedule = scheduleStream.docs.first.data();
    }

    return schedule;
  }

  Future<List<Scheduling>> getSchedulesByClientId(String clientId) async {
    final scheduleStream = await _scheduleCollection.where('clientId', isEqualTo: clientId).get();

    List<Scheduling> schedules = [];

    for (var element in scheduleStream.docs) {
      schedules.add(element.data());
    }

    return schedules;
  }

  //UPDATE
  Future<void> updateSchedule(int id, Scheduling schedule) async => await _scheduleCollection.doc('$id').update(schedule.toMap());

  //DELETE
  Future<void> deleteSchedule(int id) async => await _scheduleCollection.doc('$id').delete();
}
