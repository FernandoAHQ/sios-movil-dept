import 'package:sios_v1/models/report.dart';

class Service {
  String sId;
  String status;
  String createdAt;
  String updatedAt;
  Report report;
  AsignedTo? asignedTo;

  Service({
    required this.sId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.report,
    required this.asignedTo
  });

  Report getReport() {
    return report;
  }
}

class AsignedTo {
  String? name;
  String? imgUrl;

  AsignedTo({required this.name, required this.imgUrl});
}
