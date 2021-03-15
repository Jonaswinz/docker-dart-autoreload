FROM google/dart:beta

WORKDIR /app/

ADD ./app/pubspec.yaml /app/
ADD ./filewatcher.sh /app/

RUN pub get
ADD ./app/bin/ /app/bin/
RUN pub get --offline

ENTRYPOINT ["bash", "/app/filewatcher.sh"]