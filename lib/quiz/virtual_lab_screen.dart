import 'package:flutter/material.dart';

class VirtualLabScreen extends StatefulWidget {
  final Map<String, dynamic> questionData;
  final Function(bool isCorrect) onResult;

  const VirtualLabScreen({super.key, required this.questionData, required this.onResult});

  @override
  State<VirtualLabScreen> createState() => _VirtualLabScreenState();
}

class _VirtualLabScreenState extends State<VirtualLabScreen> {
  String? _selectedA;
  String? _selectedB;
  bool _isMixed = false;
  int? _selectedConclusionIndex;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuestionCard(),
          const SizedBox(height: 24),
          _buildLabWorkbench(),
          const SizedBox(height: 24),
          _buildInventoryGrid(),
          const SizedBox(height: 24),
          _buildMixResetButtons(),
          const SizedBox(height: 24),
          if (_isMixed) ...[
            _buildObservasiLab(),
            const SizedBox(height: 32),
            const Text('PILIH KESIMPULAN:', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildConclusionOptions(),
          ],
          const SizedBox(height: 120), // Padding for parent footer
        ],
      ),
    );
  }

  Widget _buildQuestionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF151D1F),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.questionData['question_text'] ?? 'Lakukan eksperimen: Campurkan HCl dan NaOH di lab virtual! Apa yang kamu amati?',
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, height: 1.4),
              ),
            ],
          ),
          const Positioned(
            top: 0, right: 0,
            child: Icon(Icons.lightbulb_outline, color: Colors.white10, size: 48),
          ),
        ],
      ),
    );
  }

  Widget _buildLabWorkbench() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _beaker('GELAS A (HCl)', _selectedA != null, const Color(0xFF1A3D41)),
          const Text('+', style: TextStyle(color: Color(0xFF00FBFF), fontSize: 24, fontWeight: FontWeight.bold)),
          _beaker('GELAS B (NaOH)', _selectedB != null, const Color(0xFF1A3D41)),
          const Text('=', style: TextStyle(color: Color(0xFF00FBFF), fontSize: 24, fontWeight: FontWeight.bold)),
          _beaker('GELAS C (HASIL)', _isMixed, const Color(0xFF5A6B1C), isResult: true),
        ],
      ),
    );
  }

  Widget _beaker(String label, bool hasLiquid, Color liquidColor, {bool isResult = false}) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: 75, height: 95,
              decoration: BoxDecoration(
                border: Border.all(color: isResult ? const Color(0xFFCCFF00).withOpacity(0.3) : Colors.white10, width: 2),
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
              ),
            ),
            if (hasLiquid)
              Container(
                width: 71, height: isResult ? 65 : 45,
                margin: const EdgeInsets.only(bottom: 2),
                decoration: BoxDecoration(
                  color: liquidColor,
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                  boxShadow: isResult ? [BoxShadow(color: liquidColor.withOpacity(0.5), blurRadius: 15)] : null,
                ),
                child: isResult ? const Center(child: Icon(Icons.grid_view_rounded, color: Color(0xFFCCFF00), size: 16)) : null,
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: isResult ? const Color(0xFFCCFF00) : Colors.white38, fontSize: 9, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildInventoryGrid() {
    final chemicals = [
      {'name': 'HCl', 'type': 'ASAM'},
      {'name': 'NaOH', 'type': 'BASA'},
      {'name': 'AgNO3', 'type': 'GARAM'},
      {'name': 'NaCl', 'type': 'GARAM'},
      {'name': 'Zn', 'type': 'LOGAM'},
      {'name': 'H2SO4', 'type': 'ASAM'},
      {'name': 'CuSO4', 'type': 'GARAM'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('REAGENT INVENTORY', style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1),
          itemCount: chemicals.length,
          itemBuilder: (context, index) {
            final c = chemicals[index];
            bool isSelected = _selectedA == c['name'] || _selectedB == c['name'];
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    if (_selectedA == c['name']) _selectedA = null;
                    else _selectedB = null;
                  } else {
                    if (_selectedA == null) _selectedA = c['name'];
                    else if (_selectedB == null) _selectedB = c['name'];
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF00FBFF).withOpacity(0.1) : const Color(0xFF151D1F),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSelected ? const Color(0xFF00FBFF) : Colors.transparent),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(c['name']!, style: TextStyle(color: isSelected ? const Color(0xFF00FBFF) : Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 4),
                    Text(c['type']!, style: TextStyle(color: isSelected ? const Color(0xFF00FBFF).withOpacity(0.5) : Colors.white12, fontSize: 9, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMixResetButtons() {
    final config = widget.questionData['lab_practice_config'] ?? {};
    return Row(
      children: [
        Expanded(child: _labButton('Mix & react', () {
          if (_selectedA != null && _selectedB != null && !_isMixed) {
            setState(() => _isMixed = true);
            
            // Check if it's the correct answer and report to parent
            final expectedA = config['beaker_a_chemical'];
            final expectedB = config['beaker_b_chemical'];
            bool isCorrect = (_selectedA == expectedA && _selectedB == expectedB) || 
                             (_selectedA == expectedB && _selectedB == expectedA);
            widget.onResult(isCorrect);
          }
        })),
        const SizedBox(width: 12),
        Expanded(child: _labButton('Reset', () => setState(() { _isMixed = false; _selectedA = null; _selectedB = null; _selectedConclusionIndex = null; }))),
      ],
    );
  }

  Widget _labButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFF0D47A1).withOpacity(0.4),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF0D47A1).withOpacity(0.6)),
        ),
        alignment: Alignment.center,
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildObservasiLab() {
    final result = _getReactionResult();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF151D1F),
        borderRadius: BorderRadius.circular(20),
        border: const Border(left: BorderSide(color: Color(0xFFCCFF00), width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.assignment_outlined, color: Color(0xFFCCFF00), size: 14),
              SizedBox(width: 8),
              Text('OBSERVASI LAB', style: TextStyle(color: Color(0xFFCCFF00), fontSize: 10, fontWeight: FontWeight.w900)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(result['equation']!, style: const TextStyle(color: Color(0xFFCCFF00), fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('"${result['visual']!}"', style: const TextStyle(color: Colors.white70, fontSize: 16, fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Map<String, String> _getReactionResult() {
    final config = widget.questionData['lab_practice_config'] ?? {};
    // Exact match for the question's expected reagents
    final expectedA = config['beaker_a_chemical'];
    final expectedB = config['beaker_b_chemical'];
    if ((_selectedA == expectedA && _selectedB == expectedB) ||
        (_selectedA == expectedB && _selectedB == expectedA)) {
      return {
        'visual': config['expected_visual_result'] ?? 'Larutan bereaksi',
        'equation': config['expected_reaction_equation'] ?? 'Reaksi terjadi',
      };
    }

    // Predefined dictionary
    final mix = <String>[_selectedA ?? '', _selectedB ?? ''];
    mix.sort(); // sort alphabetically to check combinations
    final combo = mix.join(' + ');

    if (combo == 'HCl + NaOH') return {'visual': '💧 Larutan bening + sedikit hangat', 'equation': 'HCl + NaOH → NaCl + H₂O'};
    if (combo == 'AgNO3 + NaCl') return {'visual': '☁️ Endapan PUTIH (AgCl) mengendap', 'equation': 'AgNO₃ + NaCl → AgCl↓ + NaNO₃'};
    if (combo == 'HCl + Zn') return {'visual': '💨 Gelembung GAS HIDROGEN (H₂)', 'equation': 'Zn + 2HCl → ZnCl₂ + H₂↑'};
    if (combo == 'CuSO4 + Zn') return {'visual': '🔴 Endapan MERAH TEMBAGA (Cu) + larutan tidak berwarna', 'equation': 'Zn + CuSO₄ → ZnSO₄ + Cu↓'};
    if (combo == 'H2SO4 + NaOH') return {'visual': '💧 Larutan bening + melepaskan panas', 'equation': 'H₂SO₄ + 2NaOH → Na₂SO₄ + 2H₂O'};
    if (combo == 'AgNO3 + HCl') return {'visual': '☁️ Endapan PUTIH (AgCl)', 'equation': 'HCl + AgNO₃ → AgCl↓ + HNO₃'};
    if (combo == 'H2SO4 + Zn') return {'visual': '💨 Gelembung GAS HIDROGEN (H₂)', 'equation': 'Zn + H₂SO₄ → ZnSO₄ + H₂↑'};

    return {'visual': 'Tidak ada reaksi yang terlihat (No reaction)', 'equation': '${_selectedA ?? '?'} + ${_selectedB ?? '?'} → Tidak Bereaksi'};
  }

  Widget _buildConclusionOptions() {
    final options = [
      'Terbentuk endapan putih dan suhu menurun secara drastis.',
      'Terjadi reaksi netralisasi yang menghasilkan garam dan air serta melepaskan kalor.',
      'Terbentuk gas hidrogen yang ditandai dengan adanya gelembung.',
      'Larutan berubah menjadi berwarna biru karena pembentukan kompleks.',
    ];

    return Column(
      children: List.generate(options.length, (index) {
        bool isSelected = _selectedConclusionIndex == index;
        return GestureDetector(
          onTap: () => setState(() => _selectedConclusionIndex = index),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF151D1F),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: isSelected ? const Color(0xFF00FBFF) : Colors.transparent),
            ),
            child: Row(
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(8)),
                  alignment: Alignment.center,
                  child: Text(String.fromCharCode(65 + index), style: const TextStyle(color: Color(0xFF00FBFF), fontWeight: FontWeight.w900)),
                ),
                const SizedBox(width: 16),
                Expanded(child: Text(options[index], style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.3))),
                if (isSelected) const Icon(Icons.check_circle, color: Color(0xFF00FBFF), size: 24),
              ],
            ),
          ),
        );
      }),
    );
  }
}
