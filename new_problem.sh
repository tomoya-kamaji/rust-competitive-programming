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
mkdir -p "src/bin"  # 後方互換性のため

# 問題ディレクトリが既に存在するかチェック
if [ -d "problems/${PROBLEM}" ] && [ "$(ls -A problems/${PROBLEM} 2>/dev/null)" ]; then
    echo "⚠️  problems/${PROBLEM} は既に存在します。"
    exit 1
fi

# テンプレートからproblem.mdとsolution.rsを作成
cp problems/template/problem.md "problems/${PROBLEM}/problem.md"
cp problems/template/solution.rs "problems/${PROBLEM}/solution.rs"

# src/bin/にもコピー（後方互換性のため）
if [ ! -f "src/bin/${PROBLEM}.rs" ]; then
    cp problems/template/solution.rs "src/bin/${PROBLEM}.rs"
    echo "✅ src/bin/${PROBLEM}.rs を作成しました。"
fi

echo ""
echo "🎯 問題 '${PROBLEM}' の準備が完了しました！"
echo ""
echo "以下のファイルが作成されました:"
echo "  - problems/${PROBLEM}/problem.md (問題文)"
echo "  - problems/${PROBLEM}/solution.rs (実装)"
echo ""
echo "次のステップ:"
echo "1. problems/${PROBLEM}/problem.md に問題文を記述"
echo "2. problems/${PROBLEM}/solution.rs に解法を実装"
echo "3. just test ${PROBLEM} でテスト実行"
echo "4. just run ${PROBLEM} で実行"
