# AI Usage Log

## Entry AI-005

**Date:** 2026-11-25

**Tool:** Claude (Claude Code)

**Task:** Vibe Task 5: move the bottom navigation tab index from `setState` into a Provider `TabModel` in `bottom_navigator_bar_lab`.

### Prompt (verbatim)

The branch and AI change did not exist yet when the first prompt was sent, so Claude Code generated the change after the follow-up prompt. Both prompts are recorded exactly as sent.

Prompt 1:

```
In C:\Users\User\Desktop\TMA3084_G02_99348_Lab05_Lesson07 on branch feature/vibe-task5-provider. Stop only if something fails.

1. Save the uncommitted AI change: git diff > docs/ai_diff_claude.txt. Commit everything as "feat(ai): move tab index into Provider TabModel (Claude output, unreviewed)".
2. Review that diff against docs/review_checklist.md for: unused code, naming, null safety, unnecessary rebuilds. For each real finding note the line, the problem, and the fix. If a category has no problem, say so honestly; do not invent defects.
3. Apply the fixes, keep UI and labels identical, update tests if needed. dart format ., flutter analyze, flutter test must pass. Commit "refactor: fix checklist findings in AI Provider refactor".
4. Write docs/LOGAI.md, Entry AI-005: date, tool "Claude (Claude Code)", the exact prompt verbatim, short summary of the AI output, findings table (Checklist item | Line | Problem | Fix), test results, decision.
5. Commit "docs: add LOGAI entry for Vibe Task 5", push, open a PR into main titled "refactor: Vibe Task 5 Provider TabModel" filling the PR template with LOGAI reference "docs/LOGAI.md Entry AI-005". Do NOT merge it.
6. Create C:\Users\User\Desktop\lab05_for_pdf.txt containing, each under a clear heading: git show main:bottom_navigator_bar_lab/lib/main.dart, and the same for screen1.dart, screen2.dart, screen3.dart, screen4.dart; git show main:data_table_lab/lib/main.dart; docs/ai_diff_claude.txt; docs/LOGAI.md; and the output of gh pr list --state all with URLs.
7. Print the Vibe PR URL and the path of lab05_for_pdf.txt.
```

Prompt 2 (after Claude reported that the branch and change did not exist and offered to generate them):

```
go ahead just do whats best
```

### Summary of AI output

Saved unreviewed in `docs/ai_diff_claude.txt`, commit `30b1e87`.

- Added the `provider` package to `pubspec.yaml`.
- New `lib/tab_model.dart`: `TabModel extends ChangeNotifier` with a private `_currentIndex`, a `currentIndex` getter and `setIndex(int)`.
- `lib/main.dart`: wrapped `MaterialApp` in `ChangeNotifierProvider`, removed the `currentIndex` field and `setState`, read the index with `Provider.of<TabModel>(context)` and updated it in `onTap` with `Provider.of<TabModel>(context, listen: false).setIndex(index)`.
- The UI, title, colours, icons and labels were unchanged. `flutter analyze` and the existing 2 widget tests passed on the unreviewed output.

### Findings (reviewed against docs/review_checklist.md)

Line numbers refer to the unreviewed AI output (commit `30b1e87`).

| Checklist item | Line | Problem | Fix |
|---|---|---|---|
| Unused code | `lib/main.dart:29-36` | `BottomNavLab` is still a `StatefulWidget` with a `State` class, but no mutable state is left after the index moved to `TabModel`. The `State` class is dead weight. | Made `BottomNavLab` a `StatelessWidget` and `screens` a `static const List<Widget>`. |
| Unused code | `lib/tab_model.dart:1` | Imports `package:flutter/material.dart` although only `ChangeNotifier` is used. | Import `package:flutter/foundation.dart` instead. |
| Naming | n/a | No problem found. `TabModel`, `currentIndex`, `setIndex`, `screens` and `tabModel` are clear and follow Dart naming. | None |
| Null safety | n/a | No problem found. There is no `!`, no nullable type, and the index is always a non-null `int` starting at 0. | None |
| Performance: unnecessary rebuilds | `lib/main.dart:46` | `Provider.of<TabModel>(context)` listens at the top of `build`, so every tab change rebuilds the whole `Scaffold`, including the `AppBar`. | Removed the top-level listen. Wrapped only `body` and `bottomNavigationBar` in `Selector<TabModel, int>`, and used `context.read<TabModel>()` in `onTap`. |
| Performance: unnecessary rebuilds | `lib/tab_model.dart:8-11` | `setIndex` calls `notifyListeners()` even when the tapped tab is already selected, which causes a pointless rebuild. | Return early when `index == _currentIndex`. |

### Test results

After the fixes (commit `8a1f28b`):

- `dart format --output=none --set-exit-if-changed .`: 0 files changed
- `flutter analyze`: No issues found!
- `flutter test`: 4 tests passed
  - `widget_test.dart`: "Starts on Home screen" and "Tapping each bar icon shows its screen" (unchanged, still passing, so the UI and labels are identical).
  - `tab_model_test.dart` (new): "setIndex updates index and notifies listeners" and "setIndex with the current index does not notify". The second test covers the rebuild fix.

### Decision

**Accepted with changes.** The Provider refactor is correct and keeps the UI identical. It was accepted after fixing 4 checklist findings: 2 for unused code and 2 for unnecessary rebuilds. Naming and null safety had no problems. Submitted for human review as a PR and not merged.
