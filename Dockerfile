FROM rocm/rocm-terminal:5.6

# install preequirements
RUN apt-get install -y --no-install-recommends \
    build-essential python3.9 python3-pip python3-dev ffmpeg sox && \
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

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
CMD ["python", "src/webui.py","--listen-host", "0.0.0.0", "--listen-port", "7860", "--listen"]
