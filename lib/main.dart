import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      // This effects the placement of the trailing expanded/collapsed
      //  indicator.
      // When using Material3, it will be vertically-centered - otherwie it will
      //  remain in the upper-right of the tile, which I generally prefer
      // There may be a more directed way to achieve that...
      theme: ThemeData(useMaterial3: false),
      home: const ExpandableTile(
        mainText: someRandomText,
        subText: "Content",
      ),
    ),
  );
}

class ExpandableTile extends StatefulWidget {
  const ExpandableTile({
    required this.mainText,
    this.duration = kThemeAnimationDuration,
    this.subText,
    super.key,
  });

  final String mainText;
  final String? subText;
  final Duration duration;

  @override
  State<ExpandableTile> createState() => _ExpandableTileState();
}

class _ExpandableTileState extends State<ExpandableTile> {
  int? _lines = 2;
  bool get _isExpanded => _lines == null;
  void _toggleLines() {
    _isExpanded ? _lines = 2 : _lines = null;
  }

  Widget? get _subTitle => widget.subText == null
      ? null
      : Text("${widget.subText} (${_isExpanded ? "Full" : "Brief"})");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expandable Tile"),
      ),
      body: Card(
        child: ListTile(
          // helps with testing, to find the widget
          key: const ValueKey("ExpandableTile"),
          // this is the magic sauce that transforms this into an animating tile
          title: AnimatedSize(
            key: const ValueKey("AnimatedSize"),
            duration: widget.duration,
            child: Text(widget.mainText, maxLines: _lines),
          ),
          onTap: () => setState(() => _toggleLines()),
          subtitle: _subTitle,
          // Ignore the tap here so that the ListTile onTap handler catches it
          trailing: IgnorePointer(
            child: ExpandIcon(
              key: const ValueKey("ExpandIcon"),
              onPressed: (_) {},
              isExpanded: _isExpanded,
            ),
          ),
        ),
      ),
    );
  }
}

/// The sample data we will display inside the expanding tile
const someRandomText = "1\n2\n3\n4\n5\n6\n7\n8\n9\n10";
