#!/bin/bash

# 新しい問題用のファイルを作成するスクリプト

# 引数チェック
if [ $# -eq 0 ]; then
    echo "使用方法: $0 <問題名>"
    echo "例: $0 a"
    exit 1
fi

PROBLEM=$1

# ディレクトリ作成
mkdir -p src/bin
mkdir -p "tests/${PROBLEM}"

# 問題ファイルを作成（既に存在する場合は上書きしない）
if [ ! -f "src/bin/${PROBLEM}.rs" ]; then
    cp template.rs "src/bin/${PROBLEM}.rs"
    echo "✅ src/bin/${PROBLEM}.rs を作成しました。"
else
    echo "⚠️  src/bin/${PROBLEM}.rs は既に存在します。"
fi

# サンプル入力ファイルを作成
if [ ! -f "tests/${PROBLEM}/input1.txt" ]; then
    touch "tests/${PROBLEM}/input1.txt"
    echo "✅ tests/${PROBLEM}/input1.txt を作成しました。"
else
    echo "⚠️  tests/${PROBLEM}/input1.txt は既に存在します。"
fi

# サンプル出力ファイルを作成
if [ ! -f "tests/${PROBLEM}/output1.txt" ]; then
    touch "tests/${PROBLEM}/output1.txt"
    echo "✅ tests/${PROBLEM}/output1.txt を作成しました。"
else
    echo "⚠️  tests/${PROBLEM}/output1.txt は既に存在します。"
fi

echo ""
echo "🎯 問題 '${PROBLEM}' の準備が完了しました！"
echo ""
echo "次のステップ:"
echo "1. tests/${PROBLEM}/input1.txt にサンプル入力を記述"
echo "2. tests/${PROBLEM}/output1.txt にサンプル出力を記述"
echo "3. src/bin/${PROBLEM}.rs に解法を実装"
echo "4. ./test.sh ${PROBLEM} でテスト実行"
echo "5. ./run.sh ${PROBLEM} で実行"
