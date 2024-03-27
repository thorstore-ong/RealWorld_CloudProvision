FROM python:3.8-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc libmysqlclient-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file
COPY requirements.txt /app/

# Set up virtual environment
RUN python -m venv venv

# Activate virtual environment
SHELL ["venv/bin/activate"]

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . /app/

# Run database migrations
RUN python manage.py migrate --noinput

# Set the command to run the server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
