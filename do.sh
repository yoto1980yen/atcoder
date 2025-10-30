#!/bin/bash
## ファイル名：exec.sh
## AHC用のスクリプト
## Visualizerにて100ケースダウンロードしatcoderディレクトリに配置する
## 実行するrubyファイルを編集し実行
## outディレクトリが作成されるのでダウンロードしVisualizerに反映seed0の時にアップロードすること

for num in $(seq 0 99); do
    printf "%04d\n" "${num}"
    S=$(printf "%04d\n" "${num}") 
    ruby ./ahc/ahc054/a.rb < ./in/${S}.txt > ./out/${S}.txt
done