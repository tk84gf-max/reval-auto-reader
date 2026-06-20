#!/bin/bash
cd "$(dirname "$0")"
export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"
if ! command -v node >/dev/null 2>&1; then
  echo "[エラー] Node.js が見つかりません。https://nodejs.org からインストールしてください。"
  read -n1 -s; exit 1
fi
if [ ! -f "$HOME/.config/reval/apikey.txt" ]; then
  echo "[!] APIキー未設定。先に「初回設定_APIキー.command」を実行してください。"
  read -n1 -s; exit 1
fi
lsof -ti:5178 | xargs kill -9 2>/dev/null
echo "ReVal を起動します。数秒でブラウザが開きます -> http://localhost:5178"
echo "このウィンドウは開いたままに（閉じると停止）。落ちても自動再起動します。"
( sleep 2; open "http://localhost:5178" ) &
while true; do
  node server.js
  echo "[!] 停止しました。3秒後に再起動...（やめるならウィンドウを閉じる）"
  sleep 3
done
