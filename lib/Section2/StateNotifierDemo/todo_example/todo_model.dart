class TodoModel{
  final int id;
  final String title;
  final bool completed;

  TodoModel({
    required this.id,
    required this.title,
    required this.completed
  });

  TodoModel copyWith({int? id,String? title , bool? completed}){
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed
    );
  }
}