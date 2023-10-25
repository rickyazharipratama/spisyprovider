import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spisyprovider/factory/Utils/enum_collections.dart';
import 'package:spisyprovider/factory/Utils/log_util.dart';
import 'package:spisyprovider/factory/implementor/views/pages/splash_presenter_impl.dart';
import 'package:spisyprovider/factory/provider/user_provider.dart';
import 'package:spisyprovider/views/Page/splash/splash_presenter.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});



  @override
  Widget build(BuildContext context) {

    final SplashPresenter presenter = SplashPresenterImpl(
      provider: context.read<UserProvider>()
    );
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 170, 244),
      body: Stack(
        children: [

          Positioned.fill(
            child: Builder(
              builder: (context) {
                LogUtil.log.write("build wrapper immage");
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Hero(
                      tag: 0,
                      child: Image.asset(
                        "assets/images/spisyLogo.png",
                        width: 120,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              }
            )
          ),

          Positioned(
            bottom: 30 + MediaQuery.of(context).padding.bottom,
            left: 0,
            right: 0,
            child: Center(
              child: Builder(
                builder: (context) {
                  LogUtil.log.write("build wrapper loading");
                  return SizedBox(
                    width: 20,
                    height: 20,
                    child: Selector<UserProvider,UserAuthenticationState>(
                      selector: (context,provider)=> provider.state,
                      builder: (context, value, child){
                        LogUtil.log.write("build outer loading");
                        if(value == UserAuthenticationState.userValidating){
                          LogUtil.log.write("build innerloading");
                          presenter.retrievingUser(context);
                          
                          return const CircularProgressIndicator(
                            color: Colors.white70,
                            strokeWidth: 3,
                          );
                        }else if(value == UserAuthenticationState.userPreparing){
                          presenter.validatingUser();
                        }
                        return Container();
                      },
                    )
                  );
                }
              ),
            )
          ),
        ],
      ), 
    );
  }
}
