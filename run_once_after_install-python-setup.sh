#!/usr/bin/env bash

# start clean
# rm -rf $(pyenv root)
# curl -sSL https://install.python-poetry.org | POETRY_VERSION=1.7.0 POETRY_HOME=${HOME}/.poetry python3 - --uninstall


# Make sure python3 installation worked
if ! command -v python3 >/dev/null 2>&1; then
    echo "Please install python3"
    exit 1
fi

# Install pyenv and a sane python
if [[ ! -x "$(command -v pyenv)" ]]; then
   curl https://pyenv.run | bash
fi

export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

PYTHON_VERSION="3.11.8"
${HOME}/bin/pyenv_python_install ${PYTHON_VERSION}
pyenv global ${PYTHON_VERSION}

# Install poetry with the pyenv python
if [[ ! -x "$(command -v poetry)" ]]; then
    curl -sSL https://install.python-poetry.org | PYENV_VERSION=${PYTHON_VERSION} POETRY_VERSION=1.8.3 POETRY_HOME=${HOME}/.poetry python3 -
fi

python -m pip install --upgrade pip
pip install --requirement=/dev/stdin <<EOF
black
flake8
jedi
ruff
ruff-lsp
pylint
numpy
scipy
pandas
matplotlib
scikit-learn
seaborn
rope
yapf
emcee
corner
xarray
yt
jupyterlab
h5py
netcdf4
EOF
