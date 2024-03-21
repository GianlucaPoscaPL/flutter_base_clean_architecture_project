import 'package:flutter/material.dart';
import 'package:clean_architecture_base_project/core/di/app_component/app_component.dart';
import 'package:clean_architecture_base_project/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:clean_architecture_base_project/core/utils/helpers/responsive_ui_helper/responsive_config.dart';

class BaseResponsiveWidget extends StatelessWidget {
  const BaseResponsiveWidget({
    super.key,
    required this.buildWidget,
    this.initializeConfig = false,
  });

  final Widget Function(
      BuildContext context,
      ResponsiveUiConfig responsiveUiConfig,
      AppConfigurations appConfigurations) buildWidget;
  final bool initializeConfig;

  @override
  Widget build(BuildContext context) {
    final ResponsiveUiConfig responsiveUiConfig = locator<ResponsiveUiConfig>();
    final AppConfigurations appConfigurations = locator<AppConfigurations>();
    if (initializeConfig) {
      responsiveUiConfig.initialize(context);
    }
    return buildWidget(context, responsiveUiConfig, appConfigurations);
  }
}
