class NotesModel {
  int? id;
  String? title;
  String? content;
  

  NotesModel({this.title, this.content,this.id});

  NotesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] =title;
    data['content'] = content;
   if(id != null){
    data['id'] = id;
   }
    return data;
  }
}
