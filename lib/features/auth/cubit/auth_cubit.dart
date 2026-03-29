import 'package:bloc/bloc.dart';
import 'package:bookia_store/features/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());



  Future <void> login({required String email,required String password})async{
    emit(AuthLoadingState());
    //TODO(login)
   final response=await AuthRepo.login(email: email, password: password);
   if(response.isNotEmpty){
     emit(AuthSuccessState());
   }else{
     emit(AuthErrorState());
   }
  }
}
