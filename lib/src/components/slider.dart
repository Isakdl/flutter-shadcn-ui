import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Possible ways for a user to interact with a [ShadSlider].
enum ShadSliderInteraction {
  /// Allows the user to interact with a [ShadSlider] by tapping or sliding
  /// anywhere on the track.
  ///
  /// Essentially all possible interactions are allowed.
  ///
  /// This is different from [ShadSliderInteraction.slideOnly] as when you try
  /// to slide anywhere other than the thumb, the thumb will move to the first
  /// point of contact.
  tapAndSlide,

  /// Allows the user to interact with a [ShadSlider] by only tapping anywhere
  /// on the track.
  ///
  /// Sliding interaction is ignored.
  tapOnly,

  /// Allows the user to interact with a [ShadSlider] only by sliding anywhere
  /// on the track.
  ///
  /// Tapping interaction is ignored.
  slideOnly,

  /// Allows the user to interact with a [ShadSlider] only by sliding the thumb.
  ///
  /// Tapping and sliding interactions on the track are ignored.
  slideThumb,
}

/// {@template ShadSliderController}
/// A controller for the [ShadSlider] widget, managing its values.
///
/// Extends [ValueNotifier] to provide reactive updates when the slider values
/// change.
/// {@endtemplate}
class ShadSliderController extends ValueNotifier<List<double>> {
  /// Creates a [ShadSliderController] with initial values.
  ShadSliderController({required List<double> initialValues})
    : super(List<double>.from(initialValues));
}

/// A customizable slider widget styled to match the Shadcn UI design system.
///
/// Allows users to select one or more values from a continuous range by
/// dragging thumbs along a track.
class ShadSlider extends StatefulWidget {
  /// Creates a [ShadSlider].
  ///
  /// Either [initialValues] or [controller] must be provided to determine the
  /// slider's starting values.
  ShadSlider({
    super.key,
    this.initialValues,
    this.onChanged,
    this.enabled = true,
    this.min,
    this.max,
    this.focusNode,
    this.autofocus = false,
    this.mouseCursor,
    this.disabledMouseCursor,
    this.thumbColor,
    this.disabledThumbColor,
    this.thumbBorderColor,
    this.disabledThumbBorderColor,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.disabledActiveTrackColor,
    this.disabledInactiveTrackColor,
    this.trackHeight,
    this.thumbRadius,
    this.thumbDecoration,
    this.onChangeStart,
    this.onChangeEnd,
    this.divisions,
    this.showDivisionMarks = true,
    this.label,
    this.semanticFormatterCallback,
    this.allowedInteraction,
    this.controller,
  }) : assert(
         (initialValues != null) ^ (controller != null),
         'Either initialValues or controller must be specified',
       ),
       assert(
         initialValues == null || initialValues.isNotEmpty,
         'initialValues must be non-empty',
       );

  /// {@template ShadSlider.initialValues}
  /// The initial values of the slider, one thumb per entry.
  ///
  /// These values are used only when [controller] is null.
  /// {@endtemplate}
  final List<double>? initialValues;

  /// {@template ShadSlider.onChanged}
  /// Callback that is called when any slider value changes.
  ///
  /// Provides the full list of values as an argument.
  /// {@endtemplate}
  final ValueChanged<List<double>>? onChanged;

  /// {@template ShadSlider.enabled}
  /// Whether the slider is enabled.
  ///
  /// When disabled, the slider cannot be interacted with and visually appears
  /// disabled. Defaults to true.
  /// {@endtemplate}
  final bool enabled;

  /// {@template ShadSlider.min}
  /// The minimum value the slider can take.
  ///
  /// Defaults to 0.0.
  /// {@endtemplate}
  final double? min;

  /// {@template ShadSlider.max}
  /// The maximum value the slider can take.
  ///
  /// Defaults to 1.0.
  /// {@endtemplate}
  final double? max;

  /// {@template ShadSlider.focusNode}
  /// The focus node to control the focus state of the slider.
  ///
  /// If null, a default [FocusNode] will be created internally.
  /// {@endtemplate}
  final FocusNode? focusNode;

  /// {@template ShadSlider.autofocus}
  /// Whether the slider should automatically focus when it is first built.
  ///
  /// Defaults to false.
  /// {@endtemplate}
  final bool autofocus;

  /// {@template ShadSlider.mouseCursor}
  /// The cursor for the slider when it is enabled.
  ///
  /// Defaults to [SystemMouseCursors.click].
  /// {@endtemplate}
  final MouseCursor? mouseCursor;

  /// {@template ShadSlider.disabledMouseCursor}
  /// The cursor for the slider when it is disabled.
  ///
  /// Defaults to [SystemMouseCursors.forbidden].
  /// {@endtemplate}
  final MouseCursor? disabledMouseCursor;

  /// {@template ShadSlider.thumbColor}
  /// The color of the slider thumb when enabled.
  ///
  /// Defaults to the theme's background color.
  /// {@endtemplate}
  final Color? thumbColor;

