FROM jwilder/nginx-proxy:latest

# optional: nếu bạn muốn bật hỗ trợ websocket hoặc tùy chỉnh thêm
ENV ENABLE_IPV6=true

# copy config tùy chỉnh nếu có
COPY conf.d/*.conf /etc/nginx/conf.d/
