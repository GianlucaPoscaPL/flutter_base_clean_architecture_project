import 'package:clean_architecture_base_project/core/utils/mapper/data_mapper.dart';
import 'package:clean_architecture_base_project/features/weather_info/domain/entities/weather_remote_info_response_entity/wind_info_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class WindInfoLocalEntity extends DataMapper<WindInfoEntity> {
  WindInfoLocalEntity({
    this.speed,
    this.deg,
    this.id,
  });

  int? id;
  String? speed;
  int? deg;

  @override
  WindInfoEntity mapToEntity() {
    return WindInfoEntity(
      deg: deg,
      speed: speed,
    );
  }
}
