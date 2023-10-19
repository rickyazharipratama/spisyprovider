import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:spisyprovider/factory/Utils/enum_collections.dart';
import 'package:spisyprovider/factory/implementor/views/pages/landing_presenter_impl.dart';
import 'package:spisyprovider/factory/provider/landing_page_provider.dart';
import 'package:spisyprovider/factory/provider/list_card_provider.dart';
import 'package:spisyprovider/factory/provider/student_provider.dart';
import 'package:spisyprovider/views/Page/landing/landing_presenter.dart';
import 'package:spisyprovider/views/components/buttons/appbar_button.dart';
import 'package:spisyprovider/warehouse/constant_collection.dart';

class Landing extends StatelessWidget {

  final Widget? child;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Landing({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    final LandingPresenter presenter = LandingPresenterImpl(
      provider: context.read<LandingPageProvider>(),
      context: context
    );  
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        key: key,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: const Color.fromARGB(255, 239, 239, 239),
        centerTitle: true,
        title: Hero(
          tag: 0,
          child: Image.asset(
            "assets/images/spisyLogo.png",
            width: (50 * 16) / 9,
            alignment: Alignment.topCenter,
            height: 40,
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          AppBarButton(
            onTap: () async{
              await context.push(
                ConstantCollection.repository.routers.location.form)
              .then((value){
                print("back from form student with state = $value");
                if(value != null){
                  if(value  ==  StudentEventResult.studentInserted){
                      ListCardProvider lp = context.read<ListCardProvider>();
                      StudentProvider sp = context.read<StudentProvider>();
                      int length = 0;
                      if(sp.students.isNotEmpty){
                        length = sp.students.length;
                      }
                      lp.silentActivePage(length);
                  }else if(value == StudentEventResult.studentUpdated){
                    
                  }
                  context.read<StudentProvider>().setState(state: StudentEventResult.studentPrepareToFetch);
                }
              }); 
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: child,
      bottomNavigationBar: Selector<LandingPageProvider,int>(
        selector: (context, provider) => provider.active,
        builder: (context, value, child) => BottomNavigationBar(
          elevation: 2,
          backgroundColor:const Color.fromARGB(255, 240, 99, 179),
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color.fromARGB(255, 131, 50, 127),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
              ),
              label: "Home"
            ),
            BottomNavigationBarItem(
              icon : Icon(
                Icons.logout_rounded
              ),
              label: "Logout"
            ),
          ],
          onTap: presenter.onBottomNavigationTapped,
          currentIndex: presenter.currentProvider.active
        )
      )
    );
  }
}