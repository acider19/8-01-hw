#!/bin/bash
# restore_script.sh - Восстановление из резервной копии

REMOTE_SERVER="10.129.0.5"
REMOTE_DIR="/tmp/backup"

# Получаем список доступных резервных копий
echo "Доступные резервные копии:"
BACKUPS=$(ssh "$REMOTE_SERVER" "ls $REMOTE_DIR")
i=1
declare -A backup_map

for backup in $BACKUPS; do
    echo "$i. $backup"
    backup_map[$i]=$backup
    ((i++))
done

# Выбор резервной копии
echo -n "Выберите номер резервной копии для восстановления: "
read choice

SELECTED_BACKUP=${backup_map[$choice]}

if [ -z "$SELECTED_BACKUP" ]; then
    echo "Неверный выбор!"
    exit 1
fi

# Подтверждение восстановления
echo "Вы выбрали: $SELECTED_BACKUP"
echo "ВНИМАНИЕ: Это перезапишет текущие данные!"
echo -n "Продолжить? (y/N): "
read confirm

if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "Восстановление отменено"
    exit 0
fi

# Восстановление
echo "Начинаем восстановление..."
rsync -av "$REMOTE_SERVER:$REMOTE_DIR/$SELECTED_BACKUP/" "$HOME/"

echo "Восстановление завершено!"