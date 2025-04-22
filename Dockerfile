FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Atualizações e dependências
RUN apt-get update && \
    apt-get install -y \
    curl wget git ffmpeg nodejs npm rclone cron \
    && apt-get clean

# Clonar Shinobi
RUN git clone https://gitlab.com/Shinobi-Systems/Shinobi.git /home/Shinobi

# Instalar dependências do Shinobi
WORKDIR /home/Shinobi
RUN npm install

# Copiar arquivos de configuração
COPY config/rclone.conf /root/.config/rclone/rclone.conf
COPY config/backup.sh /backup.sh

# Cron para rodar backup a cada 5 minutos
RUN chmod +x /backup.sh && echo "*/5 * * * * /backup.sh" > /etc/cron.d/shinobi-gdrive \
    && chmod 0644 /etc/cron.d/shinobi-gdrive && crontab /etc/cron.d/shinobi-gdrive

# Porta padrão do Shinobi
EXPOSE 8080

# Rodar cron e o Shinobi
CMD service cron start && npm start
