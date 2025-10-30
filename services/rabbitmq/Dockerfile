FROM rabbitmq:4.0-management

COPY definitions.json /etc/rabbitmq/definitions.json

# Enable management + default user
ENV RABBITMQ_DEFAULT_USER=admin
ENV RABBITMQ_DEFAULT_PASS=admin
ENV RABBITMQ_LOAD_DEFINITIONS=/etc/rabbitmq/definitions.json
