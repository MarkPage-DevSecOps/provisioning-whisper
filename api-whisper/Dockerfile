FROM alpine:3.18.3 as ffmpeg-builder

RUN cd /usr/local/bin && \
    mkdir ffmpeg && \
    cd ffmpeg/ && \
    wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz && \
    tar xvf *.tar.xz && \
    rm -f *.tar.xz && \
    mv ffmpeg-git-*-amd64-static/ffmpeg .

FROM public.ecr.aws/lambda/python:3.10

COPY --from=ffmpeg-builder /usr/local/bin/ffmpeg/ffmpeg /usr/local/bin/ffmpeg/ffmpeg
RUN ln -s /usr/local/bin/ffmpeg/ffmpeg /usr/bin/ffmpeg

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY audio.mp3 .
RUN whisper audio.mp3 --model tiny --model_dir .
# --model {tiny.en,tiny,base.en,base,small.en,small,medium.en,medium,large-v1,large-v2,large}
COPY lambda_function.py .
RUN ls && pwd

CMD ["lambda_function.lambda_handler"]