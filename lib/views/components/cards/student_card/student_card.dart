import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pratama_form_field_factory/buttons/pratama_icon_buttons.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spisyprovider/factory/Utils/enum_collections.dart';
import 'package:spisyprovider/factory/Utils/format_util.dart';
import 'package:spisyprovider/factory/Utils/log_util.dart';
import 'package:spisyprovider/factory/implementor/providers/detail_student_provider_impl.dart';
import 'package:spisyprovider/factory/implementor/views/components/cards/student_card_presenter_impl.dart';
import 'package:spisyprovider/factory/provider/detail_student_provider.dart';
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
    final ListCardProvider provider = context.watch<ListCardProvider>();
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
          LogUtil.log.write("build list card with id : ${student.id} and active page = $value");
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
            child: ChangeNotifierProvider<DetailStudentProvider>(
              create: (context) => DetailStudentProviderImpl(
                student: student
              ),builder: (context, child){
                presenter.currentStudentProvider = context.read<DetailStudentProvider>();
                LogUtil.log.write("build student with id : ${presenter.currentStudentProvider.currentStudent.id}");
                return studentCard(context, provider,presenter,pageWidth, pageHeight);
              },
            )
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
                 StudentModel? updatedStudent =  await context.push(ConstantCollection.repository.routers.location.form,
                  extra: student
                );
                if(updatedStudent != null){
                  //StudentModel updatedStudent = StudentModel.fromJson(jsonUpdated as Map<String,dynamic>);
                  presenter.currentStudentProvider.preUpdateStudent(updatedStudent: updatedStudent);
                  Future.delayed(const Duration(milliseconds: 3000),(){})
                    .whenComplete(()  async=>  await presenter.currentStudentProvider.updatingStudent(
                      updatedStudent: updatedStudent
                    ));
                }
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
                  padding: EdgeInsets.fromLTRB((pageWidth * 0.35), 10, 5, 10),
                  width: pageWidth,
                  height: 40,
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
                  child: Selector<DetailStudentProvider,String?>(
                    selector: (context,provider) => provider.currentStudent.name,
                    builder: (context, value, child){
                      LogUtil.log.write("building name with id ${student.id} with value = $value");
                      if(presenter.currentStudentProvider.currentState == DetailStudentEvent.studentPreparing && value == null){
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 215, 212, 212),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Shimmer.fromColors(
                            baseColor: const Color.fromARGB(255, 244, 244, 244), 
                            highlightColor: const Color.fromARGB(255, 251, 251, 251),
                            child: SizedBox(
                              width: pageWidth * 0.25,
                              height: 7,
                            )
                          ),
                        ); 
                      }
                      return Text(
                        value!,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.white
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  )
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(((pageWidth * 0.28)), 5, 10, 10),
                  width: pageWidth * 0.8,
                  child: Selector<DetailStudentProvider, int?>(
                    selector: (context, provider) => provider.currentStudent.age,
                    builder: (context, value, child){
                      int? newAge = value;
                      return Selector<DetailStudentProvider, bool?>(
                        selector: (context,provider) => provider.currentStudent.gender,
                        builder: (context, value, child) {
                          if(presenter.currentStudentProvider.currentState == DetailStudentEvent.studentPreparing && value == null){
                            return Container(
                              height: 10,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 215, 212, 212),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Shimmer.fromColors(
                                direction: ShimmerDirection.ltr,
                                baseColor: const Color.fromARGB(255, 220, 220, 220), 
                                highlightColor: Colors.white,
                                enabled: true,
                                child: SizedBox(
                                   width: pageWidth * 0.8,
                                  height: 8,
                                )
                              ),
                            );
                          }
                          return Text(
                            "${value! ? "Pria" : "Wanita"}, $newAge Tahun",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 129, 128, 128)
                            ),
                          );
                        },
                      );
                    },
                  )
                )  
              ],
            )
          ),

          Positioned(
            top: 38,
            left: 15,
            child: Container(
              width: pageWidth * 0.25,
              height: (pageWidth * 0.8)/3,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 222, 220, 220),
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Selector<DetailStudentProvider, bool?>(
                selector: (context, provider) => provider.currentStudent.gender,
                builder: (context, value, child) {
                  if(presenter.currentStudentProvider.currentState == DetailStudentEvent.studentPreparing && value == null){
                    return Shimmer.fromColors(
                      baseColor: const Color.fromARGB(255, 244, 244, 244), 
                      highlightColor: const Color.fromARGB(255, 251, 251, 251),
                      child: SizedBox(
                        width:  pageWidth * 0.3,
                        height: (pageWidth * 1.1)/3,
                      )
                    );
                  }
                  return Center(
                    child: Icon(
                      value! ? Icons.account_circle_rounded : Icons.account_circle_outlined,
                      size: pageWidth * 0.3 * 0.75,
                      color: const Color.fromARGB(255, 133, 131, 131),
                    ),
                  );
                },
              )
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

                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     top: 10,
                  //   ),
                  //   child: Row(
                  //     children: [

                  //       Selector<DetailStudentProvider,bool?>(
                  //         selector: (context, provider) => provider.currentStudent.gender,
                  //         builder: (context, value, child){
                  //           if(presenter.currentStudentProvider.currentState == DetailStudentEvent.studentPreparing && value == null){
                  //             return Container(
                  //               color: const Color.fromARGB(255, 215, 212, 212),
                  //               child: Shimmer.fromColors(
                  //                 baseColor: const Color.fromARGB(255, 244, 244, 244), 
                  //                 highlightColor: const Color.fromARGB(255, 251, 251, 251),
                  //                 child: const SizedBox(
                  //                   width: 30,
                  //                   height: 30,
                  //                 ),
                  //               ),
                  //             );
                  //           }
                  //           return Icon(
                  //             value! ? Icons.account_circle_rounded : Icons.account_circle_outlined,
                  //             size: 30,
                  //             color: const Color.fromARGB(255, 210, 208, 208),
                  //           );
                  //         },
                  //       ),
                        
                  //       Expanded(
                  //         child: 
                  //       )
                  //     ],
                  //   ),
                  // ),

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
                            child: Selector<DetailStudentProvider,DateTime?>(
                              selector: (context,provider) => provider.currentStudent.birth,
                              builder: (context, value, child) {
                                LogUtil.log.write("build birth with id: ${student.id} with value ${value?.toIso8601String()}");
                                if(presenter.currentStudentProvider.currentState == DetailStudentEvent.studentPreparing && value == null){

                                  return Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 215, 212, 212),
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Shimmer.fromColors(
                                      baseColor: const Color.fromARGB(255, 244, 244, 244), 
                                      highlightColor: const Color.fromARGB(255, 251, 251, 251),
                                      child: SizedBox(
                                        width: pageWidth * 0.25,
                                        height: 7,
                                      )
                                    ),
                                  ); 

                                }
                                return Text(
                                  FormatUtil.collection.formattedDate(student.birth!)!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    color:  Color.fromARGB(255, 157, 155, 155)
                                  ),
                                );
                              },
                            )
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
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 30,
                          color: Color.fromARGB(255, 210, 208, 208),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Selector<DetailStudentProvider,String?>(
                              selector: (_,__) => __.currentStudent.address,
                              builder: (context, value, child) {
                                LogUtil.log.write("build address with id : ${student.id} with value ; $value");
                                if(presenter.currentStudentProvider.currentState == DetailStudentEvent.studentPreparing && value == null){
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Shimmer.fromColors(
                                          baseColor: const Color.fromARGB(255, 244, 244, 244), 
                                          highlightColor: const Color.fromARGB(255, 251, 251, 251),
                                          child: SizedBox(
                                            width: pageWidth * 0.05,
                                            height: 7,
                                          )
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 13),
                                          child: Shimmer.fromColors(
                                            baseColor: const Color.fromARGB(255, 244, 244, 244), 
                                            highlightColor: const Color.fromARGB(255, 251, 251, 251),
                                            child: SizedBox(
                                              width: pageWidth * 0.2,
                                              height: 7,
                                            )
                                          ),
                                        ),
                                        
                                        Padding(
                                          padding: const EdgeInsets.only(top:13),
                                          child: Shimmer.fromColors(
                                            baseColor: const Color.fromARGB(255, 244, 244, 244), 
                                            highlightColor: const Color.fromARGB(255, 251, 251, 251),
                                            child: SizedBox(
                                              width: pageWidth * 0.1,
                                              height: 7,
                                            )
                                          ),
                                        ),
                                      ],
                                    )
                                  ); 
                                }
                                return Text(
                                  student.address.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    color:  Color.fromARGB(255, 157, 155, 155)
                                  ),
                                );
                              },
                            )
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