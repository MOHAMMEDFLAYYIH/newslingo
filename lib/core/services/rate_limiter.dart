class RateLimiter {
  final int maxAttempts;
  final Duration cooldown;

  RateLimiter({this.maxAttempts = 50, this.cooldown = const Duration(minutes: 1)});

  final Map<String, List<DateTime>> _attempts = {};

  bool isLimited(String key) {
    final timestamps = _attempts[key];
    if (timestamps == null || timestamps.isEmpty) return false;
    _prune(key);
    final remaining = _attempts[key] ?? [];
    return remaining.length >= maxAttempts;
  }

  Duration remainingCooldown(String key) {
    final timestamps = _attempts[key];
    if (timestamps == null || timestamps.isEmpty) return Duration.zero;
    final oldest = timestamps.first;
    final elapsed = DateTime.now().difference(oldest);
    if (elapsed >= cooldown) return Duration.zero;
    return cooldown - elapsed;
  }

  void recordAttempt(String key) {
    _attempts.putIfAbsent(key, () => []);
    _attempts[key]!.add(DateTime.now());
    _prune(key);
  }

  void reset(String key) {
    _attempts.remove(key);
  }

  void _prune(String key) {
    final timestamps = _attempts[key];
    if (timestamps == null) return;
    final cutoff = DateTime.now().subtract(cooldown);
    timestamps.removeWhere((t) => t.isBefore(cutoff));
    if (timestamps.isEmpty) _attempts.remove(key);
  }
}
