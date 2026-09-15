import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_streem_state.dart';

class DashboardStreemCubit extends Cubit<DashboardStreemState> {
  DashboardStreemCubit() : super(DashboardStreemInitial());
}
