FROM python:3.10.8

RUN \
  apt-get update \
  # && apt-get install --no-install-recommends -y some-pkg \
  && pip3 install --no-cache-dir --upgrade pip \
  && rm -rf /var/lib/apt/lists/*

ADD requirements/requirements.txt /requirements/

RUN pip3 install --no-cache-dir -r /requirements/requirements.txt

ENV APP_DIR /concertline
WORKDIR $APP_DIR
ADD . $APP_DIR

RUN pip install --editable .

CMD ["python", "-c", "print(__import__('concertline').__version__)"]
