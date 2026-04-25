import 'package:flutter/material.dart';
import 'widgets/background_wrapper.dart';

class VirtualLabScreen extends StatefulWidget {
  const VirtualLabScreen({super.key});

  @override
  State<VirtualLabScreen> createState() => _VirtualLabScreenState();
}

class _VirtualLabScreenState extends State<VirtualLabScreen> {
  // Mock data for the chemical inventory
  final List<Map<String, dynamic>> _chemicals = [
    {'name': 'Hydrochloric Acid', 'formula': 'HCl', 'color': const Color(0xFF8B4513)}, // Brown
    {'name': 'Sulfuric Acid', 'formula': 'H2SO4', 'color': const Color(0xFFD2691E)}, // Orange-brown
    {'name': 'Nitric Acid', 'formula': 'HNO3', 'color': const Color(0xFFFF8C00)}, // Orange
    {'name': 'Acetic Acid', 'formula': 'CH3COOH', 'color': const Color(0xFFFFD700)}, // Yellow
    {'name': 'Sodium Hydroxide', 'formula': 'NaOH', 'color': const Color(0xFF1E90FF)}, // Blue
    {'name': 'Potassium Hydroxide', 'formula': 'KOH', 'color': const Color(0xFF00BFFF)}, // Light Blue
    {'name': 'Ammonia', 'formula': 'NH3', 'color': const Color(0xFF87CEFA)}, // Light Blue
    {'name': 'Sodium Chloride', 'formula': 'NaCl', 'color': const Color(0xFFD3D3D3)}, // Light Grey
    {'name': 'Potassium Chloride', 'formula': 'KCl', 'color': const Color(0xFFA9A9A9)}, // Grey
    {'name': 'Calcium Chloride', 'formula': 'CaCl2', 'color': const Color(0xFFE0E0E0)}, // Very Light Grey
    {'name': 'Magnesium Sulfate', 'formula': 'MgSO4', 'color': const Color(0xFFF5F5F5)}, // White-ish
    {'name': 'Sodium Carbonate', 'formula': 'Na2CO3', 'color': const Color(0xFFF0F8FF)}, // White-ish
    {'name': 'Zinc Metal', 'formula': 'Zn', 'color': const Color(0xFFB0C4DE)}, // Grey
    {'name': 'Magnesium Metal', 'formula': 'Mg', 'color': const Color(0xFFE6E6FA)}, // White/Grey
    {'name': 'Aluminum Metal', 'formula': 'Al', 'color': const Color(0xFFF8F8FF)}, // White
    {'name': 'Iron Metal', 'formula': 'Fe', 'color': const Color(0xFF708090)}, // Dark Grey
    {'name': 'Calcium Carbonate', 'formula': 'CaCO3', 'color': const Color(0xFFDCDCDC)}, // Light Grey
    {'name': 'Silver Nitrate', 'formula': 'AgNO3', 'color': const Color(0xFFF5F5DC)}, // Beige/White
    {'name': 'Lead(II) Nitrate', 'formula': 'Pb(NO3)2', 'color': const Color(0xFFE0FFFF)}, // Cyan-ish white
    {'name': 'Potassium Iodide', 'formula': 'KI', 'color': const Color(0xFFFFFFE0)}, // Light Yellow
    {'name': 'Copper(II) Sulfate', 'formula': 'CuSO4', 'color': const Color(0xFF32CD32)}, // Lime Green
    {'name': 'Iron(III) Chloride', 'formula': 'FeCl3', 'color': const Color(0xFFFF6347)}, // Tomato Red
  ];

  // Keypad keys for calculator
  final List<String> _calcKeys = [
    'H', 'O', 'C', 'N', 'Na', 'Cl', 'Ca',
    'Mg', 'S', 'K', 'Fe', 'Cu', 'Zn',
    'Ag', 'Pb', 'Ba', '(', ')',
    '2', '3', '4', 'Clear', '+ Hitung'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00B0CC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header & Lab Area
              Container(
                color: const Color(0xFF00A2C2),
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back logic handled by a simple icon top left
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Alchemist virtual lab',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '22 chemicals | mix, heat & calculate Molar mass!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),

              // Lab Workbench Area
              Container(
                color: const Color(0xFF71C5D3), // Lighter cyan-blue color from mockup
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Beakers row
                    Row(
                      children: [
                        Expanded(child: _buildBeaker('Beaker A', '10 ml', 'HCL')),
                        const SizedBox(width: 16),
                        Expanded(child: _buildBeaker('Beaker B', '10 ml', 'NAOH')),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Test tubes row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTestTube('Tube 1'),
                        const SizedBox(width: 16),
                        _buildTestTube('Tube 2'),
                        const SizedBox(width: 16),
                        _buildTestTube('Tube 3'),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Bunsen burner
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF9A825), // Orange generic burner flame color
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Color(0xFFFFC107), blurRadius: 15, spreadRadius: 5),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Bunsen Burner',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Action Buttons Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildActionButton('React'),
                        _buildActionButton('Add'),
                        _buildActionButton('Transfer'),
                        _buildActionButton('Reset'),
                      ],
                    ),
                  ],
                ),
              ),

              // Chemical Inventory Section
              Container(
                color: const Color(0xFF67B9C7), // Slightly darker than top part
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Chemical Inventory (22 bahan)',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3.2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: _chemicals.length,
                      itemBuilder: (context, index) {
                        return _buildChemicalItem(_chemicals[index]);
                      },
                    ),
                  ],
                ),
              ),

              // Molar Mass Calculator Section
              Container(
                color: const Color(0xFF71C5D3),
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2), // Glass pane background
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Kalkulator Massa Molar',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 16),
                      // Input Field Simulation
                      Container(
                        height: 48,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4DB0C4),
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Keypad
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: _calcKeys.map((key) {
                          bool isClearOrHitung = key == 'Clear' || key == '+ Hitung';
                          return Container(
                            width: isClearOrHitung ? 80 : 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: key == '+ Hitung' ? const Color(0xFF7897A4) : const Color(0xFF4DB0C4),
                              borderRadius: BorderRadius.circular(21),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              key,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      // Result Panel
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: const [
                            Text(
                              '18.015 g/mol',
                              style: TextStyle(
                                color: Color(0xFF003B73),
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'H2O = 18.015 g/mol',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Info Box
              Container(
                color: const Color(0xFF00A2C2),
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Pilih bahan dan klik react',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Campurkan dua bahan kimia untuk melihat reaksinya.',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('Diperbarui data web', style: TextStyle(fontSize: 10)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBeaker(String title, String vol, String chemical) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2), // Dark grey-blue
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 12),
          // Graphic beaker
          Container(
            height: 70,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
            ),
          ),
          const SizedBox(height: 16),
          Text(vol, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12)),
          Text(chemical, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildTestTube(String title) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 2),
          ),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _buildActionButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, fontSize: 12),
      ),
    );
  }

  Widget _buildChemicalItem(Map<String, dynamic> chem) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF4DB0C4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: chem['color'],
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chem['formula'],
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 13),
                ),
                Text(
                  chem['name'],
                  style: const TextStyle(color: Colors.white, fontSize: 8),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Text(
            '100 ml',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
