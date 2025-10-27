# 競技プログラミング用 Rust 環境

このプロジェクトは競技プログラミング用に最適化された Rust 環境です。

## 特徴

- 高速化のための最適化設定
- 競技プログラミングでよく使われるライブラリを事前に追加
- 便利なユーティリティ関数とマクロ
- 問題管理とテスト実行のためのスクリプト

## セットアップ

```bash
cd competitive_programming
cargo build --release
```

## 使い方

### 1. 新しい問題の準備

```bash
just new <問題名>
```

例：

```bash
just new a
```

これにより以下のファイルが作成されます：

- `problems/a/problem.md` - 問題文を記述
- `problems/a/solution.rs` - 実装とテスト

### 2. 解法の実装

`problems/<問題名>/solution.rs` に解法を実装します。自動的に `src/bin/<問題名>.rs` に同期されます。

### 3. テストの実行

```bash
just test <問題名>
```

例：

```bash
just test a
```

### 4. プログラムの実行

```bash
just run <問題名>
```

例：

```bash
just run a
```

## 含まれているライブラリ

- `proconio` - 入力処理
- `itertools` - イテレータの拡張
- `num` - 数値計算
- `petgraph` - グラフアルゴリズム
- `indexmap` - 順序付きマップ
- `rustc-hash` - 高速ハッシュマップ
- `smallvec` - 小さなベクタの最適化
- `regex` - 正規表現

## ユーティリティ関数

`src/lib.rs` に以下の関数が含まれています：

- `gcd(a, b)` - 最大公約数
- `lcm(a, b)` - 最小公倍数
- `is_prime(n)` - 素数判定
- `prime_factors(n)` - 素因数分解
- `mod_pow(base, exp, mod)` - 累乗（mod 付き）
- `Combinatorics` - 順列・組み合わせ
- `UnionFind` - Union-Find 木

## マクロ

- `min!(a, b, c, ...)` - 複数の値の最小値
- `max!(a, b, c, ...)` - 複数の値の最大値
- `chmin!(a, b)` - a を min(a, b)で更新
- `chmax!(a, b)` - a を max(a, b)で更新

## ディレクトリ構造

```
competitive_programming/
├── Cargo.toml          # 依存関係と最適化設定
├── template.rs         # 問題用テンプレート
├── new_problem.sh      # 新しい問題の準備
├── Justfile           # タスクランナー
├── src/
│   ├── main.rs        # メインファイル
│   ├── lib.rs         # ユーティリティライブラリ
│   └── bin/           # 各問題の解法（自動生成）
│       ├── a.rs
│       ├── b.rs
│       └── ...
└── problems/          # 問題の実装とドキュメント
    ├── a/
    │   ├── problem.md  # 問題文
    │   └── solution.rs # 実装とテスト
    ├── b/
    │   ├── problem.md
    │   └── solution.rs
    └── template/
        ├── problem.md
        └── solution.rs
```

## 最適化設定

- LTO（Link Time Optimization）有効
- コード生成単位を 1 に設定
- パニック時は即座に終了
- 開発時も軽い最適化を適用

これらの設定により、実行時間が大幅に短縮されます。
