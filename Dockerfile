# Use the official Python image with the appropriate version
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app.py .

# Modify the main route as required in the assignment
RUN sed -i "s/Hello Cloud! by Kumar/Welcome to Kumar Final Test API Server/" app.py

# Use Gunicorn as the WSGI server
RUN pip install gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]

# Expose port 5000
EXPOSE 5000