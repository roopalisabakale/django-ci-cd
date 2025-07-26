# Use official Python base image
FROM python:3.9-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Create and set working directory
WORKDIR /app

# Install system dependencies (remove PostgreSQL-specific packages)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    python3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements first for caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy all project files
COPY . .

# Run database migrations (SQLite)
RUN python manage.py migrate

# Collect static files
RUN python manage.py collectstatic --noinput

# Expose port
EXPOSE 8000

# Run development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]