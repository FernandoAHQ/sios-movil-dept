import 'package:sios_v1/models/report.dart';

class Service {
  String sId;
  String status;
  String createdAt;
  String updatedAt;
  Report report;
//  AsignedTo asignedTo;

  Service(
      {required this.sId,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.report,
  //     this.asignedTo
  });

  Report getReport(){
    print(report.toString());
    return report;
  }
 
}

 



class AsignedTo {
  String id;
  String name;

  AsignedTo({required this.id, required this.name});

  
}