  /// {@template ShadSlider.disabledThumbColor}
  /// The color of the slider thumb when disabled.
  ///
  /// Defaults to the theme's background color.
  /// {@endtemplate}
  final Color? disabledThumbColor;

  /// {@template ShadSlider.thumbBorderColor}
  /// The border color of the slider thumb when enabled.
  ///
  /// Defaults to the theme's primary color.
  /// {@endtemplate}
  final Color? thumbBorderColor;

  /// {@template ShadSlider.disabledThumbBorderColor}
  /// The border color of the slider thumb when disabled.
  ///
  /// Defaults to a semi-transparent version of the theme's primary color.
  /// {@endtemplate}
  final Color? disabledThumbBorderColor;

  /// {@template ShadSlider.activeTrackColor}
  /// The color of the active portion of the slider track.
  ///
  /// Defaults to the theme's primary color.
  /// {@endtemplate}
  final Color? activeTrackColor;

  /// {@template ShadSlider.inactiveTrackColor}
  /// The color of the inactive portion of the slider track.
  ///
  /// Defaults to the theme's secondary color.
  /// {@endtemplate}
  final Color? inactiveTrackColor;

  /// {@template ShadSlider.disabledActiveTrackColor}
  /// The color of the active track when the slider is disabled.
  ///
  /// Defaults to a semi-transparent version of the theme's primary color.
  /// {@endtemplate}
  final Color? disabledActiveTrackColor;

  /// {@template ShadSlider.disabledInactiveTrackColor}
  /// The color of the inactive track when the slider is disabled.
  ///
  /// Defaults to a semi-transparent version of the theme's secondary color.
  /// {@endtemplate}
  final Color? disabledInactiveTrackColor;

  /// {@template ShadSlider.trackHeight}
  /// The height of the slider track.
  ///
  /// Defaults to 8.0.
  /// {@endtemplate}
  final double? trackHeight;

  /// {@template ShadSlider.thumbRadius}
  /// The radius of the slider thumb.
  ///
  /// Defaults to 10.0.
  /// {@endtemplate}
  final double? thumbRadius;

  /// {@template ShadSlider.thumbDecoration}
  /// When set, replaces the default thumb [ShadDecoration] built from
  /// [thumbColor], [thumbBorderColor], and [ShadSliderTheme]. Use
  /// `canMerge: false` so [ShadDecorator] does not merge the global theme
  /// decoration into the thumb.
  /// {@endtemplate}
  final ShadDecoration? thumbDecoration;

  /// {@template ShadSlider.onChangeStart}
  /// Callback that is called when the user starts to change a slider value.
  ///
  /// Provides the current values as an argument.
  /// {@endtemplate}
  final ValueChanged<List<double>>? onChangeStart;

  /// {@template ShadSlider.onChangeEnd}
  /// Callback that is called when the user finishes changing a slider value.
  ///
  /// Provides the current values as an argument.
  /// {@endtemplate}
  final ValueChanged<List<double>>? onChangeEnd;

  /// {@template ShadSlider.divisions}
  /// The number of discrete divisions the slider has.
  ///
  /// When provided, the slider will snap to these divisions.
  /// {@endtemplate}
  final int? divisions;

  /// {@template ShadSlider.showDivisionMarks}
  /// Whether to draw tick marks on the track when [divisions] is set.
  ///
  /// Snapping still applies when [divisions] is non-null; set this to false for
  /// a cleaner track. Defaults to true.
  /// {@endtemplate}
  final bool showDivisionMarks;

  /// {@template ShadSlider.label}
  /// A label to display above the slider when the thumb is pressed.
  /// {@endtemplate}
  final String? label;

  /// {@template ShadSlider.semanticFormatterCallback}
  /// A semantic formatter to be called by assistive technologies.
  /// {@endtemplate}
  final String Function(List<double> values)? semanticFormatterCallback;

  /// {@template ShadSlider.allowedInteraction}
  /// Configures how the user can interact with the slider.
  ///
  /// Defaults to `ShadSliderInteraction.tapAndSlide`.
  /// {@endtemplate}
  final ShadSliderInteraction? allowedInteraction;

  /// {@macro ShadSliderController}
  final ShadSliderController? controller;

  @override
  State<ShadSlider> createState() => _ShadSliderState();
}

/// Absorbs touch long-press before an ancestor [SelectableRegion] handles it,
/// so the region does not take focus (see [SelectableRegion] long-press path).
class _AbsorbSelectableRegionLongPress extends StatelessWidget {
  const _AbsorbSelectableRegionLongPress({required this.child});

  final Widget child;

  static const Set<PointerDeviceKind> _devices = <PointerDeviceKind>{
    PointerDeviceKind.touch,
    PointerDeviceKind.stylus,
    PointerDeviceKind.invertedStylus,
  };

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      behavior: HitTestBehavior.translucent,
      gestures: <Type, GestureRecognizerFactory>{
        LongPressGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
              () => LongPressGestureRecognizer(supportedDevices: _devices),
              (LongPressGestureRecognizer instance) {
                instance.onLongPressStart = (_) {};
              },
            ),
      },
      child: child,
    );
  }
}

