import 'package:flutter/material.dart';
import 'package:clean_architecture_base_project/core/di/app_component/app_component.dart';
import 'package:clean_architecture_base_project/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:clean_architecture_base_project/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:clean_architecture_base_project/core/utils/values/styles.dart';

class WeatherDetailsHeader extends StatelessWidget {
  const WeatherDetailsHeader({
    Key? key,
    this.locationName,
    this.date,
  }) : super(key: key);
  final String? locationName;
  final String? date;

  @override
  Widget build(BuildContext context) {
    final AppConfigurations appConfigurations = locator<AppConfigurations>();
    return Padding(
      padding: EdgeInsets.only(
        top: 50.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            locationName ?? '',
            style: poppinsBold.copyWith(
              color:  appConfigurations.appTheme.primaryColor,
              fontSize: 22.w,
            ),
          ),
          Text(
            date ?? '',
            style: poppinsRegular.copyWith(
              color:  appConfigurations.appTheme.primaryColor,
              fontSize: 20.w,
            ),
          ),
        ],
      ),
    );
  }
}
