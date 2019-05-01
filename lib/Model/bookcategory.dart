// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

String bookToJson(Book data) => json.encode(data.toJson());

class Book {
  String status;
  String copyright;
  int numBookResults;
  DateTime lastModified;
  Results results;

  Book({
    this.status,
    this.copyright,
    this.numBookResults,
    this.lastModified,
    this.results,
  });

  factory Book.fromJson(Map<String, dynamic> json) => new Book(
    status: json["status"],
    copyright: json["copyright"],
    numBookResults: json["num_results"],
    lastModified: DateTime.parse(json["last_modified"]),
    results: Results.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "copyright": copyright,
    "num_results": numBookResults,
    "last_modified": lastModified.toIso8601String(),
    "results": results.toJson(),
  };
}

class Results {
  String listName;
  String listNameEncoded;
  DateTime bestsellersDate;
  DateTime publishedDate;
  String publishedDateDescription;
  String nextPublishedDate;
  DateTime previousPublishedDate;
  String displayName;
  int normalListEndsAt;
  String updated;
  List<BookElement> books;
  List<dynamic> corrections;

  Results({
    this.listName,
    this.listNameEncoded,
    this.bestsellersDate,
    this.publishedDate,
    this.publishedDateDescription,
    this.nextPublishedDate,
    this.previousPublishedDate,
    this.displayName,
    this.normalListEndsAt,
    this.updated,
    this.books,
    this.corrections,
  });

