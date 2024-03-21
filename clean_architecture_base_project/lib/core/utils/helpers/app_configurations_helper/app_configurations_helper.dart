import 'package:clean_architecture_base_project/core/di/app_component/app_component.dart';
import 'package:clean_architecture_base_project/core/utils/helpers/app_flavor_helper/app_flavors_helper.dart';
import 'package:clean_architecture_base_project/core/utils/helpers/app_flavor_helper/environment_config.dart';
import 'package:clean_architecture_base_project/core/utils/helpers/app_theme_helper/custom_theme_data.dart';
import 'package:clean_architecture_base_project/core/utils/values/colors.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppConfigurations {
  CustomThemeData appTheme = CustomThemeData(
    buttonEnabledColor: blue3E97C8,
    buttonDisabledColor: blueD8E7F2,
    primaryColor: blue203C6F,
    validColor: green27B15F,
    secondaryColor: blueF3F6F8,
    thirdColor: blueD8E7F2,
    backgroundLightColor: white,
    backgroundGreyColor: greyE5E5EA,
    errorColor: redCF3A3A,
    loaderColor: blue203C6F,
    subTitleTextColor: black404040,
    titleTextColor: black101010,
  );

  ProductFlavor? _productFlavor;
  String? _baseUrl;

  ProductFlavor? get productFlavor => _productFlavor;

  String? get baseUrl {
    _productFlavor = EnvironmentConfig.BUILD_VARIANT.toProductFlavor();
    _baseUrl = _productFlavor?.setBaseUrl();
    return _baseUrl;
  }
}
