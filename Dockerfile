FROM rocm/dev-ubuntu-22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Los_Angeles

# install preequirements
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential python3.9 python3-pip python3-dev ffmpeg sox tzdata && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# update pip
RUN python3 -m pip install --upgrade pip

# Set the working directory in the container
WORKDIR /app
COPY . /app

# Install pip requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements_amd.txt

# Download required models
RUN python3 /app/src/download_models.py


EXPOSE 7860

CMD ["python3", "src/webui.py","--listen-host", "0.0.0.0", "--listen-port", "7860", "--listen"]
