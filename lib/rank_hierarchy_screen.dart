import 'package:flutter/material.dart';
import 'widgets/background_wrapper.dart';

class RankHierarchyScreen extends StatelessWidget {
  const RankHierarchyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryCyan = Color(0xFF00FBFF);
    const cardBg = Color(0xFF111718);

    return BackgroundWrapper(
      showGrid: true,
      removeSafeAreaPadding: true,
      child: Column(
        children: [
          // --- CUSTOM APP BAR ---
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF0B1214).withValues(alpha: 0.8),
              border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
            ),
            child: Row(
              children: [
                const Icon(Icons.menu, color: primaryCyan),
                const SizedBox(width: 20),
                const Text(
                  'ALCHEMIST RANKS',
                  style: TextStyle(
                    color: primaryCyan,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: primaryCyan, width: 1),
                    image: const DecorationImage(
                      image: NetworkImage('https://i.pravatar.cc/150?u=alchemist'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- BACK BUTTON ---
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back, color: primaryCyan, size: 20),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // --- TITLE & DESC ---
                  const Text(
                    'Full Rank Hierarchy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'The Rank page functions to display user rankings based on the XP they have collected, motivate users to study harder, and provide recognition for their achievements.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // --- LIST OF RANKS ---
                  _rankCard(
                    context,
                    badgeColor: const Color(0xFFCD7F32), // Bronze
                    title: 'Novice',
                    subTitle: 'calon alchemist',
                    threshold: '0 XP',
                  ),
                  _rankCard(
                    context,
                    badgeColor: const Color(0xFFC0C0C0), // Silver
                    title: 'Apprentice',
                    subTitle: 'pelajar giat',
                    threshold: '500 XP',
                  ),
                  _rankCard(
                    context,
                    badgeColor: const Color(0xFFFFD700), // Gold
                    title: 'Adept',
                    subTitle: 'ahli farmasi',
                    threshold: '1500 XP',
                  ),
                  _rankCard(
                    context,
                    badgeColor: primaryCyan, // Cyan
                    title: 'Senior Researcher',
                    subTitle: 'peneliti senior',
                    threshold: '3000 XP',
                    isCurrent: true,
                  ),
                  _rankCard(
                    context,
                    badgeColor: const Color(0xFFCCFF00), // Lime
                    title: 'Expert Chemist',
                    subTitle: 'ahli kimia atom',
                    threshold: '6000 XP',
                  ),
                  _rankCard(
                    context,
                    badgeColor: const Color(0xFFFF00FB), // Magenta/Neon
                    title: 'Grand Alchemist',
                    subTitle: 'alchemist legendaris',
                    threshold: '12000 XP',
                  ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rankCard(
    BuildContext context, {
    required Color badgeColor,
    required String title,
    required String subTitle,
    required String threshold,
    bool isCurrent = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111718),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrent ? badgeColor.withValues(alpha: 0.3) : Colors.white.withValues(alpha: 0.05),
          width: isCurrent ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // BADGE
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: badgeColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(Icons.science, color: badgeColor, size: 32),
            ),
          ),
          const SizedBox(width: 20),
          // INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // THRESHOLD
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'THRESHOLD',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.3),
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
              ),
              Text(
                threshold,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
