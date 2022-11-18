import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final num lat;
  final num lon;
  const Location(this.lat, this.lon);

  @override
  List<Object?> get props => [lat, lon];
}
