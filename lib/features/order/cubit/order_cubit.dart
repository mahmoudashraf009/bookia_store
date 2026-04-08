import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/order_model.dart';
import '../data/models/governorate_model.dart';
import '../data/repo/order_repo.dart';
import '../../../core/helper/dio_helper.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  List<GovernorateModel> governorates = [];
  List<OrderModel> orders = [];

  Future<void> getGovernorates() async {
    emit(GetGovernoratesLoading());
    try {
      final response = await OrderRepo.getGovernorates();
      if (response.statusCode == 200) {
        final List data = response.data['data'] ?? response.data['governorates'] ?? [];
        governorates = data.map((e) => GovernorateModel.fromJson(e)).toList();
        emit(GetGovernoratesSuccess());
      } else {
        emit(GetGovernoratesError("Failed to load governorates"));
      }
    } catch (e) {
      emit(GetGovernoratesError(DioHelper.getErrorMessage(e)));
    }
  }

  Future<void> checkout() async {
    emit(CheckoutLoading());
    try {
      final response = await OrderRepo.checkout();
      if (response.statusCode == 200) {
        emit(CheckoutSuccess(response.data));
      } else {
        emit(CheckoutError("Failed to load checkout"));
      }
    } catch (e) {
      emit(CheckoutError(DioHelper.getErrorMessage(e)));
    }
  }

  Future<void> placeOrder({
    required String name,
    required String email,
    required String phone,
    required String address,
    required int governorateId,
  }) async {
    emit(PlaceOrderLoading());
    try {
      final response = await OrderRepo.placeOrder(
        name: name,
        email: email,
        phone: phone,
        address: address,
        governorateId: governorateId,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(PlaceOrderSuccess());
      } else {
        emit(PlaceOrderError("Failed to place order"));
      }
    } catch (e) {
      emit(PlaceOrderError(DioHelper.getErrorMessage(e)));
    }
  }

  Future<void> getOrderHistory() async {
    emit(OrderHistoryLoading());
    try {
      final response = await OrderRepo.getOrderHistory();
      if (response.statusCode == 200) {
        final List data = response.data['data'] ?? response.data['orders'] ?? [];
        orders = data.map((e) => OrderModel.fromJson(e)).toList();
        emit(OrderHistorySuccess());
      } else {
        emit(OrderHistoryError("Failed to load orders"));
      }
    } catch (e) {
      emit(OrderHistoryError(DioHelper.getErrorMessage(e)));
    }
  }

  Future<void> showSingleOrder(int orderId) async {
    emit(ShowSingleOrderLoading());
    try {
      final response = await OrderRepo.showSingleOrder(orderId);
      if (response.statusCode == 200) {
        final order = OrderModel.fromJson(response.data['data'] ?? response.data);
        emit(ShowSingleOrderSuccess(order));
      } else {
        emit(ShowSingleOrderError("Failed to load order"));
      }
    } catch (e) {
      emit(ShowSingleOrderError(DioHelper.getErrorMessage(e)));
    }
  }
}
