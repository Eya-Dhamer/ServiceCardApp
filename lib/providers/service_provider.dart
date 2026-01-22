import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_7/models/service.dart';

final servicesProvider = Provider<List<Service>>((ref) {
  return Service.mockServices;
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final selectedCategoryProvider = StateProvider<String>((ref) => 'All');

final filteredServicesProvider = Provider<List<Service>>((ref) {
  final services = ref.watch(servicesProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final category = ref.watch(selectedCategoryProvider);

  return services.where((service) {
    final matchesQuery = service.title.toLowerCase().contains(query) ||
        service.provider.toLowerCase().contains(query);
    final matchesCategory = category == 'All' || service.category == category;
    return matchesQuery && matchesCategory;
  }).toList();
});

final categoriesProvider = Provider<List<String>>((ref) {
  final services = ref.watch(servicesProvider);
  final categories = services.map((s) => s.category).toSet().toList();
  return ['All', ...categories];
});
