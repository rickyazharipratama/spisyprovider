
import 'package:spisyprovider/factory/provider/landing_page_provider.dart';
import 'package:spisyprovider/factory/provider/list_card_provider.dart';
import 'package:spisyprovider/factory/provider/student_provider.dart';

abstract class ListStudentPresenter{
  
  StudentProvider get currentStudentProvider;
  LandingPageProvider get currentLandingPageProvider;
  ListCardProvider get currentListCardProvider;
}
