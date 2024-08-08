class Todo {
  bool isComplete; //判斷todo項目完成與否
  String content; //任務內容的文本
  DateTime creationTime; //todo項目的新增時間
  DateTime? finishTime; //todo項目的完成時間，允許 null

  //Todo的建構子
  //每創建一個新的Todo物件，就須提供這四個屬性值
  //從而保證新物件的這四個屬性在創建時都可進行初始化
  Todo({
    required this.isComplete,
    required this.content,
    required this.creationTime,
    this.finishTime,
  });

  //將todo清單中的資料(使用建構子的語法糖factory)逐一建立個別的json格式
  //逐一建立出項目的json格式
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      isComplete: json["isComplete"],
      content: json["content"],
      creationTime: DateTime.parse(json["creationTime"]),
      finishTime: json["finishTime"] != null
          ? DateTime.parse(json['finishTime'])
          : null,
    );
  }

  //用Map迴圈，將todo清單中的資料，以json格式覆寫上去
  Map<String, dynamic> toJson() {
    return {
      'isComplete': isComplete,
      'content': content,
      'creationTime': creationTime.toIso8601String(),
      'finishTime': finishTime?.toIso8601String(),
    };
  }
}
