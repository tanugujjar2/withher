import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PcosCaregiverCompanionApp());
}

class PcosCaregiverCompanionApp extends StatelessWidget {
  const PcosCaregiverCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFFE7B7D8); // pastel pink-lilac
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.light,
    ).copyWith(
      primary: const Color(0xFF8E5EA7),
      secondary: const Color(0xFF5DA6A7),
      tertiary: const Color(0xFFF0B67F),
      surface: const Color(0xFFFFFBFF),
      surfaceContainerHighest: const Color(0xFFF6EEF7),
    );

    return MaterialApp(
      title: 'Care Companion for PCOS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: scheme.surface,
        appBarTheme: AppBarTheme(
          backgroundColor: scheme.surface,
          foregroundColor: scheme.onSurface,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: scheme.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        cardTheme: CardThemeData(
          color: scheme.surfaceContainerHighest,
          elevation: 0,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: scheme.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const _HomeTab(),
      const _LearnTab(),
      const _EmpathyTab(),
      const _SupportTab(),
      const _TrackerTab(),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (v) => setState(() => _index = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.menu_book_rounded), label: 'Learn'),
          NavigationDestination(icon: Icon(Icons.favorite_rounded), label: 'Empathy'),
          NavigationDestination(icon: Icon(Icons.handshake_rounded), label: 'Support'),
          NavigationDestination(icon: Icon(Icons.track_changes_rounded), label: 'Tracker'),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
          if (subtitle != null) ...[
            const SizedBox(height: 6),
            Text(subtitle!, style: TextStyle(color: cs.onSurface.withValues(alpha: 0.75))),
          ],
        ],
      ),
    );
  }
}

class _SoftCard extends StatelessWidget {
  const _SoftCard({
    required this.title,
    required this.body,
    this.icon,
    this.footer,
  });

  final String title;
  final String body;
  final IconData? icon;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null)
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: cs.primary.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icon, color: cs.primary),
                  ),
                if (icon != null) const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(body, style: TextStyle(color: cs.onSurface.withValues(alpha: 0.85), height: 1.35)),
            if (footer != null) ...[
              const SizedBox(height: 12),
              footer!,
            ],
          ],
        ),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        _Header(
          title: 'A caring companion',
          subtitle: 'For partners & family learning to support PCOS/PCOD with empathy, clarity, and kindness.',
        ),
        _SoftCard(
          icon: Icons.spa_rounded,
          title: 'Today’s gentle intention',
          body: 'Small supportive actions matter. Try: “I’m here with you—what would feel lighter right now?”',
        ),
        _SoftCard(
          icon: Icons.lightbulb_rounded,
          title: 'Quick learning (2 minutes)',
          body: 'PCOS/PCOD can affect hormones, energy, mood, and self-image. It’s real—even when it’s invisible.',
        ),
        _SoftCard(
          icon: Icons.favorite_border_rounded,
          title: 'Empathy simulator',
          body: 'Explore possible “invisible” experiences so your support feels more tuned-in and less frustrating.',
        ),
        SizedBox(height: 8),
      ],
    );
  }
}

class _LearnTab extends StatelessWidget {
  const _LearnTab();