  factory Results.fromJson(Map<String, dynamic> json) => new Results(
    listName: json["list_name"],
    listNameEncoded: json["list_name_encoded"],
    bestsellersDate: DateTime.parse(json["bestsellers_date"]),
    publishedDate: DateTime.parse(json["published_date"]),
    publishedDateDescription: json["published_date_description"],
    nextPublishedDate: json["next_published_date"],
    previousPublishedDate: DateTime.parse(json["previous_published_date"]),
    displayName: json["display_name"],
    normalListEndsAt: json["normal_list_ends_at"],
    updated: json["updated"],
    books: new List<BookElement>.from(json["books"].map((x) => BookElement.fromJson(x))),
    corrections: new List<dynamic>.from(json["corrections"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "list_name": listName,
    "list_name_encoded": listNameEncoded,
    "bestsellers_date": "${bestsellersDate.year.toString().padLeft(4, '0')}-${bestsellersDate.month.toString().padLeft(2, '0')}-${bestsellersDate.day.toString().padLeft(2, '0')}",
    "published_date": "${publishedDate.year.toString().padLeft(4, '0')}-${publishedDate.month.toString().padLeft(2, '0')}-${publishedDate.day.toString().padLeft(2, '0')}",
    "published_date_description": publishedDateDescription,
    "next_published_date": nextPublishedDate,
    "previous_published_date": "${previousPublishedDate.year.toString().padLeft(4, '0')}-${previousPublishedDate.month.toString().padLeft(2, '0')}-${previousPublishedDate.day.toString().padLeft(2, '0')}",
    "display_name": displayName,
    "normal_list_ends_at": normalListEndsAt,
    "updated": updated,
    "books": new List<dynamic>.from(books.map((x) => x.toJson())),
    "corrections": new List<dynamic>.from(corrections.map((x) => x)),
  };
}

class BookElement {
  int rank;
  int rankLastWeek;
  int weeksOnList;
  int asterisk;
  int dagger;
  String primaryIsbn10;
  String primaryIsbn13;
  String publisher;
  String description;
  int price;
  String title;
  String author;
  String contributor;
  String contributorNote;
  String bookImage;
  int bookImageWidth;
  int bookImageHeight;
  String amazonProductUrl;
  String ageGroup;
  String bookReviewLink;
  String firstChapterLink;
  String sundayReviewLink;
  String articleChapterLink;
  List<Isbn> isbns;
  List<BuyLink> buyLinks;

  BookElement({
    this.rank,
    this.rankLastWeek,
    this.weeksOnList,
    this.asterisk,
    this.dagger,
    this.primaryIsbn10,
    this.primaryIsbn13,
    this.publisher,
    this.description,
    this.price,
    this.title,
    this.author,
    this.contributor,
    this.contributorNote,
    this.bookImage,
    this.bookImageWidth,
    this.bookImageHeight,
    this.amazonProductUrl,
    this.ageGroup,
    this.bookReviewLink,
    this.firstChapterLink,
    this.sundayReviewLink,
    this.articleChapterLink,
    this.isbns,
    this.buyLinks,
  });

  factory BookElement.fromJson(Map<String, dynamic> json) => new BookElement(
    rank: json["rank"],
    rankLastWeek: json["rank_last_week"],
    weeksOnList: json["weeks_on_list"],
    asterisk: json["asterisk"],
    dagger: json["dagger"],
    primaryIsbn10: json["primary_isbn10"],
    primaryIsbn13: json["primary_isbn13"],
    publisher: json["publisher"],
    description: json["description"],
    price: json["price"],
    title: json["title"],
    author: json["author"],
    contributor: json["contributor"],
    contributorNote: json["contributor_note"],
    bookImage: json["book_image"],
    bookImageWidth: json["book_image_width"],
    bookImageHeight: json["book_image_height"],
    amazonProductUrl: json["amazon_product_url"],
    ageGroup: json["age_group"],
    bookReviewLink: json["book_review_link"],
    firstChapterLink: json["first_chapter_link"],
    sundayReviewLink: json["sunday_review_link"],
    articleChapterLink: json["article_chapter_link"],
    isbns: new List<Isbn>.from(json["isbns"].map((x) => Isbn.fromJson(x))),
    buyLinks: new List<BuyLink>.from(json["buy_links"].map((x) => BuyLink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "rank": rank,
    "rank_last_week": rankLastWeek,
    "weeks_on_list": weeksOnList,
    "asterisk": asterisk,
    "dagger": dagger,
    "primary_isbn10": primaryIsbn10,
    "primary_isbn13": primaryIsbn13,
    "publisher": publisher,
    "description": description,
    "price": price,
    "title": title,
    "author": author,
    "contributor": contributor,
    "contributor_note": contributorNote,
    "book_image": bookImage,
    "book_image_width": bookImageWidth,
    "book_image_height": bookImageHeight,
    "amazon_product_url": amazonProductUrl,
    "age_group": ageGroup,
    "book_review_link": bookReviewLink,
    "first_chapter_link": firstChapterLink,
    "sunday_review_link": sundayReviewLink,
    "article_chapter_link": articleChapterLink,
    "isbns": new List<dynamic>.from(isbns.map((x) => x.toJson())),
    "buy_links": new List<dynamic>.from(buyLinks.map((x) => x.toJson())),
  };
}

class BuyLink {
  Name name;
  String url;

  BuyLink({
    this.name,
    this.url,
  });

  factory BuyLink.fromJson(Map<String, dynamic> json) => new BuyLink(
    name: nameValues.map[json["name"]],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": nameValues.reverse[name],
    "url": url,
  };
}

enum Name { LOCAL_BOOKSELLERS, BARNES_AND_NOBLE, AMAZON }

final nameValues = new EnumValues({
  "Amazon": Name.AMAZON,
  "Barnes and Noble": Name.BARNES_AND_NOBLE,
  "Local Booksellers": Name.LOCAL_BOOKSELLERS
});

class Isbn {
  String isbn10;
  String isbn13;

  Isbn({
    this.isbn10,
    this.isbn13,
  });

  factory Isbn.fromJson(Map<String, dynamic> json) => new Isbn(
    isbn10: json["isbn10"],
    isbn13: json["isbn13"],
  );

  Map<String, dynamic> toJson() => {
    "isbn10": isbn10,
    "isbn13": isbn13,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
//Book bookFromJson(String str) {
//  final jsonData = json.decode(str);
//  return Book.fromJson(jsonData);
//}
//
//String bookToJson(Book data) {
//  final dyn = data.toJson();
//  return json.encode(dyn);
//}
List<Book> allPostsFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Book>.from(jsonData.map((x) => Book.fromJson(x)));
}

String allPostsToJson(List<Book> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}
