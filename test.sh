#!/bin/bash

# 競技プログラミング用のテストスクリプト

# 引数チェック
if [ $# -eq 0 ]; then
    echo "使用方法: $0 <問題名>"
    echo "例: $0 a"
    exit 1
fi

PROBLEM=$1

# 問題ファイルが存在するかチェック
if [ ! -f "src/bin/${PROBLEM}.rs" ]; then
    echo "問題ファイル src/bin/${PROBLEM}.rs が見つかりません。"
    exit 1
fi

# テストケースディレクトリを作成
mkdir -p "tests/${PROBLEM}"

# ビルド
echo "ビルド中..."
if ! cargo build --bin "$PROBLEM" --release; then
    echo "ビルドに失敗しました。"
    exit 1
fi

# テストケースを実行
echo "テスト実行中..."
test_count=0
pass_count=0

for input_file in tests/"${PROBLEM}"/input*.txt; do
    if [ ! -f "$input_file" ]; then
        echo "テストケースが見つかりません。tests/${PROBLEM}/input*.txt を作成してください。"
        exit 1
    fi
    
    # 対応する出力ファイルを探す
    output_file=${input_file/input/output}
    
    if [ ! -f "$output_file" ]; then
        echo "警告: $output_file が見つかりません。スキップします。"
        continue
    fi
    
    test_count=$((test_count + 1))
    echo "テストケース $test_count: $(basename "$input_file")"
    
    # 実行して結果を比較
    actual_output=$(./target/release/"$PROBLEM" < "$input_file")
    expected_output=$(cat "$output_file")
    
    if [ "$actual_output" = "$expected_output" ]; then
        echo "✅ PASS"
        pass_count=$((pass_count + 1))
    else
        echo "❌ FAIL"
        echo "期待値:"
        echo "$expected_output"
        echo "実際の出力:"
        echo "$actual_output"
    fi
    echo ""
done

echo "結果: $pass_count/$test_count テストケースが通過しました。"

if [ $pass_count -eq $test_count ] && [ $test_count -gt 0 ]; then
    echo "🎉 すべてのテストケースが通過しました！"
    exit 0
else
    exit 1
fi
