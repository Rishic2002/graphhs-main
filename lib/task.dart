
class Task {
  final int taskVal;
  final String taskDetails;
  final String colorVal;
  Task(this.taskDetails,this.taskVal,this.colorVal);

  Task.fromMap(Map<String, dynamic> map)
      : 
        taskDetails = map['taskdetails'],
        taskVal = map['taskVal'],
        colorVal=map['colorVal'];

  @override
  String toString() => "Record<$taskVal:$taskDetails>";
}
