
import 'package:spisyprovider/factory/provider/landing_page_provider.dart';
import 'package:spisyprovider/factory/provider/list_card_provider.dart';
import 'package:spisyprovider/factory/raw_material/student_material.dart';

abstract class ListStudentPresenter extends StudentMaterial{
  
  LandingPageProvider get currentLandingPageProvider;
  ListCardProvider get currentListCardProvider;
}
