FROM dddlab/base-rstudio:v20200720-d6cbe5a-94fdd01b492f
 
LABEL maintainer="Patrick Windmiller <windmiller@pstat.ucsb.edu>"

USER root

ENV PATH=$PATH:/usr/lib/rstudio-server/bin \
    R_HOME=/opt/conda/lib/R

RUN \
    # download R studio
    curl --silent -L --fail https://s3.amazonaws.com/rstudio-ide-build/server/bionic/amd64/rstudio-server-1.3.1056-amd64.deb > /tmp/rstudio.deb && \
    \
    # install R studio
    apt-get update && \
    apt-get install -y --no-install-recommends /tmp/rstudio.deb && \
    rm /tmp/rstudio.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update -y && \
    apt-get install -y libudunits2-dev libmagick++-dev

USER $NB_USER

RUN conda install -y r-base && \
    conda install -c conda-forge imagemagick && \
    conda install -c conda-forge r-rstan

RUN R -e "install.packages(c('tidyverse', 'lme4', 'rstan', 'brms'), repos = 'http://cran.us.r-project.org')"
