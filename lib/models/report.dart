class Report {
  String? sId;
  String? department;
  String? title;
  String? description;
  String? category;
  bool? isAssigned;
  String? createdAt;

  Report(
      {this.sId,
      this.department,
      this.title,
      this.description,
      this.category,
      this.isAssigned,
      this.createdAt}){
        print(createdAt);
      }

  Report.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    department = json['department'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    isAssigned = json['isAssigned'];
    //print(DateTime.parse('1969-07-20 20:18:04Z').toString());
    //createdAt = "xddd";
    print(createdAt);
    //createdAt = DateTime.parse('1969-07-20 20:18:04Z');//DateTime.parse(json['createdAt']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['department'] = this.department;
    data['title'] = this.title;
    data['description'] = this.description;
    data['category'] = this.category;
    data['isAssigned'] = this.isAssigned;
    data['createdAt'] = this.createdAt;
    return data;
  }
}