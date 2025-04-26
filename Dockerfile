FROM pytorch/pytorch:2.6.0-cuda12.4-cudnn9-runtime
COPY --from=ghcr.io/astral-sh/uv:0.6 /uv /uvx /bin/

WORKDIR /app
COPY . .

# 安装依赖包
RUN apt update && \
    apt install build-essential clang -y && \
    uv sync --frozen --no-dev && \
    conda install conda-forge::cudnn -y

# echo $LD_LIBRARY_PATH 确保这个下面包含了 libcudnn.so.9
ENV LD_LIBRARY_PATH="/opt/conda/lib:$LD_LIBRARY_PATH"

ENV API_AUTH_KEY=mt_photos_ai_extra
ENV RECOGNITION_MODEL=buffalo_l
ENV DETECTION_THRESH=0.65
EXPOSE 8066

ENV PATH="/app/.venv/bin:$PATH"

VOLUME ["/root/.insightface/models"]

CMD [ "python", "server.py" ]
