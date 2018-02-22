FROM jupyter/base-notebook:27ba57364579

USER root

COPY jupyter_notebook_config.py /etc/jupyter/
RUN fix-permissions /etc/jupyter/

USER $NB_UID
