import 'package:spisyprovider/factory/provider/landing_page_provider.dart';
import 'package:spisyprovider/factory/provider/list_card_provider.dart';
import 'package:spisyprovider/factory/provider/student_provider.dart';
import 'package:spisyprovider/views/views/fragments/llist_student/list_student_presenter.dart';

class ListStudentPresenterImpl implements ListStudentPresenter{

  final StudentProvider provider;
  final LandingPageProvider pageProvider;
  final ListCardProvider cardProvider;

  ListStudentPresenterImpl({
    required this.provider,
    required this.pageProvider,
    required this.cardProvider
  }){
     // if(pageProvider.active != 0){
    //   pageProvider.active = 0;
    // }

    // if(provider.state == StudentEventResult.studentPrepareToFetch){
    //   Future.delayed(const Duration(milliseconds: 900),(){}).whenComplete(() => provider..fetchStudent());
    // }
  }
  
  @override
  LandingPageProvider get currentLandingPageProvider => pageProvider;
  
  @override
  ListCardProvider get currentListCardProvider => cardProvider;
  
  @override
  StudentProvider get currentStudentProvider => provider;
}