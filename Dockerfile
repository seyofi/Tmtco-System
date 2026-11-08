FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONPATH=/app/server

WORKDIR /app
COPY server/requirements.txt /app/server/requirements.txt
RUN pip install --no-cache-dir -r /app/server/requirements.txt

COPY server/app /app/server/app
COPY server/supplier_search /app/server/supplier_search
COPY server/alembic.ini /app/server/alembic.ini
COPY server/migrations /app/server/migrations
COPY system /app/system
COPY smart_system_local.html /app/smart_system_local.html
COPY smart_system.html /app/smart_system.html

WORKDIR /app/server
CMD ["sh", "-c", "python -m alembic -c alembic.ini upgrade head && python -m uvicorn app.main:app --host 0.0.0.0 --port 8000"]