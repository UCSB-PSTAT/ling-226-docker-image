FROM dddlab/base-rstudio:v20200720-d6cbe5a-94fdd01b492f
 
LABEL maintainer="Patrick Windmiller <windmiller@pstat.ucsb.edu>"

USER $NB_USER

RUN conda install -y r-base && \
    conda install -c conda-forge udunits2 && \
    conda install -c conda-forge imagemagick && \
    conda install -c conda-forge r-rstan

RUN R -e "install.packages(c('tidyverse', 'lme4', 'rstan', 'brms'), repos = 'http://cran.us.r-project.org')"
