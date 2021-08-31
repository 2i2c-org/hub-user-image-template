FROM pangeo/pangeo-notebook:6b2df38

USER root
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH ${NB_PYTHON_PREFIX}/bin:$PATH

# Needed for apt-key to work
RUN apt-get update -qq --yes > /dev/null && \
    apt-get install --yes -qq gnupg2 > /dev/null

USER ${NB_USER}

COPY environment.yml /tmp/

RUN conda env update --name ${CONDA_ENV} -f /tmp/environment.yml

# Remove nb_conda_kernels from the env for now
RUN conda remove -n ${CONDA_ENV} nb_conda_kernels

COPY install-jupyter-extensions.bash /tmp/install-jupyter-extensions.bash
RUN /tmp/install-jupyter-extensions.bash

# Set bash as shell in terminado.
ADD jupyter_notebook_config.py  ${NB_PYTHON_PREFIX}/etc/jupyter/
# Disable history.
ADD ipython_config.py ${NB_PYTHON_PREFIX}/etc/ipython/
