import 'package:flutter/material.dart';
import 'Model/bookcategory.dart';

class BookDetails extends StatefulWidget {
  BookDetails({Key key, this.value}) : super(key: key);
  var value;
  BookDetailsState createState() => BookDetailsState();
}

/*
class BookElement
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
*/

class BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    BookElement book = widget.value;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          book.title,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Container(
        child: Padding(padding: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
          child: Column(
            children: <Widget>[
              Image.network(book.bookImage, height: 300, width: 250),
              Text('Author: ' + book.author),
              Text('Publisher: ' + book.publisher),
              Text('Contributor: ' + book.contributor),
              Text('ISBN: ' + book.primaryIsbn10),
              Text('Description: ' + book.description),
            ],
          ),
        )
      ),
    );
  }
}
