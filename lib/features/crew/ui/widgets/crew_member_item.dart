import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spacex/core/themes/text_styles.dart';
import 'package:spacex/core/widgets/custom_shimmer_loading.dart';
import 'package:spacex/features/crew/data/models/crew_model.dart';

import '../../../../core/constant/colors.dart';
import '../../../../core/utils/nonetwork_toast.dart';
import '../views/crew_member_details_screen.dart';

class CrewMemberItem extends StatelessWidget {
  const CrewMemberItem({super.key, required this.crewMember, required this.isNetworkConnected});

  final CrewModel crewMember;
  final bool isNetworkConnected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
      isNetworkConnected ?
       () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CrewMemberDetailsScreen(
                crewModel: crewMember,
              );
            },
          ),
        );
      } : () {
                showToastNoNetwork(
                  context,
                );
              },
      child: ClipRRect(
        borderRadius: BorderRadiusDirectional.circular(12),
        child: GridTile(
          footer: Container(
            padding: const EdgeInsetsDirectional.all(4),
            decoration:
                BoxDecoration(color: AppColors.buttonBlue.withOpacity(.7)),
            child: Text(
              crewMember.name,
              style: MyTextStyles.font18WhiteBold,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
          child: Hero(
            tag: crewMember.image,

            child: Image.network(
              crewMember.image ?? '',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[800],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.person, size: 50, color: Colors.white54),
                      const SizedBox(height: 8),
                      const Text('Image not available', style: TextStyle(color: Colors.white54)),
                    ],
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[800],
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
            )
            ),
          ),
        ),
    );
  }
}
