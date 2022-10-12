/*

Copyright (c) 2021, Guy Kaplan
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
* Neither the name of the Guy Kaplan nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL GUY KAPLAN BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/

import 'package:flutter/material.dart';
import 'package:diffutil_dart/diffutil.dart';

const _duration = Duration(milliseconds: 175);

class AutomaticAnimatedList<T> extends StatefulWidget {
  const AutomaticAnimatedList({
    Key? key,
    required this.items,
    required this.itemBuilder,
    required this.keyingFunction,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.insertDuration = _duration,
    this.removeDuration = _duration,
  }) : super(key: key);

  final List<T> items;
  final Widget Function(BuildContext, T, Animation<double>) itemBuilder;
  final Key Function(T item) keyingFunction;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final Duration insertDuration;
  final Duration removeDuration;

  @override
  State<AutomaticAnimatedList<T>> createState() => _AutomaticAnimatedListState<T>();
}

class _AutomaticAnimatedListState<T> extends State<AutomaticAnimatedList<T>> {
  final _listKey = GlobalKey<AnimatedListState>();

  void didUpdateWidget(AutomaticAnimatedList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    final oldKeys =
        oldWidget.items.map((T e) => oldWidget.keyingFunction(e)).toList();
    final newKeys =
        widget.items.map((T e) => widget.keyingFunction(e)).toList();

    for (final update
        in calculateListDiff<Key>(oldKeys, newKeys, detectMoves: false)
            .getUpdatesWithData()) {
      if (update is DataInsert<Key>) {
        _listKey.currentState!
            .insertItem(update.position, duration: widget.insertDuration);
      } else if (update is DataRemove<Key>) {
        _listKey.currentState!.removeItem(
          update.position,
          (context, animation) => oldWidget.itemBuilder(
              context, oldWidget.items[update.position], animation),
          duration: widget.removeDuration,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedList(
        key: _listKey,
        scrollDirection: widget.scrollDirection,
        reverse: widget.reverse,
        controller: widget.controller,
        primary: widget.primary,
        physics: widget.physics,
        shrinkWrap: widget.shrinkWrap,
        padding: widget.padding,
        initialItemCount: widget.items.length,
        itemBuilder:
            (BuildContext context, int index, Animation<double> animation) =>
                widget.itemBuilder(context, widget.items[index], animation),
      );
}
