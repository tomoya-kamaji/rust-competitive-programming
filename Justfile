# 競技プログラミング用 Justfile

# デフォルトターゲット: ヘルプ表示
default:
    @just --list

# ========================================
# 問題管理
# ========================================

# 新しい問題を作成する
# Usage: just new <問題名>
new problem:
    @./new_problem.sh {{problem}}
    @just sync {{problem}}

# 問題のsolution.rsをsrc/binに同期（ビルド用）
# Usage: just sync <問題名>
sync problem:
    @if [ -f "problems/{{problem}}/solution.rs" ]; then \
        cp problems/{{problem}}/solution.rs src/bin/{{problem}}.rs; \
        echo "✅ src/bin/{{problem}}.rs を更新しました。"; \
    else \
        echo "❌ problems/{{problem}}/solution.rs が見つかりません。"; \
        exit 1; \
    fi

# ========================================
# ビルド・実行
# ========================================

# 指定された問題をリリースビルド
# Usage: just build <問題名>
build problem:
    @just sync {{problem}}
    @echo "ビルド中..."
    cargo build --bin {{problem}} --release

# 指定された問題を実行
# Usage: just run <問題名> [入力ファイル]
run problem input:
    @if [ -n "{{input}}" ]; then \
        ./run.sh {{problem}} {{input}}; \
    else \
        ./run.sh {{problem}}; \
    fi

# 標準入力から実行（入力ファイル指定なし）
# Usage: just run-stdin <問題名>
run-stdin problem:
    @./run.sh {{problem}}

# ファイルから実行
# Usage: just run-file <問題名> <入力ファイル>
run-file problem input:
    @./run.sh {{problem}} {{input}}

# ========================================
# テスト
# ========================================

# 指定された問題のRust標準テストを実行
# Usage: just test <問題名>
test problem:
    @echo "🧪 テスト実行中..."
    cargo test --bin {{problem}}

# 指定された問題のファイルベーステストを実行
# Usage: just test-file <問題名>
test-file problem:
    @echo "🧪 ファイルベーステスト実行中..."
    @./test.sh {{problem}}

# ========================================
# ユーティリティ
# ========================================

# すべてのバイナリをリリースビルド
build-all:
    @echo "すべてのバイナリをビルド中..."
    cargo build --release --bins

# キャッシュをクリーンアップ
clean:
    @echo "クリーンアップ中..."
    cargo clean

# リントチェック
lint:
    @echo "リントチェック中..."
    cargo clippy

# フォーマットチェック
fmt-check:
    @echo "フォーマットチェック中..."
    cargo fmt -- --check

# フォーマット適用
fmt:
    @echo "フォーマット適用中..."
    cargo fmt

# すべてのテストを実行（ユニットテスト）
unit-test:
    @echo "ユニットテスト実行中..."
    cargo test

# 問題リストを表示
list:
    @echo "📋 問題一覧:"
    @if [ -d "problems" ]; then \
        ls problems/*/solution.rs 2>/dev/null | sed 's|problems/||' | sed 's|/solution.rs||' | grep -v '^template$' | sort; \
    else \
        echo "問題がありません"; \
    fi

# ========================================
# 短縮コマンド（Justfileの構文として直接サポートされないためコメントとして記載）
# ========================================

# 短縮コマンド使用例:
#   just new a    → 新しい問題 'a' を作成
#   just test a   → 問題 'a' のテスト実行
#   just run a    → 問題 'a' を実行
#   just run a input.txt → 問題 'a' を入力ファイルから実行

# より短く使いたい場合は、シェルのaliasを使用してください:
#   alias jn='just new'
#   alias jt='just test'
#   alias jr='just run'
