import 'package:flutter/material.dart';

class AddFriendsScreen extends StatefulWidget {
  const AddFriendsScreen({super.key});

  @override
  State<AddFriendsScreen> createState() => _AddFriendsScreenState();
}

class _AddFriendsScreenState extends State<AddFriendsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00B0CC),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            // ---- BACK BUTTON ----
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // ---- TOP TABS (Your friends / Add friends) ----
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                ),
                child: TabBar(
                  controller: _tabController,
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  padding: const EdgeInsets.all(4),
                  indicator: BoxDecoration(
                    color: const Color(0xFF0B4CBA).withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontStyle: FontStyle.italic),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
                  tabs: const [
                    Tab(text: 'Your friends'),
                    Tab(text: 'Add friends'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ---- SEARCH BAR ----
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 54,
                decoration: BoxDecoration(
                  color: const Color(0xFF0B4CBA),
                  borderRadius: BorderRadius.circular(27),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    const Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Search by Username',
                          hintStyle: TextStyle(color: Colors.white70, fontSize: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(4),
                      width: 46,
                      height: 46,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.search, color: Color(0xFF0B4CBA), size: 24),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ---- FRIENDS LIST ----
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                itemCount: 8,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) => _friendItem(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _friendItem() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0A6DF4),
        borderRadius: BorderRadius.circular(4), // As seen in mockup (sharp corners with slight radius)
      ),
      child: Row(
        children: [
          // Index placeholder
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 14),
          // Avatar placeholder
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 14),
          // Name & Level
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Paracanthus',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Level 7 . Ahli Atom',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Add button
          const Icon(Icons.person_add_alt_1, color: Colors.white, size: 32),
        ],
      ),
    );
  }
}
