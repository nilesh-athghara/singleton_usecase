import 'package:firebase_database/firebase_database.dart';

class Data{
  String audio;
  String author_name;
  String categoryId;
  String description;
  String image;
  String title;
  Data(this.audio,
      this.author_name,
      this.categoryId,
      this.description,
      this.image,

      this.title,

      );
  Data.fromSnapshot(DataSnapshot snapshot) :
  // id = snapshot.key,
        audio = snapshot.value["audio"],
        author_name = snapshot.value["author_name"],
        categoryId = snapshot.value["categoryId"],
        description = snapshot.value["description"],
        image = snapshot.value["image"],
        title = snapshot.value["title"];

  toJson() {
    return {
      "audio": audio,
      "author_name": author_name,
      "categoryId": categoryId,
      "description": description,
      "image": image,

      "title": title,
    };
  }
  @override
  String toString() {
    return 'Data{audio: $audio, author_name: $author_name, categoryId: $categoryId, description: $description, image: $image, title: $title}';



  }
// Data.fromJson(Map<String, dynamic> parsedJSON)
//     : AudioUrl = parsedJSON['AudioUrl'],
//       ImgUrl = parsedJSON['ImgUrl'],
//       AudioDescription = parsedJSON['AudioDescription'],
//       AudioName = parsedJSON['AudioName'],
//       AudioAuthor = parsedJSON['AudioAuthor'],
//       AudioCategory = parsedJSON['AudioCategory'];

}