import 'package:instantgram/enum/data_sorting.dart';
import 'package:instantgram/state/comments/model/comment.dart';
import 'package:instantgram/state/comments/model/post_comment_request.dart';

extension Sorting on Iterable<Comment> {
  Iterable<Comment> applySortingFrom(RequestForPostAndComments request) {
    if (request.sortByCreatedAt) {
      final sortedDocument = toList()
        ..sort((a, b) {
          switch (request.dateSorting) {
            case DateSorting.newsOnTop:
              return b.createdAt.compareTo(a.createdAt);
            case DateSorting.oldesOnTop:
              return a.createdAt.compareTo(b.createdAt);
          }
        });
      return sortedDocument;
    } else {
      return this;
    }
  }
}
