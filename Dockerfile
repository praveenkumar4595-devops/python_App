# Use an official Python slim image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy dependencies file first (for caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Allow dynamic port configuration (default to 5000 if not set)
ENV APP_PORT=5000

# Expose the port dynamically using an argument
EXPOSE ${APP_PORT}

# Run the application with Gunicorn, binding to the dynamic port
ENTRYPOINT ["sh", "-c", "gunicorn --bind 0.0.0.0:${APP_PORT} app:app"]
