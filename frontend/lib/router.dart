import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:orot/pages/admin/admin_page.dart';
import 'package:orot/pages/coordinator/navigation.dart';
import 'package:orot/pages/coordinator/volunteers_list/volunteers_list.dart';
import 'package:orot/pages/login/login_page.dart';
import 'package:orot/pages/profile/profile_page.dart';
import 'package:orot/pages/volunteer/home/home_page.dart';
import 'package:orot/pages/volunteer/navigation.dart';
import 'package:orot/pages/volunteer/visits_history/visits_history_page.dart';
import 'package:orot/providers/user_provider.dart';
import 'package:provider/provider.dart';

//TODO: remove this
class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Text('${context.read<UserProvider>().user}');
  }
}

GoRouter getConfigRouter() {
  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  return GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    initialLocation: '/login',
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        redirect: (context, state) {
          final user = Provider.of<UserProvider>(context, listen: false).user;
          Fluttertoast.showToast(msg: 'XXUSER: ${user?.permission}');
          if (user != null) {
            return '/volunteer/home';
          }
          return null;
        },
        // providers: [Provider(create: (context) => UserProvider())],
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/management',
        builder: (context, state) => const AdminPage(),
      ),
      adminRoutes(),
      volunteerRoutes(rootNavigatorKey),
      coordinatorRoutes(),
    ],
  );
}

GoRoute volunteerRoutes(GlobalKey<NavigatorState> rootNavigatorKey) {
  return GoRoute(
    path: '/volunteer',
    builder: (context, state) => const Placeholder(),
    routes: [
      ShellRoute(
        navigatorKey: rootNavigatorKey,
        builder: (context, state, child) {
          return VolunteerNavigation();
        },
        routes: [
          GoRoute(
            path: 'home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: 'history',
            builder: (context, state) => const VisitsHistoryPage(),
          ),
          GoRoute(
            path: 'profile',
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
    ],
  );
}

GoRoute adminRoutes() {
  return GoRoute(
    path: '/admin',
    builder: (context, state) => const Placeholder(),
    routes: [
      GoRoute(
        path: 'home',
        builder: (context, state) => const AdminPage(),
      )
    ],
  );
}

GoRoute coordinatorRoutes() {
  return GoRoute(
    path: '/coordinator',
    builder: (context, state) => const Placeholder(),
    routes: [
      GoRoute(
        path: 'home',
        builder: (context, state) => const CoordinatorNavigation(),
      )
    ],
  );
}
