import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pratama_form_field_factory/Utils/pratama_Constants.dart';
import 'package:pratama_form_field_factory/builders/form_builder/pratama_form_builder_model.dart';
import 'package:pratama_form_field_factory/builders/form_builder/pratama_form_custom_field.dart';
import 'package:pratama_form_field_factory/buttons/pratama_icon_buttons.dart';
import 'package:pratama_form_field_factory/buttons/pratama_primary_button.dart';
import 'package:pratama_form_field_factory/pratama_form_field_factory.dart';
import 'package:provider/provider.dart';
import 'package:spisyprovider/factory/implementor/views/pages/form_presenter_impl.dart';
import 'package:spisyprovider/factory/provider/student_provider.dart';
import 'package:spisyprovider/views/Page/form/form_presenter.dart';
import 'package:spisyprovider/views/views/Loading.dart';
import 'package:spisyprovider/warehouse/models/student_model.dart';

class StudentForm extends StatelessWidget {
  final StudentModel? student;
  const StudentForm({
    super.key,
    this. student
  });

  @override
  Widget build(BuildContext context) {
    final FormPresenter presenter = FormPresenterImpl(
      provider: context.read<StudentProvider>(), 
      existingStudent: student
    );
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    print("build form");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 204, 110, 200),
        elevation: 2,
        centerTitle: false,
        actions: [
          PratamaIconButton(
            icon: Icons.close,
            onTap: (){
              context.pop();
            },
            color: Colors.white,
          )
        ],
        title: const Text(
          "Student"
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: PratamaFormBuilder(
            formKey: formKey,
            fields: [
              PratamaFormBuilderModel(
                field: PratamaFormField.textField,
                presenter: presenter.nameTextPresenter
              ),
              
              PratamaFormBuilderModel(
                field: PratamaFormField.dateTIemPicker,
                presenter: presenter.birthPresenter
              ),
              
              PratamaFormBuilderModel(
                field: PratamaFormField.textField,
                presenter: presenter.umurPresenter
              ),

              PratamaFormBuilderModel(
                field: PratamaFormField.radio,
                presenter: presenter.genderPresenter
              ),

              PratamaFormBuilderModel(
                field: PratamaFormField.textField,
                presenter: presenter.alamatTextPresenter
              )
            ],
            customField: [
              
              PratamaFormCustomField(
                topOf: 5, 
                field: Padding(
                  padding: const EdgeInsets.fromLTRB(10,30.0,10,10),
                  child: PratamaPrimaryButton(
                    onTap: () async{
                      bool isAlreadyExecute = false;
                      bool radioValidate = presenter.genderPresenter.validate();
                      if(formKey.currentState!.validate()&& radioValidate){
                        print("initiating execute");
                        // LoadingExecutor le = LoadingExecutor()..execute =() async{

                        //   if(presenter.existingStudent!.id == null){
                        //     presenter.onInsertStudent();
                        //   }else{
                        //     presenter.onUpdateStudent();
                        //   }
                        //   //Navigator.of(context).pop(presenter.provider.state);
                          
                        //   Future.delayed(const Duration(milliseconds: 1500),(){})
                        //   .whenComplete(() => context.pop(presenter.provider.state));
                        // };
                        // context.push(
                        //   "${ConstantCollection.repository.routers.location.dialog}/${ConstantCollection.repository.routers.params.loading}",
                        //   extra: le
                        // )
                        // .then((value){
                        //   print("pop from execute");
                        //   //Navigator.of(context).pop(presenter.provider.state);
                        //   //context.pop(value);
                        // });
                        await showDialog(
                          context: context,
                          barrierDismissible: false,
                            builder: (context){
                            Future.delayed(const Duration(milliseconds: 800),() async{
                              if(!isAlreadyExecute){
                                if(presenter.existingStudent!.id == null){
                                  await presenter.onInsertStudent();
                                }else{
                                  await presenter.onUpdateStudent();
                                }
                              }
                            }).whenComplete(() {
                              if(!isAlreadyExecute){
                                isAlreadyExecute = true;
                                Navigator.of(context).pop();
                                context.pop(presenter.provider.state);
                              }
                            });
                            return const Loading(
                              color:  Color.fromARGB(255, 204, 110, 200),
                            );
                          }
                        );
                      }
                    },
                    text: presenter.existingStudent!.id == null ? "Simpan" : "Perbaharui",
                  ),
                )
              )

            ],
          )
    );
  }
}