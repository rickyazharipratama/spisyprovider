import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spisyprovider/factory/Utils/enum_collections.dart';
import 'package:spisyprovider/factory/Utils/log_util.dart';
import 'package:spisyprovider/factory/implementor/views/fragments/list_student_presenter_impl.dart';
import 'package:spisyprovider/factory/provider/landing_page_provider.dart';
import 'package:spisyprovider/factory/provider/list_card_provider.dart';
import 'package:spisyprovider/factory/provider/student_provider.dart';
import 'package:spisyprovider/views/components/cards/student_card/student_card.dart';
import 'package:spisyprovider/views/views/fragments/llist_student/list_student_empty.dart';
import 'package:spisyprovider/views/views/fragments/llist_student/list_student_prepare.dart';
import 'package:spisyprovider/views/views/fragments/llist_student/list_student_presenter.dart';

class ListStudent extends StatelessWidget {
  
  const ListStudent({super.key});



  @override
  Widget build(BuildContext context) {
    final ListStudentPresenter presenter = ListStudentPresenterImpl(
      studentProvider: context.read<StudentProvider>(),
      pageProvider: context.read<LandingPageProvider>(),
      cardProvider: context.read<ListCardProvider>()
    );
    return Selector<StudentProvider, StudentEventResult>(
      selector: (context,provider) => provider.state,
      builder: (context, value, child){
        LogUtil.log.write("build student list with event = $value");
        if(presenter.provider.state == StudentEventResult.studentPrepareToFetch
        || presenter.provider.state == StudentEventResult.studentDeleted){
          Future.delayed(Duration(milliseconds: presenter.provider.state == StudentEventResult.studentPrepareToFetch ? 3000 : 700),(){
            presenter.provider.fetchStudent();
          });
          return const ListStudentPrepare();
        }else{
          if(presenter.provider.students.isNotEmpty){
            return PageView.builder(
              itemCount: presenter.provider.students.length,
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
                LogUtil.log.write("reabuild widget in list card $index");
                return Center(
                  child: StudentCard(
                    student: presenter.provider.students[index],
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