# syntax=docker/dockerfile:1



ARG PYTHON_VERSION=3.13.1

FROM python:${PYTHON_VERSION}-slim 

RUN apt-get update && apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

ENV PYTHONDONTWRITEBYTECODE=1

ENV PYTHONUNBUFFERED=1

WORKDIR /app


COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .
RUN useradd -m -u 1000 appuser && \
    chown -R appuser:appuser /app
USER appuser

EXPOSE 8000

CMD ["python" , "manage.py" ,"runserver"]
