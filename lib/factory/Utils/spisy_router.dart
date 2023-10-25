import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:spisyprovider/factory/Utils/transition_util.dart';
import 'package:spisyprovider/factory/implementor/providers/button_form_behaviour_provider_impl.dart';
import 'package:spisyprovider/factory/implementor/providers/landing_page_provider_impl.dart';
import 'package:spisyprovider/factory/implementor/providers/list_catd_provider_impl.dart';
import 'package:spisyprovider/factory/implementor/providers/student_provider_impl.dart';
import 'package:spisyprovider/factory/provider/button_form_behaviour_provider.dart';
import 'package:spisyprovider/factory/provider/landing_page_provider.dart';
import 'package:spisyprovider/factory/provider/list_card_provider.dart';
import 'package:spisyprovider/factory/provider/student_provider.dart';
import 'package:spisyprovider/factory/provider/user_provider.dart';
import 'package:spisyprovider/views/Page/form/student_form.dart';
import 'package:spisyprovider/views/Page/landing/landing.dart';
import 'package:spisyprovider/views/Page/loading_page/loading_executor.dart';
import 'package:spisyprovider/views/Page/loading_page/loading_page.dart';
import 'package:spisyprovider/views/Page/login/login.dart';
import 'package:spisyprovider/views/Page/splash/splash.dart';
import 'package:spisyprovider/views/views/fragments/llist_student/list_student.dart';
import 'package:spisyprovider/views/views/fragments/logout/logout.dart';
import 'package:spisyprovider/views/views/loading.dart';
import 'package:spisyprovider/warehouse/constant_collection.dart';
import 'package:spisyprovider/warehouse/models/student_model.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root-navigator');
final GlobalKey<NavigatorState> _authenticationKey = GlobalKey<NavigatorState>(debugLabel: 'athenticated-navigator');
final GlobalKey<NavigatorState> _nestedNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "nested-Nvigator");


  final GoRouter  currentRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: ConstantCollection.repository.routers.location.splash,
  routes: [

    ShellRoute(
      navigatorKey:_authenticationKey,
      parentNavigatorKey: _rootNavigatorKey,
      routes: [

        ShellRoute(
          navigatorKey: _nestedNavigatorKey,
          parentNavigatorKey: _authenticationKey,
          routes: [
            GoRoute(
              parentNavigatorKey: _nestedNavigatorKey,
              path: ConstantCollection.repository.routers.location.listStudent,
              name: ConstantCollection.repository.routers.name.listStudent,
              pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const ListStudent(), 
                transitionsBuilder: (context, animation, secondaryAnimation, child) => 
                  TransitionUtil.transition.sliding(
                    child: child, 
                    inAnim: animation, 
                    outAnim: secondaryAnimation, 
                    context: context,
                    isLeft: true
                  ),
                transitionDuration: const Duration(milliseconds: 500),
                reverseTransitionDuration: const Duration(milliseconds: 500)
              ),
              redirect: (context, state) {
                return checkUnauthorizedUser(context);
              },
            ),
            GoRoute(
              parentNavigatorKey: _nestedNavigatorKey,
              path: ConstantCollection.repository.routers.location.logout,
              name: ConstantCollection.repository.routers.name.logout,
              pageBuilder: (context, state) => 
                CustomTransitionPage(
                  child: const Logout(), 
                  transitionsBuilder: (context, animation, secondaryAnimation, child) => 
                    TransitionUtil.transition.sliding(
                      child: child, 
                      inAnim: animation, 
                      outAnim: secondaryAnimation, 
                      context: context
                    ),
                  transitionDuration: const Duration(milliseconds: 500),
                  reverseTransitionDuration: const Duration(milliseconds: 500)
                ),
              //builder: (context, state) => const Logout(),
              redirect: (context, state) {
                return checkUnauthorizedUser(context);
              },
            ),


          ],
          pageBuilder: (context, state, child) {
            return CustomTransitionPage(
              transitionsBuilder: (context, animation, secondaryAnimation, child) => 
                TransitionUtil.transition.fading(
                  child: child,
                  inAnim: animation, 
                  outAnim: secondaryAnimation, 
                  context: context,
                ), 
                transitionDuration: const Duration(milliseconds: 500),
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider<LandingPageProvider>(
                      create: (context) => LandingPageProviderImpl()
                    ),
                    ChangeNotifierProvider<ListCardProvider>(
                      create: (context) => ListCatdProviderImpl(),
                    )
                  ],
                  child: child,
                  builder: (context, child) => Landing(
                    child: child,
                  ),
                )
              );
            },
          ),

        GoRoute(
          parentNavigatorKey: _authenticationKey,
          path: ConstantCollection.repository.routers.location.form,
          name: ConstantCollection.repository.routers.name.form,
          pageBuilder: (context, state) => 
          CustomTransitionPage(
            child: Builder(
              builder: (context) {
                StudentModel? student;
                if(state.extra != null){
                  student = state.extra as StudentModel;
                }
                if(student != null){
                  return ChangeNotifierProvider<ButtonFormBehaviourProvider>(
                    create: (context) => ButtonFormBehaviourProviderImpl(
                      isEnabled: false
                    ),
                    builder: (context, child) => StudentForm(
                      student: student,
                    ),
                  );
                }
                return const StudentForm();
              },
            ), 
            transitionsBuilder: (context, animation, secondaryAnimation, child) => 
            TransitionUtil.transition.slideUp(
              child: child, 
              inAnim: animation, 
              outAnim: secondaryAnimation, 
              context: context
            ),
            transitionDuration: const Duration(milliseconds: 500)
          ),
          redirect: (context, state){
            return checkUnauthorizedUser(context);
          },
        ),
      ],
      pageBuilder: (context, state, child) => 
      CustomTransitionPage(
        child: child, 
        transitionsBuilder: (context, animation, secondaryAnimation, child) => 
        TransitionUtil.transition.fading(
          child: ChangeNotifierProvider<StudentProvider>(
            create: (context) => StudentProviderImpl(),
            child: child,
          ), 
          inAnim: animation, 
          outAnim: secondaryAnimation, 
          context: context
        ),
      ),
    ),

    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: ConstantCollection.repository.routers.location.splash,
      name: ConstantCollection.repository.routers.name.splash,
      builder:(context, state) => const Splash(),
    ),

    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: ConstantCollection.repository.routers.location.login,
      name: ConstantCollection.repository.routers.name.login,
      pageBuilder: (context, state) => 
      CustomTransitionPage(
        child: const Login(), 
        transitionsBuilder: (context, animation, secondaryAnimation, child) => 
          TransitionUtil.transition.fading(
            child: child, 
            inAnim: animation, 
            outAnim: secondaryAnimation, 
            context: context),
        transitionDuration: const Duration(milliseconds: 500)
      ),
      redirect: (context, state) {
        return checkAuthorizedUser(context);
      },
    ),

    GoRoute(
      path: "${ConstantCollection.repository.routers.location.dialog}/:param",
      name: ConstantCollection.repository.routers.name.dialog,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        String? param = state.pathParameters['param'];
        late WidgetBuilder child;
        switch (param) {
          case "loading":
            child = (context){
              LoadingExecutor executor = state.extra as LoadingExecutor;
              executor.execute?.call();
              return const Loading(
                color: Color.fromARGB(255, 204, 110, 200),
              );
            };
            break;
          default: child = (context) => Container();
        }
        return LoadingPage(
          context: context, 
          builder: child
        );
      },
    )
  ],
  debugLogDiagnostics: true
);

String? checkUnauthorizedUser(BuildContext context){
  UserProvider user = context.read<UserProvider>();
  if(user.user == null){
    return ConstantCollection.repository.routers.location.login;
  }
  return null;
}
String? checkAuthorizedUser(BuildContext context){
  UserProvider user = context.read<UserProvider>();
  if(user.user != null){
    return ConstantCollection.repository.routers.location.listStudent;
  }
  return null;
}
