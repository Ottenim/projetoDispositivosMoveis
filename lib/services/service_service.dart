import 'package:barber/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String SERVICES_COLLECTION = "services";

class ServiceService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference<Service> _serviceCollection;

  ServiceService() {
    _serviceCollection = _firestore.collection(SERVICES_COLLECTION).withConverter<Service>(
          fromFirestore: (snapshot, options) => Service.fromMap(snapshot.id, snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toMap(),
        );
  }

  //CREATE
  Future<String> add(Service service) async {
    return (await _serviceCollection.add(service)).id;
  }

  //READ
  Future<List<Service>> getServices() async {
    final serviceStream = await _serviceCollection.orderBy('name', descending: false).get();

    List<Service> services = [];

    for (var element in serviceStream.docs) {
      services.add(element.data());
    }

    return services;
  }

  //UPDATE
  Future<void> update(String id, Service service) async => await _serviceCollection.doc(id).update(service.toMap());

  //DELETE
  Future<void> delete(String id) async => await _serviceCollection.doc(id).delete();
}
