### 作成された環境の概要

**📁 プロジェクト場所**: `/Users/tomoya/dev/rust/competitive_programming/`

### 🚀 主な機能

1. **高速化設定**
   - LTO（Link Time Optimization）有効
   - リリースビルドで最大限の最適化
   - 開発時も軽い最適化を適用

2. **豊富なライブラリ**
   - `proconio` - 簡単な入力処理
   - `itertools` - イテレータの拡張機能
   - `num` - 数値計算ライブラリ群
   - `petgraph` - グラフアルゴリズム
   - その他競技プログラミングで頻繁に使用されるライブラリ

3. **便利なユーティリティ**
   - 最大公約数・最小公倍数
   - 素数判定・素因数分解
   - Union-Find木
   - 組み合わせ計算
   - 便利なマクロ（`min!`, `max!`, `chmin!`, `chmax!`）

4. **自動化スクリプト**
   - `./new_problem.sh <問題名>` - 新しい問題の準備
   - `./test.sh <問題名>` - テストケースの実行
   - `./run.sh <問題名>` - プログラムの実行

### 📝 使用方法

```bash
# プロジェクトディレクトリに移動
cd /Users/tomoya/dev/rust/competitive_programming

# 新しい問題（例：問題A）の準備
./new_problem.sh a

# テストケースを作成
echo "3" > tests/a/input1.txt
echo "3" > tests/a/output1.txt

# 解法を実装（src/bin/a.rs を編集）

# テスト実行
./test.sh a

# プログラム実行
./run.sh a
```

### 📂 ディレクトリ構造

```
competitive_programming/
├── src/bin/          # 各問題の解法
├── tests/           # テストケース
├── template.rs      # 問題用テンプレート
├── *.sh            # 自動化スクリプト
└── README.md       # 詳細な使用方法
```

環境は正常にテストされ、すぐに競技プログラミングを始められる状態です！`README.md`に詳細な使用方法が記載されているので、参考にしてください。