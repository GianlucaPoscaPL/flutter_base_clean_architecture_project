import 'package:clean_architecture_base_project/core/utils/mapper/data_mapper.dart';
import 'package:clean_architecture_base_project/features/weather_info/domain/entities/weather_remote_info_response_entity/coordinate_entity.dart';
import 'package:objectbox/objectbox.dart';


@Entity()
class CoordinateLocalEntity extends DataMapper<CoordinateEntity> {
  CoordinateLocalEntity({
    this.lon,
    this.lat,
    this.id,
  });

  int? id;
  double? lon;
  double? lat;

  @override
  CoordinateEntity mapToEntity() {
    return CoordinateEntity(
      lat: lat,
      lon: lon,
    );
  }
}
