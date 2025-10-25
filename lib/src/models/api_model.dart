import 'package:json_annotation/json_annotation.dart';

// part 'api_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  final String message;
  final T? data;
  final bool success;

  ApiResponse({
    required this.message,
    this.data,
    required this.success,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>)? fromJsonT,
  ) {
    return ApiResponse<T>(
      message: json['message'] ?? '',
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : json['data'],
      success: true,
    );
  }

  factory ApiResponse.error(String message) {
    return ApiResponse<T>(
      message: message,
      data: null,
      success: false,
    );
  }
}

class PaginationInfo {
  final int limit;
  final int total;
  final String? grainType;

  PaginationInfo({
    required this.limit,
    required this.total,
    this.grainType,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo(
      limit: json['limit'] ?? 0,
      total: json['total'] ?? 0,
      grainType: json['grainType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'total': total,
      if (grainType != null) 'grainType': grainType,
    };
  }
}

class ImageInfo {
  final String filename;
  final String url;

  ImageInfo({
    required this.filename,
    required this.url,
  });

  factory ImageInfo.fromJson(Map<String, dynamic> json) {
    return ImageInfo(
      filename: json['filename'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'filename': filename,
      'url': url,
    };
  }
}

class SupportedFormats {
  final List<String> imageTypes;
  final List<String> extensions;
  final int maxSize;
  final String maxSizeFormatted;

  SupportedFormats({
    required this.imageTypes,
    required this.extensions,
    required this.maxSize,
    required this.maxSizeFormatted,
  });

  factory SupportedFormats.fromJson(Map<String, dynamic> json) {
    return SupportedFormats(
      imageTypes: List<String>.from(json['imageTypes'] ?? []),
      extensions: List<String>.from(json['extensions'] ?? []),
      maxSize: json['maxSize'] ?? 0,
      maxSizeFormatted: json['maxSizeFormatted'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageTypes': imageTypes,
      'extensions': extensions,
      'maxSize': maxSize,
      'maxSizeFormatted': maxSizeFormatted,
    };
  }
}

enum GrainType {
  soja('Soja'),
  milho('Milho'),
  trigo('Trigo'),
  arroz('Arroz'),
  feijao('Feijão'),
  cafe('Café'),
  aveia('Aveia'),
  cevada('Cevada'),
  sorgo('Sorgo'),
  girassol('Girassol');

  const GrainType(this.displayName);
  final String displayName;

  static GrainType? fromString(String value) {
    for (var type in GrainType.values) {
      if (type.displayName.toLowerCase() == value.toLowerCase()) {
        return type;
      }
    }
    return null;
  }
}

enum UserType {
  produtor('PRODUTOR'),
  cooperativa('COOPERATIVA'),
  comprador('COMPRADOR');

  const UserType(this.value);
  final String value;

  static UserType? fromString(String value) {
    for (var type in UserType.values) {
      if (type.value == value) {
        return type;
      }
    }
    return null;
  }
}
