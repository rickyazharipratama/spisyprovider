import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spisyprovider/factory/Utils/enum_collections.dart';
import 'package:spisyprovider/factory/implementor/views/fragments/list_student_presenter_impl.dart';
import 'package:spisyprovider/factory/provider/landing_page_provider.dart';
import 'package:spisyprovider/factory/provider/list_card_provider.dart';
import 'package:spisyprovider/factory/provider/student_provider.dart';
import 'package:spisyprovider/views/components/cards/student_card/student_card.dart';
import 'package:spisyprovider/views/views/fragments/llist_student/list_student_empty.dart';
import 'package:spisyprovider/views/views/fragments/llist_student/list_student_prepare.dart';
import 'package:spisyprovider/views/views/fragments/llist_student/list_student_presenter.dart';
import 'package:spisyprovider/warehouse/models/student_model.dart';

class ListStudent extends StatelessWidget {
  
  const ListStudent({super.key});



  @override
  Widget build(BuildContext context) {
    final ListStudentPresenter presenter = ListStudentPresenterImpl(
      provider: context.read<StudentProvider>(),
      pageProvider: context.read<LandingPageProvider>(),
      cardProvider: context.read<ListCardProvider>()
    );
    return Selector<StudentProvider, StudentEventResult>(
      selector: (context,provider) => provider.state,
      builder: (context, value, child){
        if(presenter.currentStudentProvider.state == StudentEventResult.studentPrepareToFetch
        || presenter.currentStudentProvider.state == StudentEventResult.studentDeleted){
          Future.delayed(Duration(milliseconds: presenter.currentStudentProvider.state == StudentEventResult.studentPrepareToFetch ? 3000 : 700),(){
            presenter.currentStudentProvider.fetchStudent();
          });
          return const ListStudentPrepare();
        }else{
          if(presenter.currentStudentProvider.students.isNotEmpty){
            return PageView.builder(
              itemCount: presenter.currentStudentProvider.students.length,
              controller: PageController(
                initialPage: presenter.currentListCardProvider.activePage,
                viewportFraction: 0.7,
              ),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()
              ),
              onPageChanged: (index){
                presenter.currentListCardProvider.setActivePage(index);
              },
              itemBuilder: (context, index) { 
                print("reabuild widget in list card" + index.toString());
                return Center(
                  child: StudentCard(
                    student: presenter.currentStudentProvider.students[index],
                    index: index,
                  ),
                );
              }
            );
          }
        }
        return const ListStudentEmpty();
       },
    );
  }
}