import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pratama_form_field_factory/Utils/pratama_Constants.dart';
import 'package:pratama_form_field_factory/builders/form_builder/pratama_form_builder_model.dart';
import 'package:pratama_form_field_factory/buttons/pratama_primary_button.dart';
import 'package:pratama_form_field_factory/pratama_form_field_factory.dart';
import 'package:pratama_form_field_factory/text_field/pratama_text_field_presenter.dart';
import 'package:provider/provider.dart';
import 'package:spisyprovider/factory/Utils/enum_collections.dart';
import 'package:spisyprovider/factory/Utils/log_util.dart';
import 'package:spisyprovider/factory/implementor/views/pages/login_presenter_impl.dart';
import 'package:spisyprovider/factory/provider/user_provider.dart';
import 'package:spisyprovider/views/Page/login/login_presenter.dart';
import 'package:spisyprovider/views/views/Loading.dart';
import 'package:spisyprovider/warehouse/constant_collection.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginPresenter presenter = LoginPresenterImpl(
      provider: context.read<UserProvider>(),
      context: context
    );
    LogUtil.log.write("building login");
    return Scaffold(
      body: PratamaFormBuilder(
        presenter: presenter.currentFormBuilderPresenter,
        fields: [
          PratamaFormBuilderModel<PratamaTextFieldPresenter>(
            field: PratamaFormField.textField,
            presenter: presenter.currentUsernameTextPresenter

          ),
          PratamaFormBuilderModel<PratamaTextFieldPresenter>(
            field: PratamaFormField.textField,
            presenter: presenter.currentPasswordTextPresenter
          )
        ],
        customLayout: (context, child) => Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 240, 99, 179),
                      Color.fromARGB(255, 247, 170, 244),
                      Color.fromARGB(255, 251, 209, 249)
                    ],
                    stops: [
                      0.05,
                      0.2,
                      0.4
                    ]
                  )
                ),
              )
            ),

            Positioned.fill(
              child: SingleChildScrollView(
                child: SizedBox(
                  width:  MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [

                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Center(
                          child: Hero(
                            tag: 0,
                            child: Image.asset(
                              "assets/images/spisyLogo.png",
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(25, 30, 25, 20),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25)
                            )                         
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 67, 66, 67),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      child,
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.only(
                                          top: 10
                                        ),
                                        child: const Text(
                                          "Lupa Password ?",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 33, 86, 178),
                                            fontSize: 14
                                          ),
                                        ),
                                      ),
                                      Selector<UserProvider,LoginState>(
                                        builder: (context,state,_){
                                          if(state == LoginState.loginfailed){
                                            return Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 10,
                                                  left: 20,
                                                  right: 20
                                                ),
                                                child: Text(
                                                  ConstantCollection.repository.errors.loginFailed,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Theme.of(context).colorScheme.error
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          return Container();
                                        },
                                        selector: (p0, p1) => p1.loginState,
                                      ),
                                    ],
                                  ),
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10 + MediaQuery.of(context).padding.bottom),
                                child: PratamaPrimaryButton(
                                  text: "Masuk",
                                  onTap: () async{
                                    late LoginState ls;
                                    bool isAlreadyExecute = false;
                                    if(presenter.currentFormBuilderPresenter.validateForm()){
                                      await showDialog(
                                        context: context, 
                                        barrierDismissible: false,
                                        builder: (context){
                                            Future.delayed(const Duration(milliseconds: 700),(){}).whenComplete((){
                                              if(!isAlreadyExecute){
                                                presenter.authenticatiog().then((value){
                                                  ls = value;
                                                  Navigator.of(context).pop();
                                                })
                                                .whenComplete((){
                                                  if(ls == LoginState.loginSuccess){
                                                    context.go(ConstantCollection.repository.routers.location.listStudent);
                                                  }
                                                });
                                                isAlreadyExecute = true;
                                              }
                                            });
                                          return const Loading(
                                            color: Color.fromARGB(255, 204, 110, 200),
                                          );
                                        }
                                      );
                                    }
                                  }
                                ),
                              ),
                            ],
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              )
            ),
          ],
        ),
      ),
      // body: SingleChildScrollView(
      //   child: Container(
      //     width: MediaQuery.of(context).size.width,
      //     height: MediaQuery.of(context).size.height,
      //     padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
      //     child: Column(
      //       children: [
      //         SizedBox(
      //           width: MediaQuery.of(context).size.width,
      //           child: const Text(
      //             "Login",
      //             style: TextStyle(
      //               fontSize: 40,
      //               fontWeight: FontWeight.w400,
      //               color: Color.fromARGB(255, 67, 66, 67),
      //             ),
      //             textAlign: TextAlign.left,
      //           ),
      //         ),
              
      //         PratamaTextField(
      //           presenter: presenter.currentUsernameTextPresenter,
      //           padding: const EdgeInsets.fromLTRB(25,15,25,0),
      //         ),
      //         PratamaTextField(
      //           presenter: presenter.currentPasswordTextPresenter,
      //           padding: const EdgeInsets.fromLTRB(25,15,25,0),
      //         ),
      //         Container(
      //           width: MediaQuery.of(context).size.width,
      //           padding: const EdgeInsets.only(
      //             top: 10,
      //             right: 20
      //           ),
      //           child: const Text(
      //             "Lupa Password ?",
      //             textAlign: TextAlign.right,
      //             style: TextStyle(
      //               color: Color.fromARGB(255, 33, 86, 178),
      //               fontSize: 14
      //             ),
      //           ),
      //         ),
              
      //         Selector<UserProvider,LoginState>(
      //           builder: (context,state,_){
      //             if(state == LoginState.loginfailed){
      //               return Center(
      //                 child: Padding(
      //                   padding: const EdgeInsets.only(
      //                     top: 10,
      //                     left: 20,
      //                     right: 20
      //                   ),
      //                   child: Text(
      //                     ConstantCollection.repository.errors.loginFailed,
      //                     textAlign: TextAlign.center,
      //                     style: TextStyle(
      //                       color: Theme.of(context).colorScheme.error
      //                     ),
      //                   ),
      //                 ),
      //               );
      //             }
      //             return Container();
      //           },
      //           selector: (p0, p1) => p1.loginState,
      //         ),
      //         Padding(
      //           padding: EdgeInsets.fromLTRB(20, 10, 20, 20 + MediaQuery.of(context).padding.bottom),
      //           child: PratamaPrimaryButton(
      //             text: "Masuk",
      //             onTap: () async{
      //               late LoginState ls;
      //               bool isAlreadyExecute = false;
      //               // if(formKey.currentState!.validate()){
      //                 await showDialog(
      //                   context: context, 
      //                   barrierDismissible: false,
      //                   builder: (context){
      //                     Future.delayed(const Duration(milliseconds: 700),(){}).whenComplete((){
      //                       if(!isAlreadyExecute){
      //                         presenter.authenticatiog().then((value){
      //                           ls = value;
      //                           Navigator.of(context).pop();
      //                         })
      //                         .whenComplete((){
      //                           if(ls == LoginState.loginSuccess){
      //                             context.go(ConstantCollection.repository.routers.location.listStudent);
      //                           }
      //                         });
      //                         isAlreadyExecute = true;
      //                       }
                            
      //                     });
      //                     return const Loading(
      //                       color: Color.fromARGB(255, 204, 110, 200),
      //                     );
      //                   });
      //                 // }
      //               }
      //             ),
      //           ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}