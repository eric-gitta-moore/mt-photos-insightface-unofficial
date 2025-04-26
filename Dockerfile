FROM pytorch/pytorch:2.6.0-cuda12.4-cudnn9-devel
USER root
COPY --from=ghcr.io/astral-sh/uv:0.6 /uv /uvx /bin/

WORKDIR /app
COPY . .

# 安装依赖包
RUN uv sync --frozen --no-dev

ENV API_AUTH_KEY=mt_photos_ai_extra
ENV RECOGNITION_MODEL=buffalo_l
ENV DETECTION_THRESH=0.65
EXPOSE 8066

ENV PATH="/app/.venv/bin:$PATH"

VOLUME ["/root/.insightface/models"]

CMD [ "python3", "server.py" ]
