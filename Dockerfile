FROM dart:stable

RUN apt -y update && apt -y upgrade

WORKDIR /app
COPY pubspec.* .
RUN dart pub get


COPY . .
RUN dart pub get --offline
RUN dart compile exe bin/gdg_2022_api.dart -o bin/server

FROM alpine
COPY --from=0 /app/bin/server /app/bin/server
#COPY --from=0 /app/public/ /app/public/
EXPOSE 8080
ENTRYPOINT ["/app/bin/server"]