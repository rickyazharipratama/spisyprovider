import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pratama_form_field_factory/Utils/pratama_Constants.dart';
import 'package:pratama_form_field_factory/builders/form_builder/pratama_form_builder_model.dart';
import 'package:pratama_form_field_factory/builders/form_builder/pratama_form_custom_field.dart';
import 'package:pratama_form_field_factory/buttons/pratama_primary_button.dart';
import 'package:pratama_form_field_factory/pratama_form_field_factory.dart';
import 'package:provider/provider.dart';
import 'package:spisyprovider/factory/Utils/enum_collections.dart';
import 'package:spisyprovider/factory/implementor/views/pages/login_presenter_impl.dart';
import 'package:spisyprovider/factory/provider/user_provider.dart';
import 'package:spisyprovider/views/Page/login/login_presenter.dart';
import 'package:spisyprovider/views/views/Loading.dart';
import 'package:spisyprovider/warehouse/constant_collection.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginPresenter presenter = LoginPresenterImpl(
      provider: context.read<UserProvider>(),
      context: context
    );
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Stack(
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

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.25,
            child: SizedBox(
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
            )
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.75,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20)
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30,30, 30, 0),
                      child: Column(
                        children: [

                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(
                              left: 10
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 67, 66, 67),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),

                          PratamaFormBuilder(
                            formKey: formKey,
                            fields: [
                              PratamaFormBuilderModel(
                                field: PratamaFormField.textField,
                                presenter: presenter.currentUsernameTextPresenter
                              ),
                              PratamaFormBuilderModel(
                                field: PratamaFormField.textField,
                                presenter: presenter.currentPasswordTextPresenter
                              )
                            ],
                            customField: [
                              PratamaFormCustomField(
                                topOf: 2, 
                                field: Container(
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
                                )
                              )
                            ],
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
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 20 + MediaQuery.of(context).padding.bottom),
                    child: PratamaPrimaryButton(
                      text: "Masuk",
                      onTap: () async{
                        late LoginState ls;
                        bool isAlreadyExecute = false;
                        if(formKey.currentState!.validate()){
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
                            });
                          }
                        }
                      ),
                    ),
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}