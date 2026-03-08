# CLAUDE.md — AIアシスタント向けガイド

このファイルは、AIコーディングアシスタント（Claude Code等）がこのリポジトリで作業する際に参照するガイドです。

---

## プロジェクト概要

| 項目 | 内容 |
|------|------|
| アプリ名 | タスク管理アプリ |
| パッケージ名 | `task_management_flutter` |
| バージョン | `1.0.0+1` |
| Dart SDK | `^3.10.0` |
| 言語 | Dart / Flutter |
| UIフレームワーク | Material Design 3 |

シンプルなFlutterモバイルアプリです。タスクのタイトル・優先度・メモ・完了状態を管理します。現時点ではメモリ上のみで動作し、永続化はありません。

---

## ディレクトリ構成

```
task-management-flutter/
├── lib/
│   ├── main.dart               # アプリのエントリーポイント、TaskListPage
│   ├── models/
│   │   └── task.dart           # Taskデータモデル
│   └── widgets/
│       └── task_card.dart      # タスク表示カードウィジェット
├── test/
│   └── widget_test.dart        # ウィジェットテスト（要更新）
├── android/                    # Android プラットフォーム設定
├── ios/                        # iOS プラットフォーム設定
├── .github/
│   └── workflows/
│       └── dart.yml            # CI/CD（GitHub Actions）
├── pubspec.yaml                # 依存関係・プロジェクト設定
├── analysis_options.yaml       # Dart/Flutter リント設定
└── README.md
```

---

## アーキテクチャ

### 状態管理

**パターン:** `StatefulWidget` + `setState()`（ローカル状態管理）

- 状態は `_TaskListPageState` 内の `_tasks` リストで一元管理
- Provider、Riverpod、BLoC、GetX 等の外部状態管理ライブラリは**使用していない**
- 機能追加でスコープが広がる場合は Riverpod の導入を検討してください

### データフロー

```
_tasks (List<Task>)
  └─ setState() で更新
       └─ ListView.builder → TaskCard (StatelessWidget)
```

### ファイルの役割

- **`main.dart`** — `MyApp`（MaterialApp設定）と `TaskListPage`（メイン画面）を定義
- **`models/task.dart`** — `Task` データクラス。ビジネスロジックは持たない
- **`widgets/task_card.dart`** — 単一タスクを表示する純粋なプレゼンテーションウィジェット

---

## データモデル

### Task (`lib/models/task.dart`)

```dart
class Task {
  String title;      // タスクタイトル（必須）
  bool isDone;       // 完了フラグ（デフォルト: false）
  int priority;      // 優先度（必須、数値が大きいほど高優先）
  String? memo;      // メモ（任意）
}
```

---

## 依存関係

### 本番依存

| パッケージ | バージョン | 用途 |
|-----------|-----------|------|
| `flutter` | SDK | UIフレームワーク |
| `cupertino_icons` | `^1.0.8` | iOS スタイルアイコン |

### 開発依存

| パッケージ | バージョン | 用途 |
|-----------|-----------|------|
| `flutter_test` | SDK | テストフレームワーク |
| `flutter_lints` | `^6.0.0` | 推奨リントルール |

依存関係を追加する際は `pubspec.yaml` を編集後、`flutter pub get` を実行してください。

---

## 開発ワークフロー

### セットアップ

```bash
flutter pub get
```

### 実行

```bash
flutter run                  # デフォルトデバイスで起動
flutter run -d android       # Android
flutter run -d ios           # iOS
```

### テスト

```bash
flutter test                 # 全テスト実行
flutter test test/widget_test.dart  # 特定ファイルのみ
```

### 静的解析

```bash
flutter analyze
```

### ビルド

```bash
flutter build apk            # Android APK
flutter build ios            # iOS
flutter build web            # Web
```

---

## CI/CD（GitHub Actions）

**ファイル:** `.github/workflows/dart.yml`

**トリガー:**
- `develop` ブランチへの push
- `develop` ブランチへの Pull Request

**ステップ:**
1. コードチェックアウト
2. Dart SDK セットアップ
3. `dart pub get` — 依存関係のインストール
4. `dart analyze` — 静的解析
5. `dart test` — テスト実行

**注意:** CIは `dart` コマンドを使用しています（`flutter` ではなく）。Dart のみで実行できるテスト・解析であることを確認してください。

---

## コーディング規約

### 全般

- **Dart 公式スタイルガイド**に従う（`flutter_lints` で強制）
- ファイル名はスネークケース: `task_card.dart`
- クラス名はパスカルケース: `TaskCard`
- 変数・メソッド名はキャメルケース: `isDone`, `addTask()`
- プライベートメンバーはアンダースコア接頭辞: `_tasks`, `_addTask()`

### ウィジェット設計

- 状態を持たない純粋な表示ウィジェットは `StatelessWidget` で作成
- ウィジェットは `lib/widgets/` に配置
- ウィジェットは可能な限り小さく、単一責任を持つように設計する

### モデル設計

- モデルは `lib/models/` に配置
- モデルクラスはビジネスロジックを持たない（データ構造のみ）

### 日本語対応

- UIテキストは日本語で記述（例: アプリタイトル「タスク管理アプリ」）
- ユーザー向けの文字列は日本語を使用する

---

## 既知の課題・今後の改善点

| 課題 | 詳細 |
|------|------|
| テストが古い | `widget_test.dart` はカウンターアプリのボイラープレートのまま。実際のタスク管理機能に対応したテストへの更新が必要 |
| 永続化なし | アプリを再起動するとタスクが消える。`shared_preferences` や `sqflite` 等の導入を検討 |
| 単一画面 | タスク詳細・編集・追加画面がない。ルーティング（`go_router` 等）の追加が必要 |
| 状態管理の拡張性 | 機能追加に伴い `setState` では限界がある。Riverpod 等の導入を検討 |
| タスク削除・編集 | 現時点では削除・編集機能が未実装 |

---

## AIアシスタントへの注意事項

1. **テストを更新する際**は、既存のカウンターテストを削除し、タスク追加・表示・完了などの実際の機能をテストするコードを書いてください
2. **新しい画面を追加する際**は `lib/screens/` ディレクトリを作成し、画面ウィジェットをそこに配置してください
3. **状態管理を拡張する場合**は Riverpod (`flutter_riverpod`) の採用を推奨します
4. **永続化を追加する場合**は `sqflite` または `hive` を推奨します
5. **`dart analyze` と `flutter test` が通ることを確認**してからコードを提出してください
6. **UIテキストは日本語**を使用してください
