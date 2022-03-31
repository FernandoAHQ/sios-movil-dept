
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:sios_v1/models/report.dart';
import 'package:sios_v1/models/service.dart';

import '../services/httpService.dart';

class ProviderServices with ChangeNotifier {

   // late List<dynamic> reportsList;
    late List<Service> services = [];
    late List<String> categories = [];

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
          updatedAt: (data[i]['updatedAt']).toString(),
          status:    (data[i]['status']).toString(),
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

    Future loadCategories() async {
    final Response response;
    
      response = await HTTPService().getCategories();
      print('GET CATEGORIES: ' + response.statusCode.toString());

    //  print(response.statusCode);
  if (response.statusCode == 201) {
        final Map parsedData = jsonDecode(response.body);
        for(int i = 0; i < parsedData['categories'].length; i++){
          categories.add(parsedData['categories'][i]);
        }
//        categories = parsedData['categories'];

        //  notifyListeners();
        }else{
        categories = [];
        }
      }
  
 


      void resetServices(){
        services = [];
      }

      List<String> getCategories(){
        return categories;
      }

      List<dynamic> getServices(){
      return services.reversed.toList();
      
    }
}
