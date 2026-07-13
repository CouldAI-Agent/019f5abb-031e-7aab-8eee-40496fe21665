import 'package:flutter/material.dart';

void main() {
  runApp(const PlasticReductionApp());
}

class PlasticReductionApp extends StatelessWidget {
  const PlasticReductionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plastic Reduction Report',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          primary: Colors.teal,
          secondary: Colors.lightGreen,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AppShell(),
      },
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    OverviewPage(),
    StatisticsPage(),
    ActionPlanPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      appBar: isDesktop
          ? null
          : AppBar(
              title: const Text('Plastic Reduction Project'),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
      body: Row(
        children: [
          if (isDesktop)
            NavigationRail(
              extended: true,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.dashboard),
                  label: Text('Overview'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.bar_chart),
                  label: Text('Statistics'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.list_alt),
                  label: Text('Action Plan'),
                ),
              ],
            ),
          if (isDesktop) const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
      bottomNavigationBar: isDesktop
          ? null
          : NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.dashboard),
                  label: 'Overview',
                ),
                NavigationDestination(
                  icon: Icon(Icons.bar_chart),
                  label: 'Statistics',
                ),
                NavigationDestination(
                  icon: Icon(Icons.list_alt),
                  label: 'Action Plan',
                ),
              ],
            ),
    );
  }
}

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          'Project Overview',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Summary of our initiative to reduce single-use plastic consumption across all facilities.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth > 600 ? 3 : 1;
            return GridView.count(
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: constraints.maxWidth > 600 ? 2 : 3,
              children: const [
                _StatCard(
                  title: 'Total Reduced',
                  value: '4,500 kg',
                  icon: Icons.eco,
                  color: Colors.green,
                ),
                _StatCard(
                  title: 'Target Completion',
                  value: '75%',
                  icon: Icons.track_changes,
                  color: Colors.blue,
                ),
                _StatCard(
                  title: 'Active Participants',
                  value: '1,250',
                  icon: Icons.people,
                  color: Colors.orange,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 32),
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent Milestones',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.teal),
                  title: Text('Eliminated plastic bottles in main cafeteria'),
                  subtitle: Text('Achieved on June 15th'),
                ),
                const ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.teal),
                  title: Text('Distributed reusable bags to all employees'),
                  subtitle: Text('Achieved on May 10th'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade700,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          'Usage Statistics',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Monthly Plastic Waste (kg)',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                const _ProgressBar(label: 'January', value: 0.9, amount: '1200'),
                const _ProgressBar(label: 'February', value: 0.8, amount: '1050'),
                const _ProgressBar(label: 'March', value: 0.65, amount: '850'),
                const _ProgressBar(label: 'April', value: 0.5, amount: '600'),
                const _ProgressBar(label: 'May', value: 0.35, amount: '450'),
                const _ProgressBar(label: 'June', value: 0.25, amount: '350'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final String label;
  final double value;
  final String amount;

  const _ProgressBar({
    required this.label,
    required this.value,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text('$amount kg'),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: value,
            minHeight: 12,
            backgroundColor: Colors.grey.shade300,
            color: Color.lerp(Colors.green, Colors.red, value),
            borderRadius: BorderRadius.circular(6),
          ),
        ],
      ),
    );
  }
}

class ActionPlanPage extends StatelessWidget {
  const ActionPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final plans = [
      {'title': 'Phase out plastic cutlery', 'status': 'Completed', 'date': 'Q1 2026'},
      {'title': 'Install water refill stations', 'status': 'In Progress', 'date': 'Q2 2026'},
      {'title': 'Supplier packaging negotiation', 'status': 'Planning', 'date': 'Q3 2026'},
      {'title': 'Zero-waste event policy', 'status': 'Planning', 'date': 'Q4 2026'},
    ];

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          'Action Plan & Roadmap',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 24),
        ...plans.map((plan) {
          final isCompleted = plan['status'] == 'Completed';
          final isInProgress = plan['status'] == 'In Progress';
          
          return Card(
            margin: const EdgeInsets.only(bottom: 12.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: isCompleted
                    ? Colors.green.shade100
                    : isInProgress
                        ? Colors.blue.shade100
                        : Colors.grey.shade200,
                child: Icon(
                  isCompleted
                      ? Icons.check
                      : isInProgress
                          ? Icons.autorenew
                          : Icons.schedule,
                  color: isCompleted
                      ? Colors.green
                      : isInProgress
                          ? Colors.blue
                          : Colors.grey,
                ),
              ),
              title: Text(
                plan['title']!,
                style: TextStyle(
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: Text('${plan['status']} • Target: ${plan['date']}'),
            ),
          );
        }),
      ],
    );
  }
}
