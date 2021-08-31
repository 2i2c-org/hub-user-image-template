#!/bin/bash -l

jupyter labextension install --debug \
    @jupyter-widgets/jupyterlab-manager@2 \
    @jupyterlab/server-proxy@2.1.1 \
    jupyterlab-jupytext@1.2.1 \
    dask-labextension@3.0.0

# Install jupyter-contrib-nbextensions
jupyter contrib nbextension install --sys-prefix --symlink
