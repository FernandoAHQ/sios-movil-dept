
import 'package:flutter/cupertino.dart';
import 'package:sios_v1/models/report.dart';

class ProviderReports with ChangeNotifier {

   // late List<dynamic> reportsList;
    late List<Report> reports = [];

  String? sId;
  String? department;
  String? title;
  String? description;
  String? category;
  bool? isAssigned;
  DateTime? createdAt;

    readReports(List<dynamic> data){
      for(int i = 0; i < data.length; i++){
          reports.add(
            Report(
            sId: data[i]['_id'].toString(),
            department: data[i]['department'].toString(),
            title: data[i]['title'].toString(), 
            description: data[i]['description'].toString(), 
            category: data[i]['category'].toString(), 
            isAssigned: data[i]['isAssigned'],
            createdAt: DateTime.parse(data[i]['createdAt'])
            ));
                 notifyListeners();
      } 
     // reportsList = data;
    }

      void resetReports(){
        reports = [];
      }

      List<Report> getReports(){
      return reports.reversed.toList();
      
    }
}