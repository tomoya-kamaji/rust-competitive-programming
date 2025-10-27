#!/bin/bash

# 新しい問題用のファイルを作成するスクリプト

# 引数チェック
if [ $# -eq 0 ]; then
    echo "使用方法: $0 <問題名>"
    echo "例: $0 c"
    exit 1
fi

PROBLEM=$1

# ディレクトリ作成
mkdir -p "problems/${PROBLEM}"
mkdir -p "src/bin"

# 既に存在するかチェック
if [ -f "src/bin/${PROBLEM}.rs" ]; then
    echo "⚠️  src/bin/${PROBLEM}.rs は既に存在します。"
    exit 1
fi

# テンプレートからsolution.rsを作成
cp template.rs "src/bin/${PROBLEM}.rs"
echo "✅ src/bin/${PROBLEM}.rs を作成しました。"

# 問題文も作成（参考用）
if [ ! -f "problems/${PROBLEM}/problem.md" ]; then
    cp problems/template/problem.md "problems/${PROBLEM}/problem.md"
    echo "✅ problems/${PROBLEM}/problem.md を作成しました。"
fi

# Cargo.tomlにbinを追加
if ! grep -q "name = \"${PROBLEM}\"" Cargo.toml 2>/dev/null; then
    cat >> Cargo.toml << EOF

[[bin]]
name = "${PROBLEM}"
path = "src/bin/${PROBLEM}.rs"
EOF
    echo "✅ Cargo.toml に ${PROBLEM} を追加しました。"
fi

echo ""
echo "🎯 問題 '${PROBLEM}' の準備が完了しました！"
echo ""
echo "以下のファイルが作成されました:"
echo "  - src/bin/${PROBLEM}.rs (編集・実装ファイル)"
echo "  - problems/${PROBLEM}/problem.md (問題文、参考用)"
echo ""
echo "次のステップ:"
echo "1. src/bin/${PROBLEM}.rs を編集して解法を実装"
echo "2. problems/${PROBLEM}/problem.md に問題文を記述"
echo "3. just test ${PROBLEM} でテスト実行"
echo "4. just run ${PROBLEM} で実行"
