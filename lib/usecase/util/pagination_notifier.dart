import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef FetchNextItems<T> = Future<PaginatedFetchResult<T>> Function(
  PaginationMeta meta,
);

class PaginationNotifier<T> extends StateNotifier<AsyncValue<List<T>>> {
  PaginationNotifier({
    required this.fetchNextItems,
    this.meta = const PaginationMeta(),
  }) : super(const AsyncValue.loading());

  final FetchNextItems<T> fetchNextItems;
  final List<T> items = [];

  PaginationMeta meta;
  bool get isFinished => !meta.hasMore;

  void init() {
    if (items.isEmpty) {
      fetchFirstBatch();
    }
  }

  List<T> handlePaginationMetaAndUpdateData(PaginatedFetchResult<T> result) {
    meta = result.meta;

    return items..addAll(result.entities);
  }

  Future<void> fetchFirstBatch() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await fetchNextItems(meta);
      return handlePaginationMetaAndUpdateData(result);
    });
  }

  Future<void> fetchNextBatch() async {
    if (items.isNotEmpty && !meta.hasMore) {
      return;
    }

    state = AsyncValue<List<T>>.loading().copyWithPrevious(state);
    state = await AsyncValue.guard(() async {
      final result = await fetchNextItems(meta);
      return handlePaginationMetaAndUpdateData(result);
    });
  }

  void removeItem(T item) {
    items.remove(item);
    state = AsyncValue.data(items);
  }

  void addItem(
    T item, {
    bool prepend = true,
    bool allowDuplicates = false,
  }) {
    if (!allowDuplicates && contains(item)) {
      return;
    }
    items.insert(prepend ? 0 : items.length, item);
    state = AsyncValue.data(items);
  }

  void updateItem({required T oldItem, required T newItem}) {
    final index = items.indexWhere((e) => e == oldItem);
    if (index != -1) {
      items[index] = newItem;
      state = AsyncValue.data(items);
    }
  }

  bool contains(T item) {
    return items.contains(item);
  }
}

class PaginatedFetchResult<T> {
  const PaginatedFetchResult({
    this.entities = const [],
    this.meta = const PaginationMeta(),
  });

  const PaginatedFetchResult.empty()
      : entities = const [],
        meta = const PaginationMeta();

  const PaginatedFetchResult.emptyWithMeta(this.meta) : entities = const [];

  final List<T> entities;
  final PaginationMeta meta;

  PaginatedFetchResult<T> copyWith({
    List<T>? entities,
    PaginationMeta? meta,
  }) {
    return PaginatedFetchResult<T>(
      entities: entities ?? this.entities,
      meta: meta ?? this.meta,
    );
  }
}

class PaginationMeta {
  const PaginationMeta({
    this.hasMore = false,
    this.nextPageToken,
  });

  final bool hasMore;
  final String? nextPageToken;

  PaginationMeta copyWith({
    bool? hasMore,
    String? nextPageToken,
  }) {
    return PaginationMeta(
      hasMore: hasMore ?? this.hasMore,
      nextPageToken: nextPageToken ?? this.nextPageToken,
    );
  }
}
