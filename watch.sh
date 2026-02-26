#!/bin/bash

# watch.sh - HTML 파일 변경 감시 및 자동 빌드/실행
# 사용법: ./watch.sh

REPO_ROOT=$(cd "$(dirname "$0")" && pwd)
cd "$REPO_ROOT"

# fswatch 설치 확인
if ! command -v fswatch &> /dev/null; then
    echo "fswatch가 설치되어 있지 않습니다."
    echo "설치: brew install fswatch"
    exit 1
fi

echo "HTML 파일 감시 시작..."
echo "감시 경로: $REPO_ROOT/public"
echo "중지하려면 Ctrl+C를 누르세요."
echo ""

# public 디렉토리의 HTML 파일 변경 감시
# -e: 제외 패턴 (디렉토리, .swp 파일)
# -i: 포함 패턴 (HTML 파일만)
# --batch: 일괄 처리
fswatch -e IsDirectory -e '\.swp$' -i '\.html$' \
  --batch \
  --latency 0.5 \
  "$REPO_ROOT/public" | while read -r changed; do
  echo "[$(date '+%H:%M:%S')] 파일 변경 감지: $changed"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  ./run.sh
  echo ""
done
