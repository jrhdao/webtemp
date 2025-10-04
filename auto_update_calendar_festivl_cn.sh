#!/bin/bash
# ----------------------------------------
# 自动下载并更新文件脚本
# 用途: 定期从远程URL下载文件并更新本地副本
# ----------------------------------------

# === 配置部分 ===
URL="https://raw.githubusercontent.com/NateScarlet/holiday-cn/refs/heads/master/holiday-cn.ics"   # 要下载的文件URL
SAVE_DIR="/home/user/downloads"           # 文件保存目录
SAVE_FILE="holiday-cn.ics"                      # 本地文件名
LOG_FILE="/home/user/downloads/update.log" # 日志文件

# === 不建议修改以下部分 ===
cd "$SAVE_DIR" || { echo "目录不存在：$SAVE_DIR"; exit 1; }

echo "----------------------------------------" >> "$LOG_FILE"
echo "$(date '+%Y-%m-%d %H:%M:%S') - 检查更新..." >> "$LOG_FILE"

# 下载到临时文件
TEMP_FILE="${SAVE_FILE}.tmp"

# 使用 curl 下载（支持断点续传和更新时间检测）
curl -z "$SAVE_FILE" -o "$TEMP_FILE" -L --silent --show-error "$URL"

# 检查是否有更新
if [ -s "$TEMP_FILE" ]; then
    mv "$TEMP_FILE" "$SAVE_FILE"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - 文件已更新: $SAVE_FILE" >> "$LOG_FILE"
else
    rm -f "$TEMP_FILE"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - 文件未变化" >> "$LOG_FILE"
fi
