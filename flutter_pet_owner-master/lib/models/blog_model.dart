// ignore_for_file: public_member_api_docs, sort_constructors_first
class BlogModel {
  String? content;
  String? title;
  BlogModel({
    this.content,
    this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'title': title,
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      content: map['content'] != null ? map['content'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
    );
  }
}
