import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:healthifi_patient/src/%20careGoalPlanSection/providers/care_goal_provider.dart';
import 'package:healthifi_patient/src/apppointmentsSection/providers/appointmentProvider.dart';
import 'package:healthifi_patient/src/apppointmentsSection/providers/timeslot_provider.dart';
import 'package:healthifi_patient/src/authenticationsection/providers/authProvider.dart';
import 'package:healthifi_patient/src/authenticationsection/providers/savUserDetailsProvider.dart';
import 'package:healthifi_patient/src/authenticationsection/screens/createAccountScreen.dart';
import 'package:healthifi_patient/src/authenticationsection/screens/loginScreen.dart';
import 'package:healthifi_patient/src/authenticationsection/screens/patientQuestionare.dart';
import 'package:healthifi_patient/src/authenticationsection/screens/personalInformationScreen.dart';
import 'package:healthifi_patient/src/authenticationsection/screens/splashScreen.dart';
import 'package:healthifi_patient/src/chatSection/providers/userChatProvider.dart';
import 'package:healthifi_patient/src/dashboardSection/providers/bottom_navbar_provider.dart';
import 'package:healthifi_patient/src/dashboardSection/providers/search_provider.dart';
import 'package:healthifi_patient/src/dashboardSection/screens/bottomNavScreen.dart';
import 'package:healthifi_patient/src/dashboardSection/screens/homeScreen.dart';
import 'package:healthifi_patient/src/healthSection/providers/healthzoneProvider.dart';
import 'package:healthifi_patient/src/mealPlansSection/providers/meal_plan_provider.dart';
import 'package:healthifi_patient/src/medicalRecordSection/providers/medicalRecordProvider.dart';
import 'package:healthifi_patient/src/notesSection/providers/soap_note_provider.dart';
import 'package:healthifi_patient/src/nutritionGoalPlanSection/providers/nuttrition_Care_provider.dart';
import 'package:healthifi_patient/src/onboardingsection/screens/onboardingscreen_one.dart';
import 'package:healthifi_patient/src/onboardingsection/screens/onboardingscreen_three.dart';
import 'package:healthifi_patient/src/onboardingsection/screens/onboardingscreen_two.dart';
import 'package:healthifi_patient/src/recipesSection/providers/recipes_provider.dart';
import 'package:healthifi_patient/src/reviewsSection/providers/review_provider.dart';
import 'package:healthifi_patient/src/subscriptionSection/providers/subscription_provider.dart';
import 'package:healthifi_patient/src/workOutSection/providers/workout_provider.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'common/helperFunctions/navigatorHelper.dart';
import 'common/keys/stripe_keys.dart';
import 'common/utils/themes.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  createNotification(
    title: message.data['title'].toString(),
    body: message.data['body'].toString(),
  );
}

Future<void> createNotification(
    {required String title, required String body}) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 1, channelKey: 'basic_channel', title: title, body: body),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Stripe.publishableKey = StripeKeys.publishableKey;

  AwesomeNotifications().initialize(
    'resource://drawable/healthify',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        channelDescription: 'basic description',
      ),
    ],
  ).then((value) => print(value));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Allow Notifications'),
              content:
                  const Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: const Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
    FirebaseMessaging.onMessage.listen((message) {
      createNotification(
        title: message.data['title'].toString(),
        body: message.data['body'].toString(),
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      createNotification(
        title: message.data['title'].toString(),
        body: message.data['body'].toString(),
      );
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => BottomNavProvider()),
          ChangeNotifierProvider(create: (context) => AppointmentProvider()),
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => UserChatProvider()),
          ChangeNotifierProvider(create: (context) => MedicalRecordProvider()),
          ChangeNotifierProvider(create: (context) => ReviewProvider()),
          ChangeNotifierProvider(create: (context) => HealthZonProvider()),
          ChangeNotifierProvider(create: (context) => TimeSlotProvider()),
          ChangeNotifierProvider(create: (context) => SubscriptionProvider()),
          ChangeNotifierProvider(create: (context) => RecipesProvider()),
          ChangeNotifierProvider(create: (context) => WorkoutProvider()),
          ChangeNotifierProvider(create: (context) => SearchProvider()),
          ChangeNotifierProvider(create: (context) => DiagnosticProvider()),
          ChangeNotifierProvider(create: (context) => CareGoalProvider()),
          ChangeNotifierProvider(create: (context) => SoapNoteProvider()),
          ChangeNotifierProvider(create: (context) => MealPlanProvider()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            navigatorKey: navstate,

            //supportedLocales: ,
            theme: AppTheme.themeData,
            routes: {
              LoginScreen.routeName: (context) => LoginScreen(),
              CreateAccountScreen.routeName: (context) =>
                  const CreateAccountScreen(),
              HomeScreen.routeName: (context) => const HomeScreen(),
              BottomNavScreen.routeName: (context) => const BottomNavScreen(),
              OnBoardingScreenOne.routeName: (context) =>
                  const OnBoardingScreenOne(),
              OnBoardingScreenTwo.routeName: (context) =>
                  const OnBoardingScreenTwo(),
              OnBoardingScreenThree.routeName: (context) =>
                  const OnBoardingScreenThree(),
              PersonalInformationScreen.routeName: (context) =>
                  const PersonalInformationScreen(),
              PatientQuestionareScreen.routeName: (context) =>
                  const PatientQuestionareScreen(),
            },
            home: SplashScreen()));
  }
}
