FROM ufoym/deepo:pytorch

RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip install --upgrade --no-cache-dir --retries 10 --timeout 60" && \
    GIT_CLONE="git clone --depth 10" && \
    
    apt-get update && \
    
    $APT_INSTALL zip libsndfile1 && \
    $PIP_INSTALL jupyterlab scikit-image librosa pandas matplotlib && \
    
    # Make JupyterLab start in dark mode
    mkdir --parents /root/.jupyter/lab/user-settings/\@jupyterlab/apputils-extension && \
    printf "{\n    \"theme\": \"JupyterLab Dark\"\n}" > /root/.jupyter/lab/user-settings/\@jupyterlab/apputils-extension/themes.jupyterlab-settings && \
    
    # Clean up
    ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*

# Copy scripts
COPY copy_files/ /root/randomcnn/

ENV SHELL bash
WORKDIR /root
CMD ["jupyter", "lab", "--no-browser", "--ip=0.0.0.0", "--allow-root", "--NotebookApp.token=", "--notebook-dir=/root"]

#docker run -d mysecureimage /bin/true
#docker export [ID] | docker import - mysecureimage