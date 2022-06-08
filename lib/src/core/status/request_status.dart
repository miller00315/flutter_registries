import 'package:equatable/equatable.dart';

abstract class RequestStatus extends Equatable {
  const RequestStatus();

  @override
  List<Object?> get props => [];
}

class InProgressStatus extends RequestStatus {}

class DoneStatus extends RequestStatus {}

class ErrorStatus extends RequestStatus {}
