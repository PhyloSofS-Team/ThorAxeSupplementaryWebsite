Bootstrap: docker
From: julia:latest

%files
    . /genie-app

%post
    cd /genie-app
    chmod +rx bin/server
    chmod +rx bin/repl
    chmod +rx bin/serverinteractive
    chmod +rx bin/runtask
    sed -i 's/log_to_file\s*=\s*true/log_to_file=false/g' config/env/prod.jl

%environment
    export JULIA_DEPOT_PATH="/tmp/genie-app/.julia"
    export GENIE_ENV="prod"

%runscript
    cd /genie-app
    julia --project -e 'using Pkg; Pkg.instantiate()'
    nohup bin/server > /dev/null 2>&1 < /dev/null &
