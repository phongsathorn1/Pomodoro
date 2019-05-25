import 'package:flutter/material.dart';
import 'package:pomodoro/fonts/fonts.dart';
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
          'รายละเอียดหนังสือ',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: GetTextStyle(),
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[350],
        child: SingleChildScrollView(
          child: Card(
            margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text(
                        book.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: GetTextStyle(),
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child:
                        Image.network(book.bookImage, height: 300, width: 250),
                  ),
                  ListTile(
                    leading: Text(
                      'Author: ',
                      style: TextStyle(
                        fontFamily: GetTextStyle(),
                        fontSize: 25,
                      ),
                    ),
                    title: Text(
                      book.author,
                      style: TextStyle(
                        fontFamily: GetTextStyle(),
                        fontSize: 25,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      'Publisher: ',
                      style: TextStyle(
                        fontFamily: GetTextStyle(),
                        fontSize: 25,
                      ),
                    ),
                    title: Text(
                      book.publisher,
                      style: TextStyle(
                        fontFamily: GetTextStyle(),
                        fontSize: 25,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      'Contributor: ',
                      style: TextStyle(
                        fontFamily: GetTextStyle(),
                        fontSize: 25,
                      ),
                    ),
                    title: Text(
                      book.contributor,
                      style: TextStyle(
                        fontFamily: GetTextStyle(),
                        fontSize: 25,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      'ISBN: ',
                      style: TextStyle(
                        fontFamily: GetTextStyle(),
                        fontSize: 25,
                      ),
                    ),
                    title: Text(book.primaryIsbn10),
                  ),
                  ListTile(
                    leading: Text(
                      'Description: ',
                      style: TextStyle(
                        fontFamily: GetTextStyle(),
                        fontSize: 25,
                      ),
                    ),
                    title: Text(book.description),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