  @override
  Widget build(BuildContext context) {
    final hormoneCards = [
      const _MiniCard(
        title: 'Insulin (energy helper)',
        body: 'When insulin support is off, energy can crash and cravings can spike. It’s not “no willpower.”',
        tip: 'Support: offer steady meals/snacks and avoid judgmental food talk.',
      ),
      const _MiniCard(
        title: 'Androgens (often called “male hormones”)',
        body: 'Higher levels can affect skin, hair, and confidence. That can feel embarrassing or exhausting.',
        tip: 'Support: avoid “fixing” comments; give reassurance and privacy.',
      ),
      const _MiniCard(
        title: 'Cortisol (stress hormone)',
        body: 'High stress can make the body feel on-edge. Small problems can feel huge.',
        tip: 'Support: reduce pressure; offer calm first, solutions later.',
      ),
      const _MiniCard(
        title: 'Estrogen & progesterone (cycle hormones)',
        body: 'When cycles are irregular, emotions and energy can feel unpredictable.',
        tip: 'Support: plan with flexibility; don’t take mood shifts personally.',
      ),
    ];

    return ListView(
      children: [
        const _Header(
          title: 'Learn, softly',
          subtitle: 'Simple explanations, minimal jargon, and a focus on how it can feel.',
        ),
        const _SoftCard(
          icon: Icons.compare_arrows_rounded,
          title: 'PCOS vs PCOD (quick comparison)',
          body:
              '“PCOS” is commonly used. “PCOD” is sometimes used in some regions to describe similar patterns. Either way, it’s not a character flaw—it’s a health condition that can affect cycles, skin, weight, mood, and fertility.',
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A helpful way to think about it',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _PillCompareCard(
                        title: 'PCOS',
                        bullets: const [
                          'A pattern of symptoms + hormone imbalance',
                          'Can affect periods, skin, hair, weight, mood',
                          'Often linked with insulin resistance',
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _PillCompareCard(
                        title: 'PCOD',
                        bullets: const [
                          'A term used in some places for similar patterns',
                          'Often overlaps with PCOS',
                          'The support you give stays the same: kindness + steadiness',
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const _SoftCard(
          icon: Icons.insights_rounded,
          title: 'Normal vs PCOS hormones & mood',
          body:
              'Hormones can shift how the body uses energy and handles stress. That can show up as fatigue, irritability, anxiety, brain fog, or feeling “not myself.” It’s not an excuse—it’s context.',
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '“Typical day” vs “hard day”',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Expanded(
                      child: _PillCompareCard(
                        title: 'Typical day',
                        bullets: [
                          'Energy is more predictable',
                          'Mood changes are easier to regulate',
                          'Confidence feels steadier',
                        ],
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _PillCompareCard(
                        title: 'Hard PCOS/PCOD day',
                        bullets: [
                          'Fatigue, fog, irritability can spike',
                          'Body feels “not cooperating”',
                          'Self-criticism can get louder',
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const _SoftCard(
          icon: Icons.psychology_alt_rounded,
          title: 'Mental health awareness',
          body:
              'PCOS/PCOD can connect to anxiety, low mood, body-image stress, and burnout. Your role isn’t to fix it—your role is to be safe: listen, validate, and offer steady support.',
        ),
        const _Header(
          title: 'Hormone mini-cards',
          subtitle: 'Tiny explanations + how to support (without trying to “fix”).',
        ),
        SizedBox(
          height: 230,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) => hormoneCards[i],
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemCount: hormoneCards.length,
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}

class _PillCompareCard extends StatelessWidget {
  const _PillCompareCard({required this.title, required this.bullets});

  final String title;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.primary.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900)),
          const SizedBox(height: 10),
          for (final b in bullets) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Icon(Icons.circle, size: 8, color: cs.primary.withValues(alpha: 0.65)),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(b, style: TextStyle(color: cs.onSurface.withValues(alpha: 0.86)))),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _MiniCard extends StatelessWidget {
  const _MiniCard({required this.title, required this.body, required this.tip});

  final String title;
  final String body;
  final String tip;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: 280,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cs.primary.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900)),
          const SizedBox(height: 10),
          Text(body, style: TextStyle(color: cs.onSurface.withValues(alpha: 0.86), height: 1.35)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(tip, style: TextStyle(color: cs.onSurface.withValues(alpha: 0.88))),
          ),
        ],
      ),
    );
  }
}

class _EmpathyTab extends StatefulWidget {
  const _EmpathyTab();

  @override
  State<_EmpathyTab> createState() => _EmpathyTabState();
}

class _EmpathyTabState extends State<_EmpathyTab> {
  double _intensity = 0.5;

  @override
  Widget build(BuildContext context) {
    final sim = _EmpathySimulator.generate(DateTime.now(), _intensity);

    return ListView(
      children: [
        const _Header(
          title: 'Daily empathy simulator',
          subtitle: 'Not a diagnosis—just a gentle way to understand possible experiences.',
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Intensity', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text('Adjust to imagine “milder” to “harder” days.', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 10),
                Slider(
                  value: _intensity,
                  onChanged: (v) => setState(() => _intensity = v),
                ),
              ],
            ),
          ),
        ),
        _SoftCard(
          icon: Icons.brightness_5_rounded,
          title: 'Possible emotional weather',
          body: sim.emotional,
        ),
        _SoftCard(
          icon: Icons.health_and_safety_rounded,
          title: 'Possible physical state',
          body: sim.physical,
        ),
        _SoftCard(
          icon: Icons.forum_rounded,
          title: 'A supportive line you can use',
          body: sim.supportLine,
          footer: Align(
            alignment: Alignment.centerLeft,
            child: FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tip saved in your mind is enough for now.')),
                );
              },
              child: const Text('Practice saying it'),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _SupportTab extends StatefulWidget {
  const _SupportTab();

  @override
  State<_SupportTab> createState() => _SupportTabState();
}

class _SupportTabState extends State<_SupportTab> {
  final _selected = <Symptom>{};

  @override
  Widget build(BuildContext context) {
    final suggestions = SupportSuggestionEngine.suggest(_selected.toList());

    return ListView(
      children: [
        const _Header(
          title: 'Support suggestions',
          subtitle: 'Pick what you notice. Get kinder, practical ideas.',
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('What might be showing up today?', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: Symptom.values.map((s) {
                    final selected = _selected.contains(s);
                    return FilterChip(
                      selected: selected,
                      label: Text(s.label),
                      onSelected: (v) => setState(() {
                        if (v) {
                          _selected.add(s);
                        } else {
                          _selected.remove(s);
                        }
                      }),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        _SoftCard(
          icon: Icons.handshake_rounded,
          title: 'What you can do (gentle + useful)',
          body: suggestions.isEmpty
              ? 'Choose a few symptoms above to see suggestions. If you’re unsure, start with: listen, validate, and offer a small help.'
              : suggestions.map((s) => '• $s').join('\n'),
        ),
        const _SoftCard(
          icon: Icons.block_rounded,
          title: 'What not to say',
          body:
              '“You’re overreacting.”\n“Just calm down.”\n“It’s all in your head.”\n“Why can’t you be normal?”\n“You should just try harder.”\n\nSwap with: “I believe you.” “That sounds heavy.” “How can I support you right now?”',
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _TrackerTab extends StatelessWidget {
  const _TrackerTab();

  @override
  Widget build(BuildContext context) {
    return const _TrackerScreen();
  }
}

// ---- Empathy simulator + suggestion engine (local, lightweight) ----

class _EmpathySnapshot {
  const _EmpathySnapshot({
    required this.emotional,
    required this.physical,
    required this.supportLine,
  });

  final String emotional;
  final String physical;
  final String supportLine;
}

class _EmpathySimulator {
  static _EmpathySnapshot generate(DateTime date, double intensity01) {
    final seed = date.year * 10000 + date.month * 100 + date.day;
    final i = (intensity01.clamp(0, 1) * 100).round();
    final pick = (seed + i) % 5;

    final emotional = [
      'A tender day: feeling extra sensitive, easily overwhelmed, needing reassurance.',
      'A foggy day: low focus, low patience, feeling frustrated with myself.',
      'A restless day: anxious energy, worry spirals, needing calm and grounding.',
      'A flat day: low mood, low motivation, needing gentle company—not pressure.',
      'A sharp day: irritability popping up fast, needing space + kindness together.',
    ][pick];

    final physical = [
      'Energy dips, cravings, and heaviness—small tasks can feel big.',
      'Bloating or discomfort, headaches, and a “not comfy in my body” feeling.',
      'Fatigue + poor sleep. Even after rest, the body may still feel tired.',
      'Skin/hair stress can affect confidence—mirror moments can sting.',
      'Body feels unpredictable—pain, appetite changes, or sudden exhaustion.',
    ][(pick + 2) % 5];

    final supportLine = [
      '“We don’t have to solve everything today. I’m here with you.”',
      '“Do you want comfort, help, or just company?”',
      '“I believe you. Tell me what would feel supportive right now.”',
      '“Let’s make today smaller. One gentle step at a time.”',
      '“If you need space, I’ll give it—if you need closeness, I’m here.”',
    ][(pick + 1) % 5];

    return _EmpathySnapshot(emotional: emotional, physical: physical, supportLine: supportLine);
  }
}

enum Symptom {
  fatigue('Low energy'),
  moodSwings('Mood swings'),
  anxiety('Anxiety'),
  cravings('Cravings'),
  bloating('Bloating/discomfort'),
  acne('Skin breakouts'),
  hairStress('Hair concerns'),
  brainFog('Brain fog'),
  lowSelfImage('Low self-image'),
  irregularCycle('Irregular cycles');

  const Symptom(this.label);
  final String label;
}

class SupportSuggestionEngine {
  static List<String> suggest(List<Symptom> symptoms) {
    final out = <String>{};

    if (symptoms.contains(Symptom.fatigue) || symptoms.contains(Symptom.brainFog)) {
      out.add('Offer a “low-effort” day: handle one chore, keep plans simple, reduce decision fatigue.');
      out.add('Ask before advice: “Do you want solutions or just support?”');
    }

    if (symptoms.contains(Symptom.moodSwings) || symptoms.contains(Symptom.anxiety)) {
      out.add('Use validation first: “That makes sense. I’m with you.”');
      out.add('Lower stimulation: quieter space, warm drink, short walk if they want.');
    }

    if (symptoms.contains(Symptom.cravings)) {
      out.add('Avoid food-policing. Offer choices: “Want something comforting or something light?”');
    }

    if (symptoms.contains(Symptom.bloating)) {
      out.add('Suggest comfort: loose clothing, heat pack, gentle movement, or rest.');
    }

    if (symptoms.contains(Symptom.acne) || symptoms.contains(Symptom.hairStress) || symptoms.contains(Symptom.lowSelfImage)) {
      out.add('Compliment character over appearance. Avoid “fixing” comments unless asked.');
      out.add('Offer reassurance: “You’re not alone in this—and you don’t owe anyone looking perfect.”');
    }

    if (symptoms.contains(Symptom.irregularCycle)) {
      out.add('Be patient with uncertainty. Offer planning flexibility and emotional steadiness.');
    }

    out.add('If distress feels intense or ongoing, gently suggest professional support—without pressure.');

    return out.toList();
  }
}

// ---- Relationship support tracker (screen only; persistence added next) ----

class _TrackerScreen extends StatefulWidget {
  const _TrackerScreen();

  @override
  State<_TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<_TrackerScreen> {
  final _noteController = TextEditingController();
  final List<_SupportLogEntry> _entries = [];
  bool _loading = true;

  static const _prefsKey = 'support_log_entries_v1';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw == null || raw.trim().isEmpty) {
      if (!mounted) return;
      setState(() => _loading = false);
      return;
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        _entries
          ..clear()
          ..addAll(decoded.whereType<Map<String, dynamic>>().map(_SupportLogEntry.fromJson));
      }
    } catch (_) {
      // If something goes wrong, we simply start fresh.
      _entries.clear();
    }

    if (!mounted) return;
    setState(() => _loading = false);
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_entries.map((e) => e.toJson()).toList());
    await prefs.setString(_prefsKey, encoded);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const _Header(
          title: 'Relationship support tracker',
          subtitle: 'A private space to reflect: what helped, what to try, what to avoid.',
        ),
        if (_loading)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add a small support action', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),
                TextField(
                  controller: _noteController,
                  textInputAction: TextInputAction.done,
                  minLines: 1,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Example: “I listened without interrupting.”',
                  ),
                ),
                const SizedBox(height: 10),
                FilledButton(
                  onPressed: () {
                    final text = _noteController.text.trim();
                    if (text.isEmpty) return;
                    setState(() {
                      _entries.insert(0, _SupportLogEntry(timestamp: DateTime.now(), note: text));
                      _noteController.clear();
                    });
                    _save();
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
        if (_entries.isEmpty)
          const _SoftCard(
            icon: Icons.hourglass_empty_rounded,
            title: 'Nothing logged yet',
            body: 'When you log small supportive moments, you build consistency—and trust.',
          )
        else
          ..._entries.map((e) => _SoftCard(
                icon: Icons.check_circle_outline_rounded,
                title: _formatDay(e.timestamp),
                body: e.note,
              )),
        const SizedBox(height: 8),
      ],
    );
  }

  static String _formatDay(DateTime dt) {
    return DateFormat('EEE, d MMM').format(dt);
  }
}

class _SupportLogEntry {
  const _SupportLogEntry({required this.timestamp, required this.note});
  final DateTime timestamp;
  final String note;

  Map<String, dynamic> toJson() => {
        'ts': timestamp.toIso8601String(),
        'note': note,
      };

  static _SupportLogEntry fromJson(Map<String, dynamic> json) {
    final tsRaw = json['ts'];
    final noteRaw = json['note'];
    return _SupportLogEntry(
      timestamp: DateTime.tryParse(tsRaw is String ? tsRaw : '') ?? DateTime.now(),
      note: noteRaw is String ? noteRaw : '',
    );
  }
}
