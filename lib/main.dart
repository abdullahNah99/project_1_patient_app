import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/api/services/local/cache_helper.dart';
import 'package:patient_app/core/styles/app_colors.dart';
import 'package:patient_app/core/utils/app_router.dart';
import 'package:patient_app/screens/doctor_screens/home_doctor_screen/home_doctor_screen.dart';
import 'package:patient_app/screens/login_screen/login_screen.dart';
import 'package:patient_app/screens/patient_screens/doctor_details_screen/doctor_details_screen.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/home_patient_screen.dart';

import 'core/api/dio_helper.dart';
import 'core/api/services/local/bloc_ob_server.dart';
import 'screens/secretary_screens/secretary_layout/secretaria_latout.dart';
import 'firebase_options.dart';

void main() async {
  String initalRoute;
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeFirebase();
  // await FirebaseAPIs.getFirebaseMessagingToken();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  // DioHelperG.init();

  DioHelper.init();
  //tokenDoc = CacheHelper.getData(key: 'token');

  if (await CacheHelper.getData(key: 'Token') == null) {
    initalRoute = LoginView.route;
  } else if (await CacheHelper.getData(key: 'Role') == 'secretary') {
    initalRoute = SecretariaLayout.route;
  } else if (await CacheHelper.getData(key: 'Role') == 'doctor') {
    initalRoute = DoctorHomeScreen.route;
  } else {
    initalRoute = DoctorDetailsView.route;
  }
  runApp(PatientApp(
    initialRoute: initalRoute,
  ));
}

late Size screenSize;

class PatientApp extends StatelessWidget {
  final String initialRoute;
  const PatientApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.white, size: 30.w),
                color: defaultColor,
                centerTitle: true,
                actionsIconTheme: IconThemeData(
                  color: Colors.white,
                  size: 30.w,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Colors.purple.shade300,
                //unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
                unselectedLabelStyle: const TextStyle(
                  color: Colors.black,
                ),
                type: BottomNavigationBarType.fixed,
              ),
              textTheme: TextTheme(
                bodySmall: TextStyle(//bodyText2
                  color: Colors.white,
                  fontSize: 15.w,
                  fontWeight: FontWeight.w500,
                ),
                labelLarge: TextStyle(//caption
                  fontSize: 12.5.w,
                  fontWeight: FontWeight.w400,
                ),
                titleSmall: TextStyle(//subtitle2
                    color: Colors.black,
                    fontSize: 12.5.w,
                    fontWeight: FontWeight.w400
                ),
                labelSmall: TextStyle(//overline
                    color: Colors.grey.shade500,
                    fontSize: 9.w,
                    fontWeight: FontWeight.w300
                ),
              ),
            ),
            darkTheme: ThemeData(
              //scaffoldBackgroundColor: Colors.grey.shade300,
              useMaterial3: true,
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.grey.shade800, size: 30.w),
                color: defaultColor,
                centerTitle: true,
                actionsIconTheme: IconThemeData(
                  color: Colors.black,
                  size: 30.w,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.grey.shade600,
                selectedItemColor: Colors.purple.shade300,
                unselectedItemColor: Colors.grey.shade50,
                showUnselectedLabels: true,
                unselectedLabelStyle: const TextStyle(
                  color: Colors.white,
                ),
                type: BottomNavigationBarType.fixed,
              ),
              textTheme: TextTheme(
                bodyText2: TextStyle(
                  color: Colors.black,
                  fontSize: 15.w,
                  fontWeight: FontWeight.w500,
                ),
                caption: TextStyle(
                  color: Colors.white,
                  fontSize: 12.5.w,
                  fontWeight: FontWeight.w400,
                ),
                subtitle2: TextStyle(
                    color: Colors.white,
                    fontSize: 12.5.w,
                    fontWeight: FontWeight.w400
                ),
                overline: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 9.w,
                    fontWeight: FontWeight.w300
                ),
              ),
            ),
            themeMode: ThemeMode.light,
            home: CacheHelper.getData(key: 'Token') == null
                ? const LoginView()
                : CacheHelper.getData(key: 'Role') == 'doctor'
                    ? DoctorHomeScreen(token: CacheHelper.getData(key: 'Token'))
                    : CacheHelper.getData(key: 'Role') == 'secretary'
                        ? SecretariaLayout() /*AppointmentsRequestsView(
                        token: CacheHelper.getData(key: 'Token'))*/
                        : CacheHelper.getData(key: 'Role') == 'doctor'
                            ? DoctorHomeScreen(
                                token: CacheHelper.getData(key: 'Token'),
                              )
                            : const HomePatientView(),
            // initialRoute: initialRoute,
            routes: AppRouter.router);
      },
    );
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
