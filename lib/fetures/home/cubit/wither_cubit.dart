import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tayf/core/api/api_helper.dart';
import 'package:tayf/core/routing/routs.dart';
import 'package:tayf/fetures/home/model/weather_model.dart';

part 'wither_state.dart';

class WitherCubit extends Cubit<WitherState> {
  WitherCubit() : super(WitherInitial());
  Future<void> getWeatherData(String cityName) async {
    emit(WitherLoading());
    try {
      final response = await DioHelper.getData(
        endPoints: "${ApiConstant.getWeatherData}&q=$cityName",
      );
      emit(WitherLoaded(WeatherModel.fromJson(response.data)));
    } catch (e) {
      emit(WitherError(e.toString()));
    }
  }
}
