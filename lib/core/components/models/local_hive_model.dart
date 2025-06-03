

class LocalHiveModel{
  final bool? isAppInstalled;

   LocalHiveModel({this.isAppInstalled});

  factory LocalHiveModel.fromJson(Map<String,dynamic> json){
    return LocalHiveModel(
       isAppInstalled: json["isAppInstalled"] ?? false
    );
  }

}