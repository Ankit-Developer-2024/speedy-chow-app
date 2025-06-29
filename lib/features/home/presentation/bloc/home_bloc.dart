import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_chow/core/components/models/api_response.dart';
import 'package:speedy_chow/core/usecase/use_case.dart';
import 'package:speedy_chow/features/home/domain/enitites/product.dart';
import 'package:speedy_chow/features/home/domain/use_cases/fetch_all_products.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchAllProduct fetchAllProduct;

  HomeBloc({required this.fetchAllProduct}) : super(HomeInitial()) {
    on<HomeFetchAllProductEvent>(_fetchAllProduct);
  }

  void _fetchAllProduct(HomeFetchAllProductEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeFetchAllProductState(msg: "Loading", loading: true, success: false, data: []));

      ApiResponse? response = await fetchAllProduct(NoParams());
      if (response?.success == true) {
        emit(HomeFetchAllProductState(
            success: response?.success ?? false,
            loading: false,
            data: response?.data ?? [],
            msg: response?.message ?? ''));
      } else {
        emit(HomeFetchAllProductState(
            success: false,
            loading: false,
            data: response?.data ?? [],
            msg: response?.message ?? 'Something went wrong'));
      }
    } catch (e) {
      emit(HomeFetchAllProductState(
          success: false,
          loading: false,
          data:  [],
          msg: e.toString()));
    }
  }

}
