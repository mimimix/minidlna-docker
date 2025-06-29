FROM ubuntu:jammy

# Install required packages
RUN apt-get update && apt-get install -y \
    minidlna \
    && rm -rf /var/lib/apt/lists/*

COPY lib/libjpeg62.deb /tmp/libjpeg62.deb
RUN dpkg -i /tmp/libjpeg62.deb && rm /tmp/libjpeg62.deb

COPY bin/minidlnad /usr/sbin/minidlnad

# Create media directory
RUN mkdir -p /media

COPY icons/png_sm.png /usr/local/share/minidlna/icons/png_sm.png
COPY icons/png_lrg.png /usr/local/share/minidlna/icons/png_lrg.png
COPY icons/jpeg_sm.jpeg /usr/local/share/minidlna/icons/jpeg_sm.jpeg
COPY icons/jpeg_lrg.jpeg /usr/local/share/minidlna/icons/jpeg_lrg.jpeg
RUN chmod +x /usr/sbin/minidlnad

# Start services
CMD ["./usr/sbin/minidlnad", "-d", "-f", "/etc/minidlna.conf"]
