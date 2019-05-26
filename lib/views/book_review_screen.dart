import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cached_network_image/cached_network_image.dart';

class BookReviewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookReviewScreenState();
  }
}

class BookReviewScreenState extends State<BookReviewScreen> {
  int _navIndex = 0;
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
  }

  Widget _getSubtitleText(AsyncSnapshot<QuerySnapshot> snapshotReview,
      AsyncSnapshot<QuerySnapshot> snapshotUser, int index) {
    String uid = snapshotUser.data.documents.elementAt(0).documentID;
    String review_id =
        snapshotReview.data.documents.elementAt(index).documentID;
    String content = snapshotReview.data.documents.elementAt(index)['content'];
    String like =
        snapshotReview.data.documents.elementAt(index)['like'].toString();
    bool isLiked = false;
    for (var isLiked_review
        in snapshotUser.data.documents.elementAt(0)['liked_reviews']) {
      isLiked = isLiked_review == review_id;
    }
    ;
    TextSpan contentTextWidget =
        TextSpan(text: "$content\n", style: TextStyle(color: Colors.black));
    String likeText = "Like: $like";
    GestureDetector likeTextWidget;

    likeTextWidget = GestureDetector(
        onTap: () {
          setLike(uid, review_id, isLiked);
        },
        child: RichText(
          text: TextSpan(
              text: likeText,
              style: TextStyle(color: isLiked ? Colors.blue : Colors.black)),
        ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[RichText(text: contentTextWidget), likeTextWidget],
      // text: TextSpan(children: [priceTextWidget, likeTextWidget])
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection("reviews").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshotReview) {
          if (snapshotReview.hasError) {
            return Text('Error: ${snapshotReview.error}');
          }

          if (snapshotReview.hasData) {
            switch (snapshotReview.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return ListView.builder(
                    itemCount: snapshotReview.data.documents.length,
                    itemBuilder: (BuildContext context, int indexReview) {
                      return StreamBuilder(
                          stream: Firestore.instance
                              .collection("users")
                              .where("uid",
                                  isEqualTo: snapshotReview.data.documents
                                      .elementAt(indexReview)
                                      .data['create_by'])
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot> snapshotUser) {
                            if (snapshotUser.hasError) {
                              return Text('Error: ${snapshotUser.error}');
                            }

                            if (snapshotUser.hasData) {
                              switch (snapshotUser.connectionState) {
                                case ConnectionState.waiting:
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                default:
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: ListTile(
                                            leading: Material(
                                              child: CachedNetworkImage(
                                                placeholder: (context, url) =>
                                                    Container(
                                                      child:
                                                          CircularProgressIndicator(
                                                        strokeWidth: 1.0,
                                                      ),
                                                      width: 55.0,
                                                      height: 55.0,
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                    ),
                                                imageUrl: snapshotUser
                                                            .data.documents
                                                            .elementAt(0)
                                                            .data['photoUrl'] !=
                                                        null
                                                    ? snapshotUser
                                                        .data.documents
                                                        .elementAt(0)
                                                        .data['photoUrl']
                                                    : 'http://serenityforge.com/template/wordpress/wp-content/uploads/2014/06/facebook-default-no-profile-pic.jpg',
                                                width: 55.0,
                                                height: 55.0,
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(32.0),
                                              ),
                                              clipBehavior: Clip.hardEdge,
                                            ),
                                            title: Text(
                                                snapshotUser.data.documents
                                                        .elementAt(0)
                                                        .data['firstname']
                                                        .toString() +
                                                    " " +
                                                    snapshotUser.data.documents
                                                        .elementAt(0)
                                                        .data['surname']
                                                        .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            subtitle: _getSubtitleText(
                                                snapshotReview,
                                                snapshotUser,
                                                indexReview),
                                            isThreeLine: true,
                                          )),
                                      Divider(height: 5.0),
                                    ],
                                  );
                              }
                            } else {
                              return Container();
                            }
                          });
                    });
            }
          } else {
            return Center(
              child: Text("ยังไม่มีรีวิวสำหรับหนังสือเล่มนี้"),
            );
          }
        });
  }

  setLike(String uid, String review_id, bool isLiked) {
    final DocumentReference reviewRef =
        Firestore.instance.document('reviews/${review_id}');
    Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot postSnapshot = await tx.get(reviewRef);
      if (postSnapshot.exists) {
        await tx.update(reviewRef, <String, dynamic>{
          'like': isLiked ? postSnapshot['like'] - 1 : postSnapshot['like'] + 1
        });
      }
    });
    final DocumentReference userRef =
        Firestore.instance.document('users/${uid}');
    Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot postSnapshot = await tx.get(userRef);
      var liked_reviews = List.from(postSnapshot['liked_reviews']);
      if (postSnapshot.exists) {
        if (isLiked) {
          liked_reviews.remove(review_id);
        } else {
          liked_reviews.add(review_id);
        }
        await tx
            .update(userRef, <String, dynamic>{'liked_reviews': liked_reviews});
      }
    });
  }
}