class _ShadSliderState extends State<ShadSlider> {
  late final ShadSliderController _ownedController = ShadSliderController(
    initialValues: List<double>.from(widget.initialValues!),
  );

  ShadSliderController get controller => widget.controller ?? _ownedController;

  FocusNode? _focusNode;
  FocusNode get focusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  final List<FocusNode> _thumbFocusNodes = [];
  int? _trackDragThumbIndex;

  void _syncThumbFocusNodesForCount(int valueCount) {
    final needed = valueCount > 1 ? valueCount : 0;
    while (_thumbFocusNodes.length < needed) {
      _thumbFocusNodes.add(FocusNode());
    }
    while (_thumbFocusNodes.length > needed) {
      _thumbFocusNodes.removeLast().dispose();
    }
  }

  void _onControllerThumbCountChanged() {
    final n = controller.value.length;
    final needed = n > 1 ? n : 0;
    if (_thumbFocusNodes.length != needed) {
      _syncThumbFocusNodesForCount(n);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _syncThumbFocusNodesForCount(controller.value.length);
    controller.addListener(_onControllerThumbCountChanged);
  }

  @override
  void didUpdateWidget(covariant ShadSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      final oldCtrl = oldWidget.controller ?? _ownedController;
      final newCtrl = widget.controller ?? _ownedController;
      oldCtrl.removeListener(_onControllerThumbCountChanged);
      newCtrl.addListener(_onControllerThumbCountChanged);
      if (widget.controller == null) {
        controller.value = List<double>.from(widget.initialValues!);
      }
      _syncThumbFocusNodesForCount(controller.value.length);
    }

    if (oldWidget.focusNode != widget.focusNode) {
      if (oldWidget.focusNode == null) {
        _focusNode?.dispose();
        _focusNode = null;
      }
      if (widget.focusNode == null && _focusNode == null) {
        _focusNode = FocusNode();
      }
    }
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerThumbCountChanged);
    for (final n in _thumbFocusNodes) {
      n.dispose();
    }
    _thumbFocusNodes.clear();
    _focusNode?.dispose();
    if (widget.controller == null) {
      _ownedController.dispose();
    }
    super.dispose();
  }

  double _clampAndSnap(double raw, double effectiveMin, double effectiveMax) {
    var clampedValue = raw.clamp(effectiveMin, effectiveMax);

    if (widget.divisions != null) {
      final step = (effectiveMax - effectiveMin) / widget.divisions!;
      clampedValue =
          ((clampedValue - effectiveMin) / step).round() * step + effectiveMin;
    }

    return clampedValue;
  }

  void _updateThumbAt(
    int index,
    double newValue,
    double effectiveMin,
    double effectiveMax,
  ) {
    final clampedValue = _clampAndSnap(newValue, effectiveMin, effectiveMax);
    final current = controller.value;
    if (index < 0 || index >= current.length) {
      return;
    }
    if (current[index] == clampedValue) {
      return;
    }
    final next = List<double>.from(current);
    next[index] = clampedValue;
    controller.value = next;
    widget.onChanged?.call(next);
  }

  double _valueFromDx(
    double dx,
    BoxConstraints constraints,
    double effectiveMin,
    double effectiveMax,
  ) {
    return effectiveMin +
        (dx / constraints.maxWidth) * (effectiveMax - effectiveMin);
  }

  int _nearestThumbIndex(double value, List<double> values) {
    var bestIndex = 0;
    var bestDistance = (values[0] - value).abs();
    for (var i = 1; i < values.length; i++) {
      final d = (values[i] - value).abs();
      if (d < bestDistance) {
        bestDistance = d;
        bestIndex = i;
      }
    }
    return bestIndex;
  }

  void _requestFocusForThumb(int thumbIndex) {
    if (!widget.enabled) {
      return;
    }
    final values = controller.value;
    if (thumbIndex < 0 || thumbIndex >= values.length) {
      return;
    }
    if (values.length == 1) {
      focusNode.requestFocus();
      return;
    }
    if (thumbIndex < _thumbFocusNodes.length) {
      _thumbFocusNodes[thumbIndex].requestFocus();
    }
  }

  String _semanticValueForThumb(
    List<double> allValues,
    int thumbIndex,
    double thumbValue,
  ) {
    final formatter = widget.semanticFormatterCallback;
    if (formatter != null) {
      return formatter(allValues);
    }
    return thumbValue.toString();
  }

  void _handleTrackTap(
    Offset localPosition,
    BoxConstraints constraints,
    double effectiveMin,
    double effectiveMax,
  ) {
    final newValue = _valueFromDx(
      localPosition.dx,
      constraints,
      effectiveMin,
      effectiveMax,
    );
    final index = _nearestThumbIndex(newValue, controller.value);
    _requestFocusForThumb(index);
    _updateThumbAt(index, newValue, effectiveMin, effectiveMax);
  }

  void _handleTrackPan(
    Offset localPosition,
    BoxConstraints constraints,
    double effectiveMin,
    double effectiveMax,
  ) {
    final thumbIndex = _trackDragThumbIndex;
    if (thumbIndex == null) {
      return;
    }
    final newValue = _valueFromDx(
      localPosition.dx,
      constraints,
      effectiveMin,
      effectiveMax,
    );
    _updateThumbAt(thumbIndex, newValue, effectiveMin, effectiveMax);
  }

  bool _handleKeyEvent(int thumbIndex, KeyEvent event) {
    if (!widget.enabled ||
        (event is! KeyDownEvent && event is! KeyRepeatEvent)) {
      return false;
    }

    final effectiveMin = widget.min ?? 0;
    final effectiveMax = widget.max ?? 1;
    final range = effectiveMax - effectiveMin;

    double increment;
    if (widget.divisions != null && widget.divisions! > 0) {
      increment = range / widget.divisions!;
    } else {
      increment = range * 0.01;
    }
    if (HardwareKeyboard.instance.isShiftPressed) {
      increment *= 10;
    }

    final values = controller.value;
    if (values.isEmpty || thumbIndex < 0 || thumbIndex >= values.length) {
      return false;
    }
    var newValue = values[thumbIndex];

    if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
        event.logicalKey == LogicalKeyboardKey.arrowDown) {
      newValue -= increment;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
        event.logicalKey == LogicalKeyboardKey.arrowUp) {
      newValue += increment;
    } else {
      return false;
    }

    _updateThumbAt(thumbIndex, newValue, effectiveMin, effectiveMax);
    return true;
  }

  List<int> _indicesSortedByValue(List<double> values) {
    final indices = List<int>.generate(values.length, (i) => i);
    indices.sort((a, b) {
      final c = values[a].compareTo(values[b]);
      if (c != 0) {
        return c;
      }
      return a.compareTo(b);
    });
    return indices;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    final effectiveMouseCursor =
        widget.mouseCursor ??
        theme.sliderTheme.mouseCursor ??
        SystemMouseCursors.click;
    final effectiveDisabledMouseCursor =
        widget.disabledMouseCursor ??
        theme.sliderTheme.disabledMouseCursor ??
        SystemMouseCursors.forbidden;

    final effectiveMin = widget.min ?? theme.sliderTheme.min ?? 0;
    final effectiveMax = widget.max ?? theme.sliderTheme.max ?? 1;

    final effectiveThumbColor =
        widget.thumbColor ??
        theme.sliderTheme.thumbColor ??
        theme.colorScheme.background;

    final effectiveThumbBorderColor =
        widget.thumbBorderColor ??
        theme.sliderTheme.thumbBorderColor ??
        theme.colorScheme.primary;

    final effectiveDisabledThumbColor =
        widget.disabledThumbColor ??
        theme.sliderTheme.disabledThumbColor ??
        theme.colorScheme.background;

    final effectiveDisabledThumbBorderColor =
        widget.disabledThumbBorderColor ??
        theme.sliderTheme.disabledThumbBorderColor ??
        theme.colorScheme.primary.withValues(alpha: .5);

    final effectiveActiveTrackColor =
        widget.activeTrackColor ??
        theme.sliderTheme.activeTrackColor ??
        theme.colorScheme.primary;

    final effectiveInactiveTrackColor =
        widget.inactiveTrackColor ??
        theme.sliderTheme.inactiveTrackColor ??
        theme.colorScheme.secondary;

    final effectiveDisabledActiveTrackColor =
        widget.disabledActiveTrackColor ??
        theme.sliderTheme.disabledActiveTrackColor ??
        theme.colorScheme.primary.withValues(alpha: .5);

    final effectiveDisabledInactiveTrackColor =
        widget.disabledInactiveTrackColor ??
        theme.sliderTheme.disabledInactiveTrackColor ??
        theme.colorScheme.secondary.withValues(alpha: .5);

    final effectiveTrackHeight =
        widget.trackHeight ?? theme.sliderTheme.trackHeight ?? 8;

    final effectiveThumbRadius =
        widget.thumbRadius ?? theme.sliderTheme.thumbRadius ?? 10.0;

    final effectiveAllowedInteraction =
        widget.allowedInteraction ?? ShadSliderInteraction.tapAndSlide;

    const focusRingBorderWidth = 2.0;
    const focusRingPadding = 2.0;
    const thumbBorderWidth = 2.0;

    final thumbFillColor = widget.enabled
        ? effectiveThumbColor
        : effectiveDisabledThumbColor;
    final thumbStrokeColor = widget.enabled
        ? effectiveThumbBorderColor
        : effectiveDisabledThumbBorderColor;

    final baseThumbDecoration = ShadDecoration(
      canMerge: false,
      color: thumbFillColor,
      shape: BoxShape.circle,
      border: ShadBorder.all(color: thumbStrokeColor, width: thumbBorderWidth),
      disableSecondaryBorder: true,
    );
    final effectiveThumbDecoration =
        widget.thumbDecoration ?? baseThumbDecoration;

    final focusRingThumbDecoration = ShadDecoration(
      canMerge: false,
      color: thumbFillColor,
      shape: BoxShape.circle,
      border: ShadBorder.all(
        color: theme.colorScheme.ring,
        width: focusRingBorderWidth,
      ),
      disableSecondaryBorder: true,
    );

    const divisionMarkWidth = 2.0;
    const divisionMarkHeight = 6.0;
    const divisionMarkOffset = 1.0;
    const divisionMarkBorderRadius = 1.0;

    const activeTrackBorderRadius = 8.0;

    const focusRingTotalSpace = (focusRingBorderWidth + focusRingPadding) * 2;

    return SelectionContainer.disabled(
      child: _AbsorbSelectableRegionLongPress(
        child: ValueListenableBuilder<List<double>>(
          valueListenable: controller,
          builder: (context, values, _) {
            return LayoutBuilder(
              builder: (layoutContext, constraints) {
                assert(
                  constraints.hasBoundedWidth,
                  'ShadSlider requires a bounded width',
                );
                final effectiveTrackWidth = constraints.maxWidth;
                final rangeSpan = effectiveMax - effectiveMin;
                double norm(double v) {
                  if (rangeSpan == 0) {
                    return 0.0;
                  }
                  return ((v - effectiveMin) / rangeSpan).clamp(0.0, 1.0);
                }

                double activeStartNorm;
                double activeEndNorm;
                if (values.length == 1) {
                  activeStartNorm = 0.0;
                  activeEndNorm = norm(values[0]);
                } else {
                  var low = values[0];
                  var high = values[0];
                  for (final v in values.skip(1)) {
                    if (v < low) {
                      low = v;
                    }
                    if (v > high) {
                      high = v;
                    }
                  }
                  activeStartNorm = norm(low);
                  activeEndNorm = norm(high);
                }
                final activeWidth =
                    (activeEndNorm - activeStartNorm).clamp(0.0, 1.0) *
                    effectiveTrackWidth;
                final activeLeft = activeStartNorm * effectiveTrackWidth;
                final activeTrackDecoration = values.length == 1
                    ? BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(activeTrackBorderRadius),
                          bottomLeft: Radius.circular(activeTrackBorderRadius),
                        ),
                        color: widget.enabled
                            ? effectiveActiveTrackColor
                            : effectiveDisabledActiveTrackColor,
                      )
                    : BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                          left: const Radius.circular(activeTrackBorderRadius),
                          right: const Radius.circular(activeTrackBorderRadius),
                        ),
                        color: widget.enabled
                            ? effectiveActiveTrackColor
                            : effectiveDisabledActiveTrackColor,
                      );

                final thumbHitExtent =
                    effectiveThumbRadius * 2 + focusRingTotalSpace;
                final sliderHitHeight = effectiveTrackHeight > thumbHitExtent
                    ? effectiveTrackHeight
                    : thumbHitExtent;
                final trackVerticalInset =
                    (sliderHitHeight - effectiveTrackHeight) / 2;

                final sortedByValue = values.length > 1
                    ? _indicesSortedByValue(values)
                    : const <int>[];

                return SizedBox(
                  width: effectiveTrackWidth,
                  height: sliderHitHeight,
                  child: FocusTraversalGroup(
                    policy: OrderedTraversalPolicy(),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: 0,
                          top: trackVerticalInset,
                          width: effectiveTrackWidth,
                          height: effectiveTrackHeight,
                          child: ShadGestureDetector(
                            cursor: widget.enabled
                                ? effectiveMouseCursor
                                : effectiveDisabledMouseCursor,
                            onTapDown:
                                widget.enabled &&
                                    (effectiveAllowedInteraction ==
                                            ShadSliderInteraction.tapAndSlide ||
                                        effectiveAllowedInteraction ==
                                            ShadSliderInteraction.tapOnly)
                                ? (details) {
                                    _handleTrackTap(
                                      details.localPosition,
                                      constraints,
                                      effectiveMin,
                                      effectiveMax,
                                    );
                                  }
                                : null,
                            onPanStart:
                                widget.enabled &&
                                    (effectiveAllowedInteraction ==
                                            ShadSliderInteraction.tapAndSlide ||
                                        effectiveAllowedInteraction ==
                                            ShadSliderInteraction.slideOnly)
                                ? (details) {
                                    final v = _valueFromDx(
                                      details.localPosition.dx,
                                      constraints,
                                      effectiveMin,
                                      effectiveMax,
                                    );
                                    final thumbIndex = _nearestThumbIndex(
                                      v,
                                      controller.value,
                                    );
                                    _trackDragThumbIndex = thumbIndex;
                                    _requestFocusForThumb(thumbIndex);
                                    widget.onChangeStart?.call(
                                      controller.value,
                                    );
                                  }
                                : null,
                            onPanUpdate:
                                widget.enabled &&
                                    (effectiveAllowedInteraction ==
                                            ShadSliderInteraction.tapAndSlide ||
                                        effectiveAllowedInteraction ==
                                            ShadSliderInteraction.slideOnly)
                                ? (details) {
                                    _handleTrackPan(
                                      details.localPosition,
                                      constraints,
                                      effectiveMin,
                                      effectiveMax,
                                    );
                                  }
                                : null,
                            onPanEnd: widget.enabled
                                ? (details) {
                                    _trackDragThumbIndex = null;
                                    widget.onChangeEnd?.call(controller.value);
                                  }
                                : null,
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: effectiveTrackWidth,
                                  height: effectiveTrackHeight,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius: theme.radius,
                                      color: widget.enabled
                                          ? effectiveInactiveTrackColor
                                          : effectiveDisabledInactiveTrackColor,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: activeLeft,
                                  child: SizedBox(
                                    width: activeWidth,
                                    height: effectiveTrackHeight,
                                    child: DecoratedBox(
                                      decoration: activeTrackDecoration,
                                    ),
                                  ),
                                ),
                                if (widget.divisions != null &&
                                    widget.divisions! > 0 &&
                                    widget.showDivisionMarks)
                                  ...List.generate(widget.divisions! + 1, (
                                    index,
                                  ) {
                                    final position = index / widget.divisions!;
                                    return Positioned(
                                      left:
                                          position * effectiveTrackWidth -
                                          divisionMarkOffset,
                                      top:
                                          (effectiveTrackHeight -
                                              divisionMarkHeight) /
                                          2,
                                      child: Container(
                                        width: divisionMarkWidth,
                                        height: divisionMarkHeight,
                                        decoration: BoxDecoration(
                                          color: widget.enabled
                                              ? theme.colorScheme.border
                                              : theme.colorScheme.border
                                                    .withValues(alpha: 0.5),
                                          borderRadius: BorderRadius.circular(
                                            divisionMarkBorderRadius,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                              ],
                            ),
                          ),
                        ),
                        if (values.length == 1)
                          _ShadSliderThumb(
                            key: const ValueKey<String>('shad-slider-thumb-0'),
                            focusNode: focusNode,
                            autofocus: widget.autofocus,
                            onKeyEvent: widget.enabled
                                ? (node, event) {
                                    return _handleKeyEvent(0, event)
                                        ? KeyEventResult.handled
                                        : KeyEventResult.ignored;
                                  }
                                : null,
                            value: values[0],
                            constraints: constraints,
                            effectiveMin: effectiveMin,
                            effectiveMax: effectiveMax,
                            effectiveTrackHeight: effectiveTrackHeight,
                            trackVerticalInset: trackVerticalInset,
                            effectiveThumbRadius: effectiveThumbRadius,
                            enabled: widget.enabled,
                            effectiveMouseCursor: effectiveMouseCursor,
                            effectiveDisabledMouseCursor:
                                effectiveDisabledMouseCursor,
                            thumbDecoration: effectiveThumbDecoration,
                            focusRingThumbDecoration: focusRingThumbDecoration,
                            focusRingPadding: focusRingPadding,
                            focusRingTotalSpace: focusRingTotalSpace,
                            allowedInteraction: effectiveAllowedInteraction,
                            semanticValue: _semanticValueForThumb(
                              values,
                              0,
                              values[0],
                            ),
                            onPanStart: widget.enabled
                                ? () {
                                    widget.onChangeStart?.call(
                                      controller.value,
                                    );
                                  }
                                : null,
                            onPanEnd: widget.enabled
                                ? () {
                                    widget.onChangeEnd?.call(controller.value);
                                  }
                                : null,
                            onPanUpdate:
                                widget.enabled &&
                                    (effectiveAllowedInteraction ==
                                            ShadSliderInteraction.tapAndSlide ||
                                        effectiveAllowedInteraction ==
                                            ShadSliderInteraction.slideOnly ||
                                        effectiveAllowedInteraction ==
                                            ShadSliderInteraction.slideThumb)
                                ? (Offset globalPosition) {
                                    final box =
                                        layoutContext.findRenderObject()
                                            as RenderBox?;
                                    if (box == null) {
                                      return;
                                    }
                                    final localPosition = box.globalToLocal(
                                      globalPosition,
                                    );
                                    final newValue = _valueFromDx(
                                      localPosition.dx,
                                      constraints,
                                      effectiveMin,
                                      effectiveMax,
                                    );
                                    _updateThumbAt(
                                      0,
                                      newValue,
                                      effectiveMin,
                                      effectiveMax,
                                    );
                                  }
                                : null,
                          )
                        else
                          for (var i = 0; i < values.length; i++)
                            _ShadSliderThumb(
                              key: ValueKey<int>(i),
                              focusTraversalOrder: NumericFocusOrder(
                                sortedByValue.indexOf(i).toDouble(),
                              ),
                              focusNode: _thumbFocusNodes[i],
                              autofocus:
                                  widget.autofocus && sortedByValue.first == i,
                              onKeyEvent: widget.enabled
                                  ? (node, event) {
                                      return _handleKeyEvent(i, event)
                                          ? KeyEventResult.handled
                                          : KeyEventResult.ignored;
                                    }
                                  : null,
                              value: values[i],
                              constraints: constraints,
                              effectiveMin: effectiveMin,
                              effectiveMax: effectiveMax,
                              effectiveTrackHeight: effectiveTrackHeight,
                              trackVerticalInset: trackVerticalInset,
                              effectiveThumbRadius: effectiveThumbRadius,
                              enabled: widget.enabled,
                              effectiveMouseCursor: effectiveMouseCursor,
                              effectiveDisabledMouseCursor:
                                  effectiveDisabledMouseCursor,
                              thumbDecoration: effectiveThumbDecoration,
                              focusRingThumbDecoration:
                                  focusRingThumbDecoration,
                              focusRingPadding: focusRingPadding,
                              focusRingTotalSpace: focusRingTotalSpace,
                              allowedInteraction: effectiveAllowedInteraction,
                              semanticValue: _semanticValueForThumb(
                                values,
                                i,
                                values[i],
                              ),
                              onPanStart: widget.enabled
                                  ? () {
                                      widget.onChangeStart?.call(
                                        controller.value,
                                      );
                                    }
                                  : null,
                              onPanEnd: widget.enabled
                                  ? () {
                                      widget.onChangeEnd?.call(
                                        controller.value,
                                      );
                                    }
                                  : null,
                              onPanUpdate:
                                  widget.enabled &&
                                      (effectiveAllowedInteraction ==
                                              ShadSliderInteraction
                                                  .tapAndSlide ||
                                          effectiveAllowedInteraction ==
                                              ShadSliderInteraction.slideOnly ||
                                          effectiveAllowedInteraction ==
                                              ShadSliderInteraction.slideThumb)
                                  ? (Offset globalPosition) {
                                      final box =
                                          layoutContext.findRenderObject()
                                              as RenderBox?;
                                      if (box == null) {
                                        return;
                                      }
                                      final localPosition = box.globalToLocal(
                                        globalPosition,
                                      );
                                      final newValue = _valueFromDx(
                                        localPosition.dx,
                                        constraints,
                                        effectiveMin,
                                        effectiveMax,
                                      );
                                      _updateThumbAt(
                                        i,
                                        newValue,
                                        effectiveMin,
                                        effectiveMax,
                                      );
                                    }
                                  : null,
                            ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _ShadSliderThumb extends StatelessWidget {
  const _ShadSliderThumb({
    super.key,
    this.focusTraversalOrder,
    required this.focusNode,
    required this.autofocus,
    required this.onKeyEvent,
    required this.value,
    required this.constraints,
    required this.effectiveMin,
    required this.effectiveMax,
    required this.effectiveTrackHeight,
    required this.trackVerticalInset,
    required this.effectiveThumbRadius,
    required this.enabled,
    required this.effectiveMouseCursor,
    required this.effectiveDisabledMouseCursor,
    required this.thumbDecoration,
    required this.focusRingThumbDecoration,
    required this.focusRingPadding,
    required this.focusRingTotalSpace,
    required this.allowedInteraction,
    required this.semanticValue,
    required this.onPanStart,
    required this.onPanEnd,
    required this.onPanUpdate,
  });

  final NumericFocusOrder? focusTraversalOrder;
  final FocusNode focusNode;
  final bool autofocus;
  final FocusOnKeyEventCallback? onKeyEvent;
  final double value;
  final BoxConstraints constraints;
  final double effectiveMin;
  final double effectiveMax;
  final double effectiveTrackHeight;
  final double trackVerticalInset;
  final double effectiveThumbRadius;
  final bool enabled;
  final MouseCursor effectiveMouseCursor;
  final MouseCursor effectiveDisabledMouseCursor;
  final ShadDecoration thumbDecoration;
  final ShadDecoration focusRingThumbDecoration;
  final double focusRingPadding;
  final double focusRingTotalSpace;
  final ShadSliderInteraction allowedInteraction;
  final String semanticValue;
  final VoidCallback? onPanStart;
  final VoidCallback? onPanEnd;
  final void Function(Offset globalPosition)? onPanUpdate;

  @override
  Widget build(BuildContext context) {
    final rangeSpan = effectiveMax - effectiveMin;
    final fraction = rangeSpan == 0
        ? 0.0
        : ((value - effectiveMin) / rangeSpan).clamp(0.0, 1.0);
    final centerX = fraction * constraints.maxWidth;

    final hitWidth = effectiveThumbRadius * 2 + focusRingTotalSpace;
    final hitHeight = effectiveThumbRadius * 2 + focusRingTotalSpace;
    final halfHitW = hitWidth / 2;

    final focusCore = _ShadSliderThumbFocusCore(
      focusNode: focusNode,
      autofocus: autofocus,
      onKeyEvent: onKeyEvent,
      enabled: enabled,
      effectiveMouseCursor: effectiveMouseCursor,
      effectiveDisabledMouseCursor: effectiveDisabledMouseCursor,
      allowedInteraction: allowedInteraction,
      semanticValue: semanticValue,
      onPanStart: onPanStart,
      onPanEnd: onPanEnd,
      onPanUpdate: onPanUpdate,
      hitWidth: hitWidth,
      hitHeight: hitHeight,
      effectiveThumbRadius: effectiveThumbRadius,
      focusRingPadding: focusRingPadding,
      thumbDecoration: thumbDecoration,
      focusRingThumbDecoration: focusRingThumbDecoration,
    );
    final traversalOrder = focusTraversalOrder;
    final positionedChild = traversalOrder != null
        ? FocusTraversalOrder(order: traversalOrder, child: focusCore)
        : focusCore;

    return Positioned(
      left: (centerX - halfHitW).clamp(
        -halfHitW + effectiveThumbRadius,
        constraints.maxWidth - halfHitW - effectiveThumbRadius,
      ),
      top: trackVerticalInset + (effectiveTrackHeight - hitHeight) / 2,
      child: positionedChild,
    );
  }
}

class _ShadSliderThumbFocusCore extends StatelessWidget {
  const _ShadSliderThumbFocusCore({
    required this.focusNode,
    required this.autofocus,
    required this.onKeyEvent,
    required this.enabled,
    required this.effectiveMouseCursor,
    required this.effectiveDisabledMouseCursor,
    required this.allowedInteraction,
    required this.semanticValue,
    required this.onPanStart,
    required this.onPanEnd,
    required this.onPanUpdate,
    required this.hitWidth,
    required this.hitHeight,
    required this.effectiveThumbRadius,
    required this.focusRingPadding,
    required this.thumbDecoration,
    required this.focusRingThumbDecoration,
  });

  final FocusNode focusNode;
  final bool autofocus;
  final FocusOnKeyEventCallback? onKeyEvent;
  final bool enabled;
  final MouseCursor effectiveMouseCursor;
  final MouseCursor effectiveDisabledMouseCursor;
  final ShadSliderInteraction allowedInteraction;
  final String semanticValue;
  final VoidCallback? onPanStart;
  final VoidCallback? onPanEnd;
  final void Function(Offset globalPosition)? onPanUpdate;
  final double hitWidth;
  final double hitHeight;
  final double effectiveThumbRadius;
  final double focusRingPadding;
  final ShadDecoration thumbDecoration;
  final ShadDecoration focusRingThumbDecoration;

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: focusNode,
      autofocus: autofocus,
      canRequestFocus: enabled,
      onKeyEvent: onKeyEvent,
      child: Builder(
        builder: (focusContext) {
          final showFocusRing = Focus.of(focusContext).hasFocus;
          final thumbChild = showFocusRing
              ? ShadDecorator(
                  decoration: focusRingThumbDecoration,
                  child: Padding(
                    padding: EdgeInsets.all(focusRingPadding),
                    child: SizedBox(
                      width: effectiveThumbRadius * 2,
                      height: effectiveThumbRadius * 2,
                      child: ShadDecorator(
                        decoration: thumbDecoration,
                        child: const SizedBox.expand(),
                      ),
                    ),
                  ),
                )
              : ShadDecorator(
                  decoration: thumbDecoration,
                  child: SizedBox(
                    width: effectiveThumbRadius * 2,
                    height: effectiveThumbRadius * 2,
                  ),
                );

          final panHandler = onPanUpdate;
          return Semantics(
            slider: true,
            value: semanticValue,
            child: ShadGestureDetector(
              cursor: enabled
                  ? effectiveMouseCursor
                  : effectiveDisabledMouseCursor,
              onTapDown: enabled ? (_) => focusNode.requestFocus() : null,
              onPanStart:
                  enabled &&
                      panHandler != null &&
                      (allowedInteraction ==
                              ShadSliderInteraction.tapAndSlide ||
                          allowedInteraction ==
                              ShadSliderInteraction.slideOnly ||
                          allowedInteraction ==
                              ShadSliderInteraction.slideThumb)
                  ? (_) {
                      focusNode.requestFocus();
                      onPanStart?.call();
                    }
                  : null,
              onPanUpdate: enabled && panHandler != null
                  ? (details) => panHandler(details.globalPosition)
                  : null,
              onPanEnd: enabled ? (_) => onPanEnd?.call() : null,
              child: SizedBox(
                width: hitWidth,
                height: hitHeight,
                child: Center(child: thumbChild),
              ),
            ),
          );
        },
      ),
    );
  }
}
