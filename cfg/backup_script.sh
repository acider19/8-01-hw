#!/bin/bash
# backup_script.sh - Инкрементное резервное копирование

REMOTE_SERVER="10.129.0.5"
REMOTE_DIR="/tmp/backup"
BACKUP_NAME="backup_$(date +%Y%m%d_%H%M%S)"
LOCAL_DIR="$HOME"

# Создаем новую резервную копию
echo "Создание резервной копии: $BACKUP_NAME"
rsync -av --delete "$LOCAL_DIR/" "$REMOTE_SERVER:$REMOTE_DIR/$BACKUP_NAME/"

# Получаем список резервных копий и удаляем старые (оставляем последние 5)
ssh "$REMOTE_SERVER" "cd $REMOTE_DIR && ls -t | tail -n +6 | xargs -r rm -rf"

echo "Резервная копия создана: $BACKUP_NAME"
echo "Старые копии удалены, оставлены последние 5"