import 'dart:convert';

BlogModel blogModelFromJson(String str) => BlogModel.fromJson(json.decode(str));
String blogModelToJson(BlogModel data) => json.encode(data.toJson());

class BlogModel {
  int? blogId;
  String? title;
  String? subtitle;
  String? content;
  String? authorName;
  String? authorImage;
  String? authorSpecialization;
  String? publishedDate;
  String? readTime;
  String? image;
  String? category;
  int? likes;
  int? comments;
  int? bookmarks;
  bool? isLiked;
  bool? isBookmarked;
  List<String>? tags;

  BlogModel({
    this.blogId,
    this.title,
    this.subtitle,
    this.content,
    this.authorName,
    this.authorImage,
    this.authorSpecialization,
    this.publishedDate,
    this.readTime,
    this.image,
    this.category,
    this.likes,
    this.comments,
    this.bookmarks,
    this.isLiked,
    this.isBookmarked,
    this.tags,
  });

  BlogModel.fromJson(Map<String, dynamic> json) {
    blogId = json['blogId'];
    title = json['title'];
    subtitle = json['subtitle'];
    content = json['content'];
    authorName = json['authorName'];
    authorImage = json['authorImage'];
    authorSpecialization = json['authorSpecialization'];
    publishedDate = json['publishedDate'];
    readTime = json['readTime'];
    image = json['image'];
    category = json['category'];
    likes = json['likes'];
    comments = json['comments'];
    bookmarks = json['bookmarks'];
    isLiked = json['isLiked'];
    isBookmarked = json['isBookmarked'];
    tags = json['tags']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['blogId'] = blogId;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['content'] = content;
    data['authorName'] = authorName;
    data['authorImage'] = authorImage;
    data['authorSpecialization'] = authorSpecialization;
    data['publishedDate'] = publishedDate;
    data['readTime'] = readTime;
    data['image'] = image;
    data['category'] = category;
    data['likes'] = likes;
    data['comments'] = comments;
    data['bookmarks'] = bookmarks;
    data['isLiked'] = isLiked;
    data['isBookmarked'] = isBookmarked;
    data['tags'] = tags;
    return data;
  }
}
