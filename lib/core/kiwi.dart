import 'package:kiwi/kiwi.dart';

import '../shopScreens/ShopHomeScreen/bloc/profile_bloc.dart';
import '../shopScreens/addReport/bloc/add_report_bloc.dart';
import '../shopScreens/reports/bloc/reports_bloc.dart';
import '../shopScreens/shopAuth/login/bloc/login_bloc.dart';
import '../shopScreens/shopAuth/signup/bloc/signup_bloc.dart';
import '../shopScreens/startreport/bloc/start_report_bloc.dart';

Future<void> initKiwi() async {
  KiwiContainer container = KiwiContainer();
   container.registerFactory((container) => LoginBloc());
   container.registerFactory((container) => SignupBloc());
   container.registerFactory((container) => StartReportBloc());
   container.registerFactory((container) => AddReportBloc());
   container.registerFactory((container) => ReportsBloc());
   container.registerFactory((container) => ProfileBloc());


}
