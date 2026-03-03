#!/usr/bin/env bash
set -euo pipefail

# 1. 환경 설정
REPO_DIR="/Users/persist/Desktop/My_Mathematics_Book"
PDF="main.pdf"
export PATH="/Library/TeX/texbin:/usr/local/bin:$PATH"

cd "$REPO_DIR"

# 2. LaTeX 컴파일
echo "🛠 LaTeX 빌드 중..."
pdflatex -interaction=nonstopmode main.tex > /dev/null || echo "⚠️ 빌드 중 경고가 있었으나 계속 진행합니다."

# 3. Git 업데이트 및 푸시
echo "📝 Git 업데이트 중..."
git add .
git diff --quiet --staged || git commit -m "Update Math Notes: $(date +'%Y-%m-%d %H:%M:%S')"

echo "📤 GitHub로 업로드 중..."
git push origin main

# 4. GitHub Pages 배포 (gh-pages 브랜치로 복사)
git push origin main:gh-pages --force

echo "✅ 모든 작업 완료!"
echo "🔗 PDF 확인: https://blueinkfountain.github.io/My_Mathematics_Book/main.pdf"