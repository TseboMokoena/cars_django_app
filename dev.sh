#!/bin/bash
RESTORE='\033[0m'
RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\e[0;33m'

export PROJ_BASE="$(dirname "${BASH_SOURCE[0]}")"

CD=$(pwd)
cd $PROJ_BASE
export PROJ_BASE=$(pwd)
cd $CD

alias manage='python $PROJ_BASE/manage.py'

function devhelp {
    echo -e "${GREEN}devhelp${RESTORE}                      Prints this ${RED}help${RESTORE}"
    echo -e ""
    echo -e "${GREEN}migrate${RESTORE}                      Run migrations"
    echo -e ""
    echo -e "${GREEN}make_migrations${RESTORE}              Make migrations"
    echo -e ""
    echo -e "${GREEN}runserver${RESTORE}                    Runs the django server"
    echo -e ""
    echo -e "${GREEN}rebuild_virtualenv${RESTORE}           Rebuild virtualenv for this project"
    echo -e ""
    echo -e "${GREEN}import_data <file path>${RESTORE}      Import data from json file into database"
    echo -e ""
}

function migrate() {
    CD=$(pwd)
    cd $PROJ_BASE
    ./manage.py migrate
    cd $CD
}

function make_migrations() {
    CD=$(pwd)
    cd $PROJ_BASE
    ./manage.py makemigrations
    cd $CD
}

function import_data() {
    CD=$(pwd)
    cd $PROJ_BASE
    ./manage.py loaddata $@
    cd $CD
}

function runserver() {
    CD=$(pwd)
    cd $PROJ_BASE
    ./manage.py runserver
}

function rebuild_virtualenv() {
    CD=$(pwd)
    cd $PROJ_BASE

    source deactivate
    rm -rf .cars_env

    pyenv install --skip-existing

    python -m venv .cars_env
    source  $PROJ_BASE/.cars_env/bin/activate

    pip install --upgrade pip
    pip install -r requirements.txt

    cd $CD
}

function _create_git_aliases() {
    git config alias.co checkout
    git config alias.st status
    git config alias.ci commit
    git config alias.br branch
    git config alias.hist "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
}

function _copy_git_hooks {
    rm -f .git/hooks/commit-msg
    rm -f .git/hooks/pre-commit  && cp ci/pre-commit .git/hooks/pre-commit
    rm -f .git/hooks/pre-commit-main.py && cp ci/pre-commit-main.py .git/hooks/pre-commit-main.py
    rm -f .git/hooks/prepare-commit-msg && cp ci/prepare-commit-msg .git/hooks
}

function echo_red {
    echo -e "\e[31m$1\e[0m";
}

function echo_green {
    echo -e "\e[32m$1\e[0m";
}

function echo_yellow {
    echo -e "${YELLOW}$1${RESTORE}";
}

. git_aliases.sh
_create_git_aliases
_copy_git_hooks


PYTHON_VERSION=`cat ./.python-version`
echo_green "Installing python version: ${PYTHON_VERSION}\n"

pyenv install --skip-existing | exit 0

echo_green "Welcome to the dev environment"
echo_green "Hint: autocomplete works for the commands below ;)"
echo_red   "------------------------------------------------------------------------"
devhelp


if test -f "$PROJ_BASE/.cars_env/bin/activate"; then
    source $PROJ_BASE/.cars_env/bin/activate
else
    echo_red "No virtualenv found!"
    echo_green "Run: rebuild_virtualenv"
fi

