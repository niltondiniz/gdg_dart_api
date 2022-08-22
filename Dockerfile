FROM dart:stable

COPY . /app

WORKDIR /app

RUN dart pub get
RUN dart compile exe bin/gdg_2022_api.dart -o ./bin/server
CMD ["./bin/server"]