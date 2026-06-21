import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/core/localization/app_localizations.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;
  final String title;
  final VoidCallback? onClose;

  const AudioPlayerWidget({
    super.key,
    required this.audioUrl,
    required this.title,
    this.onClose,
  });

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget>
    with SingleTickerProviderStateMixin {
  final AudioPlayer _player = AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  int _speedIndex = 1;
  final _speeds = [0.5, 1.0, 1.5, 2.0];
  bool _hasAudio = false;
  bool _isLoading = false;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _pulseAnimation = CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    );
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    if (widget.audioUrl.isEmpty) {
      setState(() => _hasAudio = false);
      return;
    }
    setState(() => _isLoading = true);
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(widget.audioUrl)));
      _hasAudio = true;

      _player.durationStream.listen((d) {
        if (mounted) setState(() => _duration = d ?? Duration.zero);
      });
      _player.positionStream.listen((p) {
        if (mounted) setState(() => _position = p);
      });
      _player.playerStateStream.listen((state) {
        if (!mounted) return;
        setState(() {
          _isLoading = state.processingState == ProcessingState.loading;
          if (state.playing) {
            _pulseController.repeat(reverse: true);
          } else {
            _pulseController.stop();
            _pulseController.reset();
          }
        });
      });
    } catch (_) {
      if (mounted) setState(() => _hasAudio = false);
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _player.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _togglePlay() {
    if (!_hasAudio) return;
    if (_player.playing) {
      _player.pause();
    } else {
      _player.play();
    }
  }

  void _cycleSpeed() {
    setState(() {
      _speedIndex = (_speedIndex + 1) % _speeds.length;
    });
    _player.setSpeed(_speeds[_speedIndex]);
  }

  String _formatTime(Duration d) {
    final seconds = d.inSeconds;
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  double get _progress => _duration.inSeconds > 0
      ? _position.inSeconds / _duration.inSeconds
      : 0.0;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final remaining = _duration - _position;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXxl)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: AppSpacing.md),
            width: 40, height: 4,
            decoration: BoxDecoration(
              color: AppColors.outline.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.xl, AppSpacing.lg, AppSpacing.xl, 0,
            ),
            child: Row(
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  child: const Center(
                    child: Text('🔊', style: TextStyle(fontSize: 20)),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: AppTypography.titleSmall.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        _isLoading ? t.articleLoading : t.articlePlaying,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.onClose != null)
                  GestureDetector(
                    onTap: widget.onClose,
                    child: Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                      ),
                      child: const Center(
                        child: Icon(Icons.keyboard_arrow_down_rounded,
                            size: 22, color: AppColors.textSecondary),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (_isLoading) ...[
            const SizedBox(height: AppSpacing.xxl),
            const Center(child: CircularProgressIndicator()),
            const SizedBox(height: AppSpacing.xxl),
          ] else if (!_hasAudio) ...[
            const SizedBox(height: AppSpacing.xxl),
            const Center(
              child: Text('🔇', style: TextStyle(fontSize: 40)),
            ),
            const SizedBox(height: AppSpacing.sm),
            Center(
              child: Text(t.articleNoAudio,
                  style: const TextStyle(color: AppColors.textTertiary)),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ] else ...[
            const SizedBox(height: AppSpacing.xxl),
            SizedBox(
              height: 60,
              child: Center(
                child: AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, _) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(40, (i) {
                        final playProgress = i / 40;
                        final isPlayed = playProgress <= _progress;
                        final anim = _player.playing
                            ? (0.6 + _pulseAnimation.value * 0.4)
                            : 0.5;
                        final height = (12 + (i % 5) * 8) * anim;
                        return Container(
                          width: 3,
                          height: height.clamp(4, 52).toDouble(),
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: isPlayed
                                ? AppColors.primary
                                : AppColors.outline.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: Column(
                children: [
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 4,
                      activeTrackColor: AppColors.primary,
                      inactiveTrackColor: AppColors.outline.withValues(alpha: 0.3),
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                      thumbColor: AppColors.primary,
                      overlayColor: AppColors.primary.withValues(alpha: 0.12),
                    ),
                    child: Slider(
                      value: _progress.clamp(0.0, 1.0),
                      onChanged: (v) {
                        final pos = Duration(milliseconds: (v * _duration.inMilliseconds).round());
                        _player.seek(pos);
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatTime(_position),
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '-${_formatTime(remaining)}',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _cycleSpeed,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md, vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                      border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      '${_speeds[_speedIndex]}x',
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.xxl),
                GestureDetector(
                  onTap: _togglePlay,
                  child: AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, _) {
                      final scale = _player.playing ? 1.0 + _pulseAnimation.value * 0.06 : 1.0;
                      return Transform.scale(
                        scale: scale,
                        child: Container(
                          width: 72, height: 72,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.primary, AppColors.primaryDark],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.35),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            _player.playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.xxl),
                GestureDetector(
                  onTap: () => _player.seek(_duration),
                  child: Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                      border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
                    ),
                    child: const Center(
                      child: Text('⏭️', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ],
      ),
    );
  }
}
