import 'package:demos/providers/ticker_stream_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/*
  'stream' is deprecated and shouldn't be used. 
  .stream will be removed in 3.0.0. As a replacement, 
  either listen to the provider itself (AsyncValue) or 
  .future. Try replacing the use of the deprecated 
  member with the replacement.
*/

const names = [
  'Alice',
  'Bob',
  'Charlie',
  'David',
  'Eve',
  'Fred',
  'Ginny',
  'Harriet',
  'Ileana',
  'Joseph',
  'Kincaid',
  'Larry',
];

final namesStreamProvider = StreamProvider<List<String>>(
  (ref) => ref.watch(tickerStreamProvider.stream).map(
        (count) => names.getRange(0, count).toList(),
      ),
);
