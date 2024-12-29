# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy application and requirements to the container
COPY app.py /app
COPY requirements.txt /app

# Install necessary packages
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port the Flask app will run on
EXPOSE 5003

# Make the app executable
RUN chmod +x app.py

# Run the Flask application with OpenTelemetry instrumentation
CMD ["opentelemetry-instrument", "python", "app.py"]