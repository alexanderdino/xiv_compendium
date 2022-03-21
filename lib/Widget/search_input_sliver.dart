import 'dart:async';
import 'package:flutter/cupertino.dart';

class SearchInputSliver extends StatefulWidget {
  const SearchInputSliver({
    Key? key,
    this.onChanged
  }) : super(key: key);

  final ValueChanged<String>? onChanged;

  @override
  _SearchInputSliverState createState() => _SearchInputSliverState();
}

class _SearchInputSliverState extends State<SearchInputSliver> {
  final StreamController<String> _textChangeStreamController = StreamController();
  late StreamSubscription _textChangesSubscription;
  Timer? _debounce;

  @override
  void initState() {
    _textChangesSubscription = _textChangeStreamController.stream
        .distinct()
        .listen((text) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();

      _debounce = Timer(const Duration(milliseconds: 500), () {
        final onChanged = widget.onChanged;
        if (onChanged != null) {
          onChanged(text);
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Padding(
      child: CupertinoSearchTextField(
        onChanged: _textChangeStreamController.add,
      ),
      padding: const EdgeInsets.all(16),
    );

  @override
  void dispose() {
    _textChangeStreamController.close();
    _textChangesSubscription.cancel();
    _debounce?.cancel();
    super.dispose();
  }
}
