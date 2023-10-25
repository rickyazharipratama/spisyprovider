import 'package:spisyprovider/factory/provider/landing_page_provider.dart';
import 'package:spisyprovider/factory/raw_material/widget_context.dart';

abstract class LandingPresenter extends WidgetContext{

  LandingPageProvider get currentProvider;
  void onBottomNavigationTapped(int index);
}