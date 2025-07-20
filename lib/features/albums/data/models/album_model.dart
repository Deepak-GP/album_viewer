import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/album.dart';

part 'album_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class AlbumModel extends Album {
  @HiveField(0)
  @JsonKey(name: 'id')
  final int albumId;

  @HiveField(1)
  @JsonKey(name: 'userId')
  final int albumUserId;

  @HiveField(2)
  @JsonKey(name: 'title')
  final String albumTitle;

  const AlbumModel({
    required this.albumId,
    required this.albumUserId,
    required this.albumTitle,
  }) : super(
          id: albumId,
          userId: albumUserId,
          title: albumTitle,
        );

  factory AlbumModel.fromJson(Map<String, dynamic> json) =>
      _$AlbumModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumModelToJson(this);

  factory AlbumModel.fromEntity(Album album) {
    return AlbumModel(
      albumId: album.id,
      albumUserId: album.userId,
      albumTitle: album.title,
    );
  }
}
