import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/contact_repo.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactInitial());

  Future<void> sendMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    emit(ContactLoading());
    try {
      final response = await ContactRepo.sendMessage(
        name: name,
        email: email,
        subject: subject,
        message: message,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(ContactSuccess());
      } else {
        emit(ContactError("Failed to send message"));
      }
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }
}
