#!/bin/sh

build(){
#    cd workplace
    # frappe repo path
    echo "[i] Frappe repo: $FRAPPE_PATH"
    echo "[i] Frappe branch: $FRAPPE_BRANCH"
    if [ "$FRAPPE_PATH" = "" ]; then
        FRAPPE_PATH="https://github.com/frappe/frappe.git"
    fi

    # frappe branch
    if [ "$FRAPPE_BRANCH" = "" ]; then
        FRAPPE_BRANCH="version-12"
    fi

    # Python Version
    if [ "$FRAPPE_PYTHON" = "" ]; then
        FRAPPE_PYTHON="python2.7"
    fi

    echo "[i] Python Version: $FRAPPE_PYTHON"
    if [ "$FRAPPE" = "" ]; then
        FRAPPE="frappe-bench"
    fi
    BENCH="bench-repo"
    echo "====================== Cloning bench ==============================="
    git clone -b $BENCH_BRANCH $BENCH_PATH $BENCH
    pip install --user -e bench-repo && rm -rf ~/.cache/pip
    echo "====================== bench init =================================="
    echo "frappe $FRAPPE frappe-path $FRAPPE_PATH "
    export PATH=$PATH:~/.local/bin/
    bench init $FRAPPE --frappe-path $FRAPPE_PATH --frappe-branch $FRAPPE_BRANCH  --python $FRAPPE_PYTHON --no-backups --skip-redis-config-generation --skip-assets --no-procfile

}

"$@"
