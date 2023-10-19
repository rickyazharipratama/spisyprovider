import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pratama_form_field_factory/buttons/pratama_primary_button.dart';
import 'package:spisyprovider/factory/implementor/views/fragments/logout_presenter_impl.dart';
import 'package:spisyprovider/views/views/Loading.dart';
import 'package:spisyprovider/views/views/fragments/logout/logout_presenter.dart';
import 'package:spisyprovider/warehouse/constant_collection.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  

  @override
  Widget build(BuildContext context) {
    LogoutPresenter presenter = LogoutPresenterImpl(context: context);
    return Stack(
      children: [

        Positioned.fill(
          child: Center(
            child: Icon(
              Icons.logout,
              color: const Color(0xFFf3f3f3),
              size: MediaQuery.of(context).size.width * 3 /4
            ),
          ),
        ),

        const Positioned.fill(
          child:  Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Padding(
                    padding:  EdgeInsets.only(
                      bottom: 50
                    ),
                    child: Text(
                      "Dengan ini saya dalam keadaan sadar untuk keluar dari halaman utama.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 95, 53, 53),
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                      ),
                    ),
                  ) ,
                ],
              )
            ),
          )
        ),

        Positioned(
          bottom: 30,
          left: 30,
          right: 30,
          child: PratamaPrimaryButton(
            text: "Keluar",
            onTap: () async{
              bool isAlreadyExecute = false;
              await showDialog(
                context: context, 
                builder: (context){
                  Future.delayed(const Duration(milliseconds: 1200),(){
                    
                  })
                  .whenComplete((){
                    if(!isAlreadyExecute){
                      presenter.onLogoutTapped()
                      .then((value){
                        Navigator.of(context).pop();
                        //context.pop();
                      })
                      .whenComplete((){
                        context.go(ConstantCollection.repository.routers.location.login);
                      }); 
                       isAlreadyExecute = true;
                    }
                  });
                  return const Loading(
                    color: Color.fromARGB(255, 240, 99, 179),
                  );
                },
              ); 
            },
          )
        )
      ],
    );
  }
}