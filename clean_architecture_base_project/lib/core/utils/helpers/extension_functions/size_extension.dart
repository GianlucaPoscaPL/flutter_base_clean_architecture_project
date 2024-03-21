import 'package:clean_architecture_base_project/core/di/app_component/app_component.dart';
import 'package:clean_architecture_base_project/core/utils/helpers/responsive_ui_helper/responsive_config.dart';

extension ExtensionsOnNum on num {
  static final ResponsiveUiConfig _responsiveUiConfig = locator<ResponsiveUiConfig>();

  double get w => _responsiveUiConfig.setWidth(this);

  double get h => _responsiveUiConfig.setHeight(this);
}
