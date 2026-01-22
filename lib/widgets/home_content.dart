import 'package:app_7/providers/service_provider.dart';
import 'package:app_7/theme/app_theme.dart';
import 'package:app_7/widgets/service_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final services = ref.watch(filteredServicesProvider);
    final categories = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            onChanged: (value) =>
                ref.read(searchQueryProvider.notifier).state = value,
            decoration: InputDecoration(
              hintText: 'Search for services...',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.tune_rounded, color: Colors.white),
              ),
            ),
          ),
        ).animate().fadeIn().slideY(begin: -0.1, end: 0),

        // Categories
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = selectedCategory == category;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      ref.read(selectedCategoryProvider.notifier).state =
                          category;
                    }
                  },
                  selectedColor: AppTheme.primaryColor,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : (Theme.of(context).brightness == Brightness.dark ? Colors.white70 : AppTheme.textColor),
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.white10 : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: isSelected ? AppTheme.primaryColor : (Theme.of(context).brightness == Brightness.dark ? Colors.white10 : Colors.grey.shade200),
                    ),
                  ),
                  showCheckmark: false,
                ),
              );
            },
          ),
        ).animate().fadeIn(delay: 200.ms),

        // Services List
        Expanded(
          child: services.isEmpty
              ? const Center(child: Text("No services found"))
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final service = services[index];
                    return ServiceCard(
                      service: service,
                      onTap: () {
                        GoRouter.of(context).push('/details', extra: service);
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
