FROM gcr.io/nana-direct-cloud/frappebase:latest

COPY --chown=frappe ./ apps/frappe

RUN env/bin/pip install -e apps/frappe
