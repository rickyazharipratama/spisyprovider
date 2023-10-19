import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pratama_form_field_factory/buttons/pratama_icon_buttons.dart';
import 'package:provider/provider.dart';
import 'package:spisyprovider/factory/Utils/enum_collections.dart';
import 'package:spisyprovider/factory/Utils/format_util.dart';
import 'package:spisyprovider/factory/implementor/views/components/cards/student_card_presenter_impl.dart';
import 'package:spisyprovider/factory/provider/list_card_provider.dart';
import 'package:spisyprovider/factory/provider/student_provider.dart';
import 'package:spisyprovider/views/components/cards/student_card/student_card_presenter.dart';
import 'package:spisyprovider/views/views/Loading.dart';
import 'package:spisyprovider/warehouse/constant_collection.dart';
import 'package:spisyprovider/warehouse/models/student_model.dart';

class StudentCard extends StatelessWidget {
  final StudentModel student;
  final int index;
  const StudentCard({
    super.key,
    required this.index,
    required this.student
  });

  @override
  Widget build(BuildContext context) {
    final ListCardProvider provider = context.read<ListCardProvider>();
    double pageWidth = MediaQuery.of(context).size.width * 0.75;
    double pageHeight = pageWidth * 13 / 9;
    final StudentCardPresenter presenter  = StudentCardPresenterImpl(
      provider: context.read<StudentProvider>()
    );
    return SizedBox(
      width: pageWidth,
      height: pageHeight,
      child: Selector<ListCardProvider, int>(
        selector: (context,provider) => provider.activePage,
        builder: (context, value, child){
          double scale = provider.activePage == index ? 1 : 0.8;
          return TweenAnimationBuilder(
            tween: Tween(begin: scale, end: scale), 
            duration: const Duration(milliseconds: 200),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: child,
              );
            },
            child: studentCard(context, provider,presenter,pageWidth, pageHeight)
          );
        }
      ),
    );
  }


  Widget studentCard(
    BuildContext context, 
    ListCardProvider provider,
    StudentCardPresenter presenter,
    double pageWidth,
    double pageHeight){
    return  Container(
      margin: EdgeInsets.symmetric(
        horizontal: provider.activePage == index ? 0: 0,
        vertical: 10
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 253, 253, 253),
        boxShadow: const [
          BoxShadow(
            blurStyle: BlurStyle.inner,
            blurRadius: 0.2,
            spreadRadius: 1,
            color: Color.fromARGB(255, 207, 207, 207)
          )
        ]
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child:  PratamaIconButton(
              icon: Icons.edit,
              color: const Color.fromARGB(255, 104, 104, 104),
              onTap: () async{
                await context.push(ConstantCollection.repository.routers.location.form,
                  extra: student
                ).then((value) {
                  if(value == StudentEventResult.studentUpdated){
                    presenter.provider.setState(state: StudentEventResult.studentPrepareToFetch);
                  }
                });
              },
              size: 25,
              areaSize: 40,
            ),
          ),

          Positioned(
            top:  5 + (((pageWidth * 1.1)/3) / 2),
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 15, 5, 15),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 240, 99, 179),
                        Color.fromARGB(255, 247, 170, 244),
                      ],
                      stops: [
                        0.35,
                        0.85
                      ]
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(((pageWidth * 0.3)), 5, 10, 10),
                  child: Text(
                   "${student.gender! ? "Pria" : "Wanita"}, ${student.age} Tahun",
                   textAlign: TextAlign.left,
                   style: const TextStyle(
                    color: Color.fromARGB(255, 129, 128, 128)
                   ),
                  ),
                )  
              ],
            )
          ),

          Positioned(
            top: 15,
            left: 20,
            child: Container(
              width: pageWidth * 0.3,
              height: (pageWidth * 1.1)/3,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 210, 208, 208),
                borderRadius: BorderRadius.all(Radius.circular(3))
              ),
              child: Center(
                child: Icon(
                  student.gender! ? Icons.account_circle_rounded : Icons.account_circle_outlined,
                  size: pageWidth * 0.3 * 0.75,
                  color: const Color.fromARGB(255, 133, 131, 131),
                ),
              ),
            )
          ),

          Positioned(
            left: 10,
            right: 10,
            bottom: 0,
            top: 15+((pageWidth * 1.1)/3),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          student.gender! ? Icons.account_circle_rounded : Icons.account_circle_outlined,
                          size: 30,
                          color: const Color.fromARGB(255, 210, 208, 208),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              student.name.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color:  Color.fromARGB(255, 157, 155, 155)
                              ),
                            ),
                          )
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.date_range,
                          size: 30,
                          color: Color.fromARGB(255, 210, 208, 208),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              FormatUtil.collection.formattedDate(student.birth!)!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color:  Color.fromARGB(255, 157, 155, 155)
                              ),
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 30,
                          color: Color.fromARGB(255, 210, 208, 208),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              student.address.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color:  Color.fromARGB(255, 157, 155, 155)
                              ),
                            ),
                          )
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Center(
              child: InkWell(
                onTap: () async{

                  await showDialog(
                    context: context, 
                    barrierDismissible: false,
                    builder: (context) {
                      Future.delayed(const Duration(milliseconds: 1000),(){})
                        .then((value){
                           presenter.onDeleteCard(student.id!);
                        })
                        .whenComplete(() => context.pop());
                      
                      return const Loading(
                        color:  Color.fromARGB(255, 240, 99, 179),
                      );
                    }
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color:  Color.fromARGB(255, 225, 67, 56),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.close,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}