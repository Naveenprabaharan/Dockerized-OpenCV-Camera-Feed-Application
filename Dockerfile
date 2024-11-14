# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Install the dependencies listed in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
RUN apt-get update && apt-get install -y libsm6
# Install OpenCV dependencies for GUI support and X11
RUN apt-get update && apt-get install -y \
    libx11-dev \
    libgtk-3-dev \
    libxcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    && rm -rf /var/lib/apt/lists/*

# Install OpenCV dependencies for GUI support
RUN apt-get update && apt-get install -y \
    libx11-dev \
    libgtk-3-dev \
    && rm -rf /var/lib/apt/lists/*

# Run the application when the container starts
CMD ["python", "./app.py"]
