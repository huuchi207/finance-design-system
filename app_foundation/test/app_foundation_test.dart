import 'package:flutter_test/flutter_test.dart';
import 'package:app_foundation/app_foundation.dart';

void main() {
  // ═══════════════════════════════════════════════════════════════════
  // DATA LOADING STATE
  // ═══════════════════════════════════════════════════════════════════
  group('DataLoadingState', () {
    test('initial state flags', () {
      const state = DataLoadingState<String>.initial();
      expect(state.isLoading, false);
      expect(state.isLoaded, false);
      expect(state.isError, false);
    });

    test('loading state flags', () {
      const state = DataLoadingState<String>.loading();
      expect(state.isLoading, true);
      expect(state.isLoaded, false);
      expect(state.isError, false);
    });

    test('loaded state flags and data', () {
      const state = DataLoadingState<String>.loaded('hello');
      expect(state.isLoaded, true);
      expect(state.isLoading, false);
      expect(state.isError, false);
    });

    test('empty state flags', () {
      const state = DataLoadingState<String>.empty();
      expect(state.isLoading, false);
      expect(state.isLoaded, false);
      expect(state.isError, false);
    });

    test('error state flags and message', () {
      const state = DataLoadingState<String>.error('Network failure');
      expect(state.isError, true);
      expect(state.isLoading, false);
      expect(state.isLoaded, false);
    });

    group('when()', () {
      test('dispatches initial', () {
        const state = DataLoadingState<String>.initial();
        final result = state.when(
          initial: () => 'init',
          loading: () => 'load',
          loaded: (d) => 'data:$d',
          empty: () => 'empty',
          error: (m) => 'err:$m',
        );
        expect(result, 'init');
      });

      test('dispatches loading', () {
        const state = DataLoadingState<int>.loading();
        final result = state.when(
          initial: () => 0,
          loading: () => 1,
          loaded: (d) => 2,
          empty: () => 3,
          error: (m) => 4,
        );
        expect(result, 1);
      });

      test('dispatches loaded with data', () {
        const state = DataLoadingState<String>.loaded('payload');
        final result = state.when(
          initial: () => 'init',
          loading: () => 'load',
          loaded: (d) => 'loaded:$d',
          empty: () => 'empty',
          error: (m) => 'err:$m',
        );
        expect(result, 'loaded:payload');
      });

      test('dispatches empty', () {
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

      test('dispatches error with message', () {
        const state = DataLoadingState<int>.error('timeout');
        final result = state.when(
          initial: () => 'i',
          loading: () => 'l',
          loaded: (d) => 'd',
          empty: () => 'e',
          error: (m) => 'err:$m',
        );
        expect(result, 'err:timeout');
      });
    });

    test('DataLoadingLoaded stores data correctly', () {
      const state = DataLoadingLoaded<String>('test');
      expect(state.data, 'test');
    });

    test('DataLoadingError stores message correctly', () {
      const state = DataLoadingError<String>('msg');
      expect(state.message, 'msg');
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // FIN ERROR HANDLER — suggestMode
  // ═══════════════════════════════════════════════════════════════════
  group('FinErrorHandler.suggestMode', () {
    test('blocking error returns dialog', () {
      expect(
        FinErrorHandler.suggestMode(isBlocking: true),
        FinErrorDisplayMode.dialog,
      );
    });

    test('network error returns dialog', () {
      expect(
        FinErrorHandler.suggestMode(isNetworkError: true),
        FinErrorDisplayMode.dialog,
      );
    });

    test('blocking + network returns dialog', () {
      expect(
        FinErrorHandler.suggestMode(isBlocking: true, isNetworkError: true),
        FinErrorDisplayMode.dialog,
      );
    });

    test('validation error returns inline', () {
      expect(
        FinErrorHandler.suggestMode(isValidationError: true),
        FinErrorDisplayMode.inline,
      );
    });

    test('default returns toast', () {
      expect(
        FinErrorHandler.suggestMode(),
        FinErrorDisplayMode.toast,
      );
    });

    test('blocking takes priority over validation', () {
      expect(
        FinErrorHandler.suggestMode(
            isBlocking: true, isValidationError: true),
        FinErrorDisplayMode.dialog,
      );
    });

    test('network takes priority over validation', () {
      expect(
        FinErrorHandler.suggestMode(
            isNetworkError: true, isValidationError: true),
        FinErrorDisplayMode.dialog,
      );
    });
  });

  group('FinErrorDisplayMode', () {
    test('has 3 modes', () {
      expect(FinErrorDisplayMode.values.length, 3);
      expect(FinErrorDisplayMode.values,
          containsAll([
            FinErrorDisplayMode.inline,
            FinErrorDisplayMode.dialog,
            FinErrorDisplayMode.toast,
          ]));
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // FIN RETRY
  // ═══════════════════════════════════════════════════════════════════
  group('FinRetry.execute', () {
    test('returns immediately on first success', () async {
      var callCount = 0;
      final result = await FinRetry.execute(
        operation: () async {
          callCount++;
          return 42;
        },
        maxAttempts: 3,
        initialDelay: const Duration(milliseconds: 1),
      );
      expect(result, 42);
      expect(callCount, 1);
    });

    test('retries on failure and succeeds', () async {
      var callCount = 0;
      final result = await FinRetry.execute(
        operation: () async {
          callCount++;
          if (callCount < 3) throw Exception('fail');
          return 'ok';
        },
        maxAttempts: 3,
        initialDelay: const Duration(milliseconds: 1),
        backoffMultiplier: 1.0,
      );
      expect(result, 'ok');
      expect(callCount, 3);
    });

    test('rethrows after max attempts exceeded', () async {
      var callCount = 0;
      expect(
        () => FinRetry.execute(
          operation: () async {
            callCount++;
            throw Exception('always fails');
          },
          maxAttempts: 2,
          initialDelay: const Duration(milliseconds: 1),
        ),
        throwsException,
      );
    });

    test('applies exponential backoff', () async {
      final timestamps = <DateTime>[];
      var callCount = 0;

      try {
        await FinRetry.execute(
          operation: () async {
            timestamps.add(DateTime.now());
            callCount++;
            throw Exception('fail');
          },
          maxAttempts: 3,
          initialDelay: const Duration(milliseconds: 50),
          backoffMultiplier: 2.0,
        );
      } catch (_) {}

      expect(callCount, 3);
      // Second retry should have waited longer than first
      if (timestamps.length >= 3) {
        final gap1 =
            timestamps[1].difference(timestamps[0]).inMilliseconds;
        final gap2 =
            timestamps[2].difference(timestamps[1]).inMilliseconds;
        expect(gap2 >= gap1, true,
            reason: 'Backoff should increase delay');
      }
    });

    test('single attempt rethrows immediately', () async {
      expect(
        () => FinRetry.execute(
          operation: () async => throw StateError('oops'),
          maxAttempts: 1,
          initialDelay: const Duration(milliseconds: 1),
        ),
        throwsStateError,
      );
    });
  });
}
