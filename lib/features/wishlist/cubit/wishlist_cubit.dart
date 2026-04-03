import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/data/models/book_model.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistState(wishlistItems: []));

  void toggleWishlist(BookModel book) {
    final items = List<BookModel>.from(state.wishlistItems);
    if (items.any((item) => item.id == book.id)) {
      items.removeWhere((item) => item.id == book.id);
    } else {
      items.add(book);
    }
    emit(WishlistState(wishlistItems: items));
  }

  bool isInWishlist(int bookId) {
    return state.wishlistItems.any((item) => item.id == bookId);
  }
}
