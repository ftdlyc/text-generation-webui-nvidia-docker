####################
### BUILD IMAGES ###
####################

FROM pytorch/pytorch:2.2.2-cuda12.1-cudnn8-devel

# Pre-reqs
RUN apt-get update && apt-get install --no-install-recommends -y \
    vim build-essential

RUN pip3 install --upgrade pip setuptools

# Copy and enable all scripts
COPY ./scripts /scripts
RUN chmod +x /scripts/*

# Copy requirements to src
RUN mkdir /src
COPY ./text-generation-webui/extensions /src/extensions
COPY ./text-generation-webui/requirements.txt /src/requirements.txt

# Install TensorRT-LLM
RUN apt install -y openmpi-bin libopenmpi-dev
ENV LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
RUN pip3 install tensorrt_llm==0.10.0 -U --pre --extra-index-url https://pypi.nvidia.com

# Install oobabooga/text-generation-webui
RUN pip3 install -r /src/requirements.txt

# Install extensions
RUN chmod +x /scripts/build_extensions.sh && \
    . /scripts/build_extensions.sh

######################
### RUNTIME IMAGES ###
######################

RUN mkdir /app
WORKDIR /app
EXPOSE 7860
EXPOSE 5000
EXPOSE 5005

# Required for Python print statements to appear in logs
ENV PYTHONUNBUFFERED=1

# Variant parameters
RUN echo "Nvidia Extended (TensorRT-LLM)" > /variant.txt
ENV EXTRA_LAUNCH_ARGS=""
CMD ["python3", "/app/server.py"]

# Run
ENTRYPOINT ["/scripts/docker-entrypoint.sh"]
