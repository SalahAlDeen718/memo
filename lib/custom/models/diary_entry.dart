class DiaryEntry {
  final String id;
  final String content;
  final String date;
  final String time;

  DiaryEntry({
    required this.id,
    required this.content,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'date': date,
    'time': time,
  };

  factory DiaryEntry.fromJson(Map<String, dynamic> json) => DiaryEntry(
    id: json['id'],
    content: json['content'],
    date: json['date'],
    time: json['time'],
  );
}