class TodoModel {
  final String name;
  final DateTime createdAt;

  TodoModel({required this.name, required this.createdAt});

  @override
  String toString() => "Todo(name: $name, createdAt: $createdAt)";
}
