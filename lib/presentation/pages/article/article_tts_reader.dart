import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newslingo/core/di/injection.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/services/article_processor.dart';
import 'package:newslingo/core/services/tts_service.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/domain/entities/text_segment.dart';

class ArticleTtsReader extends StatefulWidget {
  final String title;
  final String content;
  final Color accentColor;
  final String level;
  final List<TextSegment>? segments;

  const ArticleTtsReader({
    super.key,
    required this.title,
    required this.content,
    required this.accentColor,
    required this.level,
    this.segments,
  });

  @override
  State<ArticleTtsReader> createState() => _ArticleTtsReaderState();
}

class _ArticleTtsReaderState extends State<ArticleTtsReader>
    with SingleTickerProviderStateMixin {
  final TtsService _tts = sl<TtsService>();
  final ScrollController _scrollCtrl = ScrollController();
  final GlobalKey _currentKey = GlobalKey();

  late final List<TextSegment> _segments;
  int _currentIndex = 0;
  bool _isPlaying = false;
  int _resumeOffset = 0;
  int _resumeBase = 0;

  static const _displaySpeeds = [0.5, 1.0, 1.5];
  static const _ttsRates = [0.3, 0.5, 0.65];
  int _speedIndex = 1;

  bool get _hasNext => _currentIndex < _segments.length - 1;
  bool get _hasPrev => _currentIndex > 0;

  @override
  void initState() {
    super.initState();
    if (widget.segments != null && widget.segments!.isNotEmpty) {
      _segments = widget.segments!;
    } else {
      _segments = ArticleProcessor.processWithLevel(
        widget.content,
        widget.level,
      );
    }
    _tts.onComplete = _onSentenceComplete;
    _tts.onWordProgress = (_, start, _, _) {
      _resumeOffset = _resumeBase + start;
    };
    _speedIndex = _speedIndex.clamp(0, _displaySpeeds.length - 1);
    if (_segments.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _togglePlay());
    }
  }

  @override
  void dispose() {
    _tts.stop();
    _tts.onComplete = null;
    _tts.onError = null;
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _onSentenceComplete() {
    if (!mounted || !_isPlaying) return;
    if (_hasNext) {
      _resumeOffset = 0;
      setState(() => _currentIndex++);
      _speakCurrent();
      _scrollToCurrent();
    } else {
      setState(() => _isPlaying = false);
    }
  }

  Future<void> _speakCurrent() async {
    _resumeBase = _resumeOffset;
    await _tts.speak(
      _segments[_currentIndex].cleanText,
      startOffset: _resumeOffset,
    );
  }

  void _scrollToCurrent() {
    final context = _currentKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        alignment: 0.3,
      );
    }
  }

  void _togglePlay() {
    if (_isPlaying) {
      setState(() => _isPlaying = false);
      _tts.stop();
    } else {
      if (!_hasNext && _currentIndex >= _segments.length - 1) {
        _currentIndex = 0;
      }
      _speakCurrent();
      setState(() => _isPlaying = true);
    }
  }

  void _cycleSpeed() {
    setState(() {
      _speedIndex = (_speedIndex + 1) % _displaySpeeds.length;
    });
    _tts.setSpeechRate(_ttsRates[_speedIndex]);
  }

  void _jumpTo(int index) {
    _resumeOffset = 0;
    _isPlaying = false;
    _tts.stop();
    setState(() {
      _currentIndex = index.clamp(0, _segments.length - 1);
    });
    _scrollToCurrent();
  }

  void _nextSentence() {
    if (_hasNext) _jumpTo(_currentIndex + 1);
  }

  void _prevSentence() {
    if (_hasPrev) _jumpTo(_currentIndex - 1);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusXxl),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHandle(),
          if (_segments.isEmpty)
            _buildEmpty(t)
          else ...[
            _buildHeader(),
            _buildProgressBar(),
            Expanded(child: _buildSentencesList()),
            _buildControls(t),
          ],
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.md),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.outline.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildEmpty(AppLocalizations t) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl * 2),
      child: Column(
        children: [
          const Text('📖', style: TextStyle(fontSize: 48)),
          const SizedBox(height: AppSpacing.lg),
          Text(
            t.articleNoAudio,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.xs,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: widget.accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Center(
              child: Text(
                widget.level,
                style: AppTypography.labelMedium.copyWith(
                  color: widget.accentColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              widget.title,
              style: AppTypography.titleSmall.copyWith(
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: AppSpacing.sm.w),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              ),
              child: Center(
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 22,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    final progress = _segments.isEmpty
        ? 0.0
        : (_currentIndex + 1) / _segments.length;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: LinearProgressIndicator(
          value: progress,
          minHeight: 4,
          backgroundColor: AppColors.outline.withValues(alpha: 0.3),
          valueColor: AlwaysStoppedAnimation<Color>(
            widget.accentColor,
          ),
        ),
      ),
    );
  }

  Widget _buildSentenceText(TextSegment segment, bool isActive, bool isPast) {
    if (segment.highlightedWords.isEmpty || isPast) {
      return AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 300),
        style: TextStyle(
          fontSize: isActive ? 16 : 15,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          color: isPast
              ? AppColors.textTertiary
              : isActive
                  ? AppColors.textPrimary
                  : AppColors.textSecondary,
          height: 1.5,
        ),
        child: Text(segment.cleanText),
      );
    }

    final highlightSet = segment.highlightedWords.map((w) => w.toLowerCase()).toSet();
    final wordPattern = RegExp(r"[\w'-]+");
    final spans = <InlineSpan>[];
    int lastEnd = 0;

    for (final match in wordPattern.allMatches(segment.cleanText)) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: segment.cleanText.substring(lastEnd, match.start)));
      }
      final word = match.group(0)!;
      final isHighlighted = highlightSet.contains(word.toLowerCase());
      spans.add(TextSpan(
        text: word,
        style: TextStyle(
          fontSize: isActive ? 16 : 15,
          fontWeight: isActive
              ? (isHighlighted ? FontWeight.w800 : FontWeight.w600)
              : (isHighlighted ? FontWeight.w600 : FontWeight.w400),
          color: isHighlighted
              ? (isActive ? widget.accentColor : AppColors.primary)
              : (isPast
                  ? AppColors.textTertiary
                  : isActive
                      ? AppColors.textPrimary
                      : AppColors.textSecondary),
          decoration: isHighlighted ? TextDecoration.underline : null,
          decorationColor: (isActive ? widget.accentColor : AppColors.primary).withValues(alpha: 0.4),
          decorationThickness: 2,
        ),
      ));
      lastEnd = match.end;
    }
    if (lastEnd < segment.cleanText.length) {
      spans.add(TextSpan(text: segment.cleanText.substring(lastEnd)));
    }

    return Text.rich(
      TextSpan(children: spans),
      style: TextStyle(
        fontSize: isActive ? 16 : 15,
        height: 1.5,
      ),
    );
  }

  Widget _buildSentencesList() {
    return ListView.builder(
      controller: _scrollCtrl,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.md,
      ),
      itemCount: _segments.length,
      itemBuilder: (context, index) {
        final segment = _segments[index];
        final isActive = index == _currentIndex;
        final isPast = index < _currentIndex;

        return GestureDetector(
          onTap: () => _jumpTo(index),
          child: AnimatedContainer(
            key: isActive ? _currentKey : null,
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.only(bottom: AppSpacing.sm),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: isActive
                  ? widget.accentColor.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              border: isActive
                  ? Border.all(
                      color: widget.accentColor.withValues(alpha: 0.3),
                    )
                  : null,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(top: 2, end: 8),
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: isPast
                        ? AppColors.success.withValues(alpha: 0.15)
                        : isActive
                            ? widget.accentColor.withValues(alpha: 0.2)
                            : AppColors.surfaceVariant,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: isPast
                        ? Icon(
                            Icons.check_rounded,
                            size: 14,
                            color: AppColors.success,
                          )
                        : Text(
                            '${segment.id}',
                            style: AppTypography.labelSmall.copyWith(
                              color: isActive
                                  ? widget.accentColor
                                  : AppColors.textTertiary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _buildSentenceText(segment, isActive, isPast),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildControls(AppLocalizations t) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.xl,
        MediaQuery.of(context).padding.bottom + AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: _cycleSpeed,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                border: Border.all(
                  color: AppColors.outline.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                '${_displaySpeeds[_speedIndex]}x',
                style: AppTypography.labelLarge.copyWith(
                  color: widget.accentColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.xxl),
          GestureDetector(
            onTap: _prevSentence,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              ),
              child: Center(
                child: Icon(
                  Icons.skip_previous_rounded,
                  color: _hasPrev
                      ? AppColors.textPrimary
                      : AppColors.textTertiary,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          GestureDetector(
            onTap: _togglePlay,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    widget.accentColor,
                    widget.accentColor.withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: widget.accentColor.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                color: Colors.white,
                size: 36,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          GestureDetector(
            onTap: _nextSentence,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              ),
              child: Center(
                child: Icon(
                  Icons.skip_next_rounded,
                  color: _hasNext
                      ? AppColors.textPrimary
                      : AppColors.textTertiary,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.xxl),
          GestureDetector(
            onTap: () {
              _isPlaying = false;
              _tts.stop();
              Navigator.pop(context);
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.errorContainer,
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              ),
              child: Center(
                child: Icon(
                  Icons.stop_rounded,
                  color: AppColors.error,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
