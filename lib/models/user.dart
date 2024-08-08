//定義User的屬性
class User {
  int totalTodos;
  int completeTodos;

  //User的建構子
  User({
    required this.totalTodos,
    required this.completeTodos,
  });

  //逐一建立出項目的json格式
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      totalTodos: json["totalTodos"],
      completeTodos: json["completeTodos"],
    );
  }

  //用Map迴圈，將todo清單中的資料，以json格式覆寫上去
  Map<String, dynamic> toJson() {
    return {"totalTodos": totalTodos, "completeTodos": completeTodos};
  }
}
