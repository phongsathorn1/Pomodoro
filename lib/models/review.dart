import 'dart:async';

class Review {
  String isbn;
  String create_by;
  String content;
  String like;

  Review({this.isbn, this.create_by, this.content, this.like});

  Review.fromMap(Map<String, dynamic> map)
      : isbn = map['isbn'],
        create_by = map['create_by'],
        content = map['content'],
        like = map['like'];
}

abstract class CryptoRepository {
  Future<List<Review>> fetchCurrencies();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
