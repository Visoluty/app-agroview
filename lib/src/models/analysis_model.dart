import 'package:json_annotation/json_annotation.dart';

// part 'analysis_model.g.dart';

@JsonSerializable()
class Analysis {
  final String id;
  final String grainType;
  final String date;
  final double purityPercentage;
  final int totalGrains;
  final int defectiveGrains;
  final String imageUrl;
  final DefectsBreakdown defectsBreakdown;
  final String classification;

  Analysis({
    required this.id,
    required this.grainType,
    required this.date,
    required this.purityPercentage,
    required this.totalGrains,
    required this.defectiveGrains,
    required this.imageUrl,
    required this.defectsBreakdown,
    required this.classification,
  });

  factory Analysis.fromJson(Map<String, dynamic> json) {
    return Analysis(
      id: json['id'] ?? '',
      grainType: json['grainType'] ?? '',
      date: json['date'] ?? '',
      purityPercentage: (json['purityPercentage'] ?? 0.0).toDouble(),
      totalGrains: json['totalGrains'] ?? 0,
      defectiveGrains: json['defectiveGrains'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
      defectsBreakdown: DefectsBreakdown.fromJson(json['defectsBreakdown'] ?? {}),
      classification: json['classification'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'grainType': grainType,
      'date': date,
      'purityPercentage': purityPercentage,
      'totalGrains': totalGrains,
      'defectiveGrains': defectiveGrains,
      'imageUrl': imageUrl,
      'defectsBreakdown': defectsBreakdown.toJson(),
      'classification': classification,
    };
  }
}

class DefectsBreakdown {
  final double broken;
  final double damaged;
  final double discolored;
  final double foreignMatter;

  DefectsBreakdown({
    required this.broken,
    required this.damaged,
    required this.discolored,
    required this.foreignMatter,
  });

  factory DefectsBreakdown.fromJson(Map<String, dynamic> json) {
    return DefectsBreakdown(
      broken: (json['broken'] ?? 0.0).toDouble(),
      damaged: (json['damaged'] ?? 0.0).toDouble(),
      discolored: (json['discolored'] ?? 0.0).toDouble(),
      foreignMatter: (json['foreignMatter'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'broken': broken,
      'damaged': damaged,
      'discolored': discolored,
      'foreignMatter': foreignMatter,
    };
  }
}

class AnalysisHistory {
  final String id;
  final String grainType;
  final String date;
  final double purityPercentage;
  final int totalGrains;
  final int defectiveGrains;

  AnalysisHistory({
    required this.id,
    required this.grainType,
    required this.date,
    required this.purityPercentage,
    required this.totalGrains,
    required this.defectiveGrains,
  });

  factory AnalysisHistory.fromJson(Map<String, dynamic> json) {
    return AnalysisHistory(
      id: json['id'] ?? '',
      grainType: json['grainType'] ?? '',
      date: json['date'] ?? '',
      purityPercentage: (json['purityPercentage'] ?? 0.0).toDouble(),
      totalGrains: json['totalGrains'] ?? 0,
      defectiveGrains: json['defectiveGrains'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'grainType': grainType,
      'date': date,
      'purityPercentage': purityPercentage,
      'totalGrains': totalGrains,
      'defectiveGrains': defectiveGrains,
    };
  }
}

class ProcessImageResponse {
  final String analysisId;
  final String grainType;
  final int totalGrains;
  final int healthyGrains;
  final int defectiveGrains;
  final DefectsBreakdown defectsBreakdown;
  final double purityPercentage;
  final double impurityPercentage;
  final String imageUrl;

  ProcessImageResponse({
    required this.analysisId,
    required this.grainType,
    required this.totalGrains,
    required this.healthyGrains,
    required this.defectiveGrains,
    required this.defectsBreakdown,
    required this.purityPercentage,
    required this.impurityPercentage,
    required this.imageUrl,
  });

  factory ProcessImageResponse.fromJson(Map<String, dynamic> json) {
    return ProcessImageResponse(
      analysisId: json['analysisId'] ?? '',
      grainType: json['grainType'] ?? '',
      totalGrains: json['totalGrains'] ?? 0,
      healthyGrains: json['healthyGrains'] ?? 0,
      defectiveGrains: json['defectiveGrains'] ?? 0,
      defectsBreakdown: DefectsBreakdown.fromJson(json['defectsBreakdown'] ?? {}),
      purityPercentage: (json['purityPercentage'] ?? 0.0).toDouble(),
      impurityPercentage: (json['impurityPercentage'] ?? 0.0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'analysisId': analysisId,
      'grainType': grainType,
      'totalGrains': totalGrains,
      'healthyGrains': healthyGrains,
      'defectiveGrains': defectiveGrains,
      'defectsBreakdown': defectsBreakdown.toJson(),
      'purityPercentage': purityPercentage,
      'impurityPercentage': impurityPercentage,
      'imageUrl': imageUrl,
    };
  }
}

class AnalysisStats {
  final int totalAnalyses;
  final double averagePurity;
  final double bestPurity;
  final double worstPurity;
  final List<GrainTypeBreakdown> grainTypeBreakdown;

  AnalysisStats({
    required this.totalAnalyses,
    required this.averagePurity,
    required this.bestPurity,
    required this.worstPurity,
    required this.grainTypeBreakdown,
  });

  factory AnalysisStats.fromJson(Map<String, dynamic> json) {
    return AnalysisStats(
      totalAnalyses: json['totalAnalyses'] ?? 0,
      averagePurity: (json['averagePurity'] ?? 0.0).toDouble(),
      bestPurity: (json['bestPurity'] ?? 0.0).toDouble(),
      worstPurity: (json['worstPurity'] ?? 0.0).toDouble(),
      grainTypeBreakdown: (json['grainTypeBreakdown'] as List<dynamic>?)
          ?.map((e) => GrainTypeBreakdown.fromJson(e))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalAnalyses': totalAnalyses,
      'averagePurity': averagePurity,
      'bestPurity': bestPurity,
      'worstPurity': worstPurity,
      'grainTypeBreakdown': grainTypeBreakdown.map((e) => e.toJson()).toList(),
    };
  }
}

class GrainTypeBreakdown {
  final String grainType;
  final int count;
  final double averagePurity;

  GrainTypeBreakdown({
    required this.grainType,
    required this.count,
    required this.averagePurity,
  });

  factory GrainTypeBreakdown.fromJson(Map<String, dynamic> json) {
    return GrainTypeBreakdown(
      grainType: json['grainType'] ?? '',
      count: json['count'] ?? 0,
      averagePurity: (json['averagePurity'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'grainType': grainType,
      'count': count,
      'averagePurity': averagePurity,
    };
  }
}

class ComparisonResponse {
  final List<ComparisonAnalysis> comparedAnalyses;
  final ComparisonMetrics comparisonMetrics;

  ComparisonResponse({
    required this.comparedAnalyses,
    required this.comparisonMetrics,
  });

  factory ComparisonResponse.fromJson(Map<String, dynamic> json) {
    return ComparisonResponse(
      comparedAnalyses: (json['comparedAnalyses'] as List<dynamic>?)
          ?.map((e) => ComparisonAnalysis.fromJson(e))
          .toList() ?? [],
      comparisonMetrics: ComparisonMetrics.fromJson(json['comparisonMetrics'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comparedAnalyses': comparedAnalyses.map((e) => e.toJson()).toList(),
      'comparisonMetrics': comparisonMetrics.toJson(),
    };
  }
}

class ComparisonAnalysis {
  final String analysisId;
  final double purityPercentage;
  final int defectiveGrains;
  final String grainType;
  final String date;

  ComparisonAnalysis({
    required this.analysisId,
    required this.purityPercentage,
    required this.defectiveGrains,
    required this.grainType,
    required this.date,
  });

  factory ComparisonAnalysis.fromJson(Map<String, dynamic> json) {
    return ComparisonAnalysis(
      analysisId: json['analysisId'] ?? '',
      purityPercentage: (json['purityPercentage'] ?? 0.0).toDouble(),
      defectiveGrains: json['defectiveGrains'] ?? 0,
      grainType: json['grainType'] ?? '',
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'analysisId': analysisId,
      'purityPercentage': purityPercentage,
      'defectiveGrains': defectiveGrains,
      'grainType': grainType,
      'date': date,
    };
  }
}

class ComparisonMetrics {
  final double averagePurity;
  final double bestPurity;
  final double worstPurity;
  final double averageDefectiveGrains;

  ComparisonMetrics({
    required this.averagePurity,
    required this.bestPurity,
    required this.worstPurity,
    required this.averageDefectiveGrains,
  });

  factory ComparisonMetrics.fromJson(Map<String, dynamic> json) {
    return ComparisonMetrics(
      averagePurity: (json['averagePurity'] ?? 0.0).toDouble(),
      bestPurity: (json['bestPurity'] ?? 0.0).toDouble(),
      worstPurity: (json['worstPurity'] ?? 0.0).toDouble(),
      averageDefectiveGrains: (json['averageDefectiveGrains'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'averagePurity': averagePurity,
      'bestPurity': bestPurity,
      'worstPurity': worstPurity,
      'averageDefectiveGrains': averageDefectiveGrains,
    };
  }
}
