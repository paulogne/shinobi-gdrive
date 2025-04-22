FROM shinobidocker/shinobi:dev

RUN apt update && apt install -y rclone cron

COPY config/rclone.conf /root/.config/rclone/rclone.conf
COPY config/backup.sh /backup.sh

RUN chmod +x /backup.sh && echo "*/5 * * * * /backup.sh" > /etc/cron.d/shinobi-gdrive \
    && chmod 0644 /etc/cron.d/shinobi-gdrive && crontab /etc/cron.d/shinobi-gdrive

CMD service cron start && /entrypoint.sh
