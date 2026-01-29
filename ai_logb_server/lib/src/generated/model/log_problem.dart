/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class LogProblem
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  LogProblem._({
    required this.problem,
    required this.likelyCause,
    required this.recommendedFix,
    this.codeExample,
    required this.severity,
    required this.timestamp,
  });

  factory LogProblem({
    required String problem,
    required String likelyCause,
    required String recommendedFix,
    String? codeExample,
    required String severity,
    required DateTime timestamp,
  }) = _LogProblemImpl;

  factory LogProblem.fromJson(Map<String, dynamic> jsonSerialization) {
    return LogProblem(
      problem: jsonSerialization['problem'] as String,
      likelyCause: jsonSerialization['likelyCause'] as String,
      recommendedFix: jsonSerialization['recommendedFix'] as String,
      codeExample: jsonSerialization['codeExample'] as String?,
      severity: jsonSerialization['severity'] as String,
      timestamp: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
    );
  }

  /// Short description of the problem
  String problem;

  /// Most likely technical cause
  String likelyCause;

  /// Recommended fix or action to resolve the issue
  String recommendedFix;

  /// Optional code example (can be empty or null)
  String? codeExample;

  /// Log level (ERROR, WARNING, INFO)
  String severity;

  /// When the problem was detected
  DateTime timestamp;

  /// Returns a shallow copy of this [LogProblem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LogProblem copyWith({
    String? problem,
    String? likelyCause,
    String? recommendedFix,
    String? codeExample,
    String? severity,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LogProblem',
      'problem': problem,
      'likelyCause': likelyCause,
      'recommendedFix': recommendedFix,
      if (codeExample != null) 'codeExample': codeExample,
      'severity': severity,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LogProblem',
      'problem': problem,
      'likelyCause': likelyCause,
      'recommendedFix': recommendedFix,
      if (codeExample != null) 'codeExample': codeExample,
      'severity': severity,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LogProblemImpl extends LogProblem {
  _LogProblemImpl({
    required String problem,
    required String likelyCause,
    required String recommendedFix,
    String? codeExample,
    required String severity,
    required DateTime timestamp,
  }) : super._(
         problem: problem,
         likelyCause: likelyCause,
         recommendedFix: recommendedFix,
         codeExample: codeExample,
         severity: severity,
         timestamp: timestamp,
       );

  /// Returns a shallow copy of this [LogProblem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LogProblem copyWith({
    String? problem,
    String? likelyCause,
    String? recommendedFix,
    Object? codeExample = _Undefined,
    String? severity,
    DateTime? timestamp,
  }) {
    return LogProblem(
      problem: problem ?? this.problem,
      likelyCause: likelyCause ?? this.likelyCause,
      recommendedFix: recommendedFix ?? this.recommendedFix,
      codeExample: codeExample is String? ? codeExample : this.codeExample,
      severity: severity ?? this.severity,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
