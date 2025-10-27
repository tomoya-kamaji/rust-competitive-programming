#!/bin/bash

# 競技プログラミング用の実行スクリプト

# 引数チェック
if [ $# -eq 0 ]; then
    echo "使用方法: $0 <問題名> [入力ファイル]"
    echo "例: $0 a"
    echo "例: $0 a input.txt"
    exit 1
fi

PROBLEM=$1
INPUT_FILE=${2:-""}

# 問題ファイルが存在するかチェック
if [ ! -f "src/bin/${PROBLEM}.rs" ]; then
    echo "問題ファイル src/bin/${PROBLEM}.rs が見つかりません。"
    echo "テンプレートから作成しますか？ (y/n)"
    read -r answer
    if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
        mkdir -p src/bin
        cp template.rs "src/bin/${PROBLEM}.rs"
        echo "src/bin/${PROBLEM}.rs を作成しました。"
    else
        exit 1
    fi
fi

# ビルド
echo "ビルド中..."
if ! cargo build --bin "$PROBLEM" --release; then
    echo "ビルドに失敗しました。"
    exit 1
fi

# 実行
echo "実行中..."
if [ -n "$INPUT_FILE" ] && [ -f "$INPUT_FILE" ]; then
    # 入力ファイルがある場合
    time ./target/release/"$PROBLEM" < "$INPUT_FILE"
else
    # 標準入力から読み取る場合
    time ./target/release/"$PROBLEM"
fi
