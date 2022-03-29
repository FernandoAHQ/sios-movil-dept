
import 'package:flutter/cupertino.dart';
import 'package:sios_v1/models/report.dart';
import 'package:sios_v1/models/service.dart';

class ProviderServices with ChangeNotifier {

   // late List<dynamic> reportsList;
    late List<Service> services = [];

  String? sId;
  String? department;
  String? title;
  String? description;
  String? category;
  bool? isAssigned;
  DateTime? createdAt;

    readServices(List<dynamic> data){
      services = [];
      for(int i = 0; i < data.length; i++){
        Service newService = Service(
          sId:       (data[i]['_id']).toString(),
          createdAt: (data[i]['createdAt']).toString(),
          updatedAt: (data[i]['createdAt']).toString(),
          status:    (data[i]['createdAt']).toString(),
          report: Report(
            sId:          (data[i]['report']['_id']).toString(),
            department:   (data[i]['report']['department']).toString(),
            title:        (data[i]['report']['title']).toString(), 
            description:  (data[i]['report']['description']).toString(), 
            category:     (data[i]['report']['category']).toString(), 
            isAssigned:   (data[i]['report']['isAssigned']),
            createdAt:    (data[i]['report']['createdAt']).toString()
            )
        );

        services.add(newService);
          
                 notifyListeners();
      } 
     // reportsList = data;
    }

      void resetServices(){
        services = [];
      }

      List<dynamic> getServices(){
      return services.reversed.toList();
      
    }
}
