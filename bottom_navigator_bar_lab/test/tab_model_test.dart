import 'package:flutter_test/flutter_test.dart';

import 'package:bottom_navigator_bar_lab/tab_model.dart';

void main() {
  test('setIndex updates index and notifies listeners', () {
    final model = TabModel();
    var notifications = 0;
    model.addListener(() => notifications++);

    model.setIndex(2);

    expect(model.currentIndex, 2);
    expect(notifications, 1);
  });

  test('setIndex with the current index does not notify', () {
    final model = TabModel();
    var notifications = 0;
    model.addListener(() => notifications++);

    model.setIndex(0);

    expect(model.currentIndex, 0);
    expect(notifications, 0);
  });
}
