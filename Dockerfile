FROM gcr.io/nana-direct-cloud/frappebase:latest

COPY --chown=frappe ./ apps/frappe

RUN env/bin/pip install --upgrade GitPython==2.1.15 gitdb2==2.0.6 gitdb==0.6.4 && \
    env/bin/pip install ipython pycurl Werkzeug==0.16.0 sseclient==0.0.27 gcloud==0.17.0 python_jwt pyotp==2.2.7 python-telegram-bot==12.5.1

RUN env/bin/pip install -e apps/frappe
