FROM python:3.7-alpine

RUN apk add -u chromium chromium-chromedriver mesa-gl
RUN adduser -S --uid 1001 --shell ash kiosk

WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY . .

RUN chmod +x /app/entrypoint.sh

USER kiosk
ENTRYPOINT [ "/bin/sh" , "-c", "/app/entrypoint.sh" ]
