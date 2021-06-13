FROM python:3.9-buster

LABEL mantainer="alfred richardsn <rchrdsn@protonmail.ch>"

ARG USER=nftgram
ARG GROUP=nftgram

ENV HOME /home/$USER

RUN groupadd -g 999 $GROUP \
 && useradd -g $GROUP -u 999 -l -s /sbin/nologin -m -d $HOME $USER
WORKDIR $HOME
USER $USER:$GROUP

COPY --chown=999:999 requirements.txt ./
ENV PATH $PATH:$HOME/.local/bin
RUN pip install --user --no-cache-dir --requirement requirements.txt

COPY --chown=999:999 locales/ locales/
RUN pybabel compile --directory=locales/ --domain=bot

COPY --chown=999:999 . .

ENTRYPOINT ["python", "-m", "nftgram"]
