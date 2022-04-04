
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart';
import 'package:sios_v1/models/report.dart';
import 'package:sios_v1/models/service.dart';

import '../services/httpService.dart';

class ProviderServices with ChangeNotifier {

   // late List<dynamic> reportsList;
  List<Service> history = [];
  List<Service> services = [];
  List<String> categories = [];

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
  
      Future loadHistory(String id) async {
    final Response response;
    
      response = await HTTPService().getHistory(id);
      print('GET HISTORY: ' + response.statusCode.toString());

    //  print(response.statusCode);
  if (response.statusCode == 200) {
        final Map data = jsonDecode(response.body);
        
         print("FETCHING DATA");

       for(int i = 0; i < data['services'].length; i++){
           Service newService = Service(
          sId:       (data['services'][i]['_id']).toString(),
          createdAt: (data['services'][i]['createdAt']).toString(),
          updatedAt: (data['services'][i]['updatedAt']).toString(),
          status:    (data['services'][i]['status']).toString(),
          report: Report(
            sId:          (data['services'][i]['report']['_id']).toString(),
            department:   (data['services'][i]['report']['department']).toString(),
            title:        (data['services'][i]['report']['title']).toString(), 
            description:  (data['services'][i]['report']['description']).toString(), 
            category:     (data['services'][i]['report']['category']).toString(), 
            isAssigned:   (data['services'][i]['report']['isAssigned']),
            createdAt:    (data['services'][i]['report']['createdAt']).toString()
            )
        );
        history.add(newService);
       }
//        categories = parsedData['categories'];

         notifyListeners();
        }else{
          print("HISTORY NOT RECIEVED");
        }
      }
  
 


      void resetServices(){
        services = [];
      }

      List<String> getCategories(){
        return categories;
      }

      List<dynamic> getHistory(){
        return history.reversed.toList();
      }

      List<dynamic> getServices(){
      return services.reversed.toList();
      
    }
}
