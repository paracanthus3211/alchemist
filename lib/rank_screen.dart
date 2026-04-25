import 'package:flutter/material.dart';
import 'widgets/background_wrapper.dart';
import 'rank_hierarchy_screen.dart';

class RankScreen extends StatefulWidget {
  const RankScreen({super.key});

  @override
  State<RankScreen> createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen> {
  String selectedTime = 'Week';
  String selectedScope = 'Globally';

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
            
            // --- HEADER ---
            const Text(
              'ALCHEMY RANK',
              style: TextStyle(
                color: primaryCyan,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.0,
              ),
            ),
            const Text(
              'LABORATORY LEADERBOARD',
              style: TextStyle(
                color: Colors.white38,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
            ),

            const SizedBox(height: 32),

            // --- FILTERS ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _pillFilter('Week', selectedTime == 'Week', (v) => setState(() => selectedTime = v)),
                      _pillFilter('Month', selectedTime == 'Month', (v) => setState(() => selectedTime = v)),
                      _pillFilter('All Time', selectedTime == 'All Time', (v) => setState(() => selectedTime = v)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _pillFilter('Globally', selectedScope == 'Globally', (v) => setState(() => selectedScope = v)),
                      _pillFilter('Friends', selectedScope == 'Friends', (v) => setState(() => selectedScope = v)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // --- LEAGUE CARD ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const RankHierarchyScreen()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.shield_outlined, color: Color(0xFFC0C0C0), size: 32),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'SILVER LEAGUE',
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'TOP 10% OF RESEARCHERS',
                              style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 10, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Colors.white24),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // --- PODIUM ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _podiumItem('Dr. Arkan', '2400', '2', 'https://i.pravatar.cc/150?u=2', 100),
                  const SizedBox(width: 12),
                  _podiumItem('Professor X', '3100', '1', 'https://i.pravatar.cc/150?u=1', 140, isGold: true),
                  const SizedBox(width: 12),
                  _podiumItem('Lab Asst. B', '1900', '3', 'https://i.pravatar.cc/150?u=3', 80),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // --- LIST ---
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF111718),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(2))),
                  const SizedBox(height: 24),
                  _rankTile(4, 'Saphire', 'Novice Lab', '1200'),
                  _rankTile(5, 'Sirhan', 'Expert Atom', '1150', isMe: true),
                  _rankTile(6, 'QuantumQ', 'Junior Chemist', '1100'),
                  _rankTile(7, 'NanoBot', 'Lab Intern', '950'),
                  _rankTile(8, 'ElectronG', 'Lab Intern', '800'),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pillFilter(String label, bool isSelected, Function(String) onTap) {
    return GestureDetector(
      onTap: () => onTap(label),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00FBFF) : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white38,
            fontSize: 11,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Widget _podiumItem(String name, String xp, String rank, String img, double height, {bool isGold = false}) {
    final color = isGold ? const Color(0xFFCCFF00) : const Color(0xFF00FBFF);
    return Column(
      children: [
        Container(
          width: isGold ? 70 : 54,
          height: isGold ? 70 : 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
            image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900)),
        Text('$xp XP', style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withValues(alpha: 0.3), color.withValues(alpha: 0.05)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          ),
          child: Center(
            child: Text(
              rank,
              style: TextStyle(color: color, fontSize: 32, fontWeight: FontWeight.w900),
            ),
          ),
        ),
      ],
    );
  }

  Widget _rankTile(int rank, String name, String title, String xp, {bool isMe = false}) {
    const primaryCyan = Color(0xFF00FBFF);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: isMe ? primaryCyan.withValues(alpha: 0.05) : Colors.transparent,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(
              rank.toString(),
              style: TextStyle(color: isMe ? primaryCyan : Colors.white24, fontSize: 16, fontWeight: FontWeight.w900),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.05),
              image: DecorationImage(image: NetworkImage('https://i.pravatar.cc/150?u=$name'), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900),
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 10, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Text(
            '$xp XP',
            style: TextStyle(color: isMe ? primaryCyan : Colors.white70, fontSize: 14, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
