# first stage
FROM python:3.7.1 AS builder
COPY TelegramBotForYouTube/requirementsDocker.txt .

# install dependencies to the local user directory (eg. /root/.local)
RUN pip install --upgrade pip && pip install --user -r requirementsDocker.txt

# second stage
FROM python:3.7.1-slim
WORKDIR /code

# copy only the dependencies that are needed for our application and the source files
COPY --from=builder /root/.local /root/.local
COPY TelegramBotForYouTube .

# update PATH
ENV PATH=/root/.local:$PATH

# make sure you only include the -u flag to have our stdout logged
CMD [ "python", "-u", "./main.py" ]
