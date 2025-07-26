FROM python:3.10-slim

WORKDIR /app

# Combined and optimized package installation
RUN apt-get update -q && \
    apt-get install -y --no-install-recommends \
    python3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]