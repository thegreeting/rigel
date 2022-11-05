import 'package:freezed_annotation/freezed_annotation.dart';

part 'campaign.entity.freezed.dart';
part 'campaign.entity.g.dart';

@freezed
class Campaign with _$Campaign {
  const factory Campaign({
    // https://schema.org/Thing
    required String id,
    required String name,
    String? description,
    String? url,
    // required ImageObject image, // representative image
    // https://schema.org/CreativeWork
    required DateTime startDate,
    required DateTime endDate,
  }) = _Campaign;

  factory Campaign.fromJson(Map<String, dynamic> json) => _$CampaignFromJson(json);
}
