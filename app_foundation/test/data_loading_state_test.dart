import 'package:flutter_test/flutter_test.dart';
import 'package:app_foundation/app_foundation.dart';

void main() {
  group('DataLoadingState', () {
    test('initial state', () {
      const state = DataLoadingState<String>.initial();
      expect(state.isLoading, false);
      expect(state.isLoaded, false);
      expect(state.isError, false);
    });

    test('loading state', () {
      const state = DataLoadingState<String>.loading();
      expect(state.isLoading, true);
      expect(state.isLoaded, false);
    });

    test('loaded state contains data', () {
      const state = DataLoadingState<String>.loaded('hello');
      expect(state.isLoaded, true);
      expect(state.isLoading, false);
    });

    test('empty state', () {
      const state = DataLoadingState<String>.empty();
      expect(state.isLoading, false);
      expect(state.isLoaded, false);
    });

    test('error state contains message', () {
      const state = DataLoadingState<String>.error('Failed');
      expect(state.isError, true);
      expect(state.isLoading, false);
    });

    test('when() dispatches correctly', () {
      const state = DataLoadingState<String>.loaded('data');
      final result = state.when(
        initial: () => 'initial',
        loading: () => 'loading',
        loaded: (data) => 'loaded: $data',
        empty: () => 'empty',
        error: (msg) => 'error: $msg',
      );
      expect(result, 'loaded: data');
    });

    test('when() handles error', () {
      const state = DataLoadingState<int>.error('network');
      final result = state.when(
        initial: () => 'i',
        loading: () => 'l',
        loaded: (d) => 'loaded',
        empty: () => 'e',
        error: (msg) => 'err: $msg',
      );
      expect(result, 'err: network');
    });

    test('when() handles empty', () {
      const state = DataLoadingState<List<int>>.empty();
      final result = state.when(
        initial: () => 0,
        loading: () => 1,
        loaded: (d) => 2,
        empty: () => 3,
        error: (m) => 4,
      );
      expect(result, 3);
    });
  });
}
