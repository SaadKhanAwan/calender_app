// content_item.dart
import 'package:flutter/material.dart';
import '../models/platform_model.dart';

class ContentItem extends StatelessWidget {
  final int rank;
  final Platform? platform;
  final String language;

  const ContentItem({
    super.key,
    required this.rank,
    this.platform,
    required this.language,
  });

  Widget _buildStatItem(IconData icon, String count) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey[500]),
          const SizedBox(width: 2),
          Text(
            count,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: platform?.icon != null && platform!.icon!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://att-contents.yikart.cn/${platform!.icon}',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              _getPlatformIcon(),
                              size: 40,
                              color: Colors.grey[400],
                            );
                          },
                        ),
                      )
                    : Icon(
                        _getPlatformIcon(),
                        size: 40,
                        color: Colors.grey[400],
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFFF3F2FF).withOpacity(0.2),
                          ),
                          child: Text(
                            platform?.type ?? '',
                            style: const TextStyle(
                              color: Color(0xFF7240F8),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            language == 'en' && platform?.nameEn != null
                                ? platform!.nameEn!
                                : platform?.name ?? '',
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey[300],
                        ),
                        const SizedBox(width: 4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              language == 'en' && platform?.descriptionEn != null
                                  ? platform!.descriptionEn!
                                  : platform?.description ?? '',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              platform?.createTime.toString().split(' ')[0] ?? '',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStatItem(Icons.visibility, '6830'),
                          _buildStatItem(Icons.chat_bubble_outline, '6830'),
                          _buildStatItem(Icons.thumb_up_outlined, '6830'),
                          _buildStatItem(Icons.share, '6830'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 4,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: [
                const Text(
                  'TOP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$rank',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFFF3F2FF).withOpacity(0.2),
            ),
            child: Column(
              children: [
                Text(
                  platform?.hotinfo ?? '0',
                  style: const TextStyle(
                    color: Color(0xFF7240F8),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  language == 'en' ? 'Total Interactions' : '互动总数',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  IconData _getPlatformIcon() {
    if (platform == null) return Icons.apps;
    
    switch (platform!.type) {
      case 'wechat':
        return Icons.wechat;
      case 'xiaohongshu':
        return Icons.favorite;
      case 'douyin':
        return Icons.music_video;
      case 'kuaishou':
        return Icons.play_circle;
      case 'bilibili':
        return Icons.play_arrow;
      case 'shipinhao':
        return Icons.video_library;
      default:
        return Icons.apps;
    }
  }
}
