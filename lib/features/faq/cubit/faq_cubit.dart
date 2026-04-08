import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/faq_model.dart';
import '../data/repo/faq_repo.dart';

part 'faq_state.dart';

class FaqCubit extends Cubit<FaqState> {
  FaqCubit() : super(FaqInitial());

  List<FaqModel> faqs = [];

  Future<void> getFaqs() async {
    emit(FaqLoading());
    try {
      final response = await FaqRepo.getFaqs();
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final List faqList = data['faqs'] ?? data ?? [];
        faqs = faqList.map((e) => FaqModel.fromJson(e)).toList();
        emit(FaqSuccess());
      } else {
        emit(FaqError("Failed to load FAQs"));
      }
    } on Exception catch (e) {
      emit(FaqError(e.toString()));
    }
  }
}
