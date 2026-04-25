import 'package:flutter/material.dart';
import 'widgets/background_wrapper.dart';
import 'services/api_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedTab = 2; // Default to Settings

  @override
  Widget build(BuildContext context) {
    const primaryCyan = Color(0xFF00FBFF);
    const accentLime = Color(0xFFCCFF00);
    const cardBg = Color(0xFF111718);

    return BackgroundWrapper(
      showGrid: true,
      removeSafeAreaPadding: true,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // --- PROFILE HEADER CARD ---
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 60, left: 24, right: 24),
                  padding: const EdgeInsets.fromLTRB(24, 70, 24, 24),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        ApiService().currentUser?.username ?? 'PARACANTHUS',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Senior Alchemy Researcher',
                        style: TextStyle(color: primaryCyan, fontSize: 13, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _statLabel('FOLLOWING', '124'),
                          _statLabel('FOLLOWERS', '850'),
                          _statLabel('FRIENDS', '10'),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Joined on January 9, 2026',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.3),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // Avatar with border
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: primaryCyan, width: 3),
                    boxShadow: [
                      BoxShadow(color: primaryCyan.withValues(alpha: 0.3), blurRadius: 20, spreadRadius: 2),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundColor: cardBg,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=alchemist'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // --- TABS ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    _tabNavItem('History', 0),
                    _tabNavItem('Awards', 1),
                    _tabNavItem('Settings', 2),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --- TAB CONTENT ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _buildSelectedContent(),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedContent() {
    switch (_selectedTab) {
      case 0:
        return _buildHistoryContent();
      case 1:
        return _buildAchievementContent();
      case 2:
      default:
        return _buildSettingsContent();
    }
  }

  Widget _buildSettingsContent() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF111718),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: Column(
            children: [
              _settingsItem(Icons.text_fields, 'Font Size', 'Medium', true),
              _divider(),
              _settingsItem(Icons.language, 'Language', 'English', true),
              _divider(),
              _settingsItem(Icons.info_outline, 'About Alchemist', 'Ver 2.0.1', false),
            ],
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF111718),
              foregroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(color: Colors.redAccent, width: 1),
              ),
              elevation: 0,
            ),
            child: const Text('LOGOUT RESEARCHER', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.2)),
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Divider(color: Colors.white.withValues(alpha: 0.05), height: 32);
  }

  Widget _settingsItem(IconData icon, String title, String value, bool showArrow) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800),
          ),
        ),
        Text(
          value,
          style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 13, fontWeight: FontWeight.w600),
        ),
        if (showArrow)
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(Icons.chevron_right, color: Colors.white24, size: 20),
          ),
      ],
    );
  }

  Widget _buildHistoryContent() {
    return Column(
      children: List.generate(3, (index) => _historyItem()),
    );
  }

  Widget _buildAchievementContent() {
    return Container(
      padding: const EdgeInsets.all(40),
      alignment: Alignment.center,
      child: const Column(
        children: [
          Icon(Icons.emoji_events_outlined, color: Colors.white10, size: 64),
          SizedBox(height: 12),
          Text(
            'Achievements processing...',
            style: TextStyle(color: Colors.white24, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _statLabel(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.0),
        ),
      ],
    );
  }

  Widget _tabNavItem(String label, int index) {
    const primaryCyan = Color(0xFF00FBFF);
    bool isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? primaryCyan : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white24,
                fontWeight: FontWeight.w900,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _historyItem() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111718),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.auto_stories_outlined, color: Color(0xFF00FBFF), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'The Alchemy of AI',
                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800),
                ),
                Text(
                  '2 hours ago',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.white10),
        ],
      ),
    );
  }
}
