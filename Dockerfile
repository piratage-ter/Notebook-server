FROM python:3.8-slim
WORKDIR .
COPY requirements.txt /
RUN pip3 install -r requirements.txt
RUN pip3 install jupyter
COPY ./ ./
COPY jupyter_notebook_config.py ~/.jupyter/jupyter_notebook_config.py
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]
EXPOSE 8888
CMD [ "jupyter", "nbextension", "enable", "--py", "widgetsnbextension" ]
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]