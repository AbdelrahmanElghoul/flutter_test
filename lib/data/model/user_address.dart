import 'package:equatable/equatable.dart';
import 'package:test_flutter/data/model/location.dart';

class Address extends Equatable {
  final String? address;
  final Location? location;

  const Address({this.address, this.location});

  @override
  String toString() {
    return address ?? '';
  }

  @override
  List<Object?> get props => [address, location];
}
