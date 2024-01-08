part of '../time_page.dart';

/*
  'stream' is deprecated and shouldn't be used. 
  .stream will be removed in 3.0.0. As a replacement, 
  either listen to the provider itself (AsyncValue) or 
  .future. Try replacing the use of the deprecated 
  member with the replacement.
*/

final tickerStreamProvider = StreamProvider<int>(
  (ref) => Stream.periodic(
    const Duration(seconds: 1),
    (i) => i + 1,
  ),
);
