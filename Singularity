Bootstrap: docker
From: julia:latest

%files
    . /app

%post
    cd /app
    chmod +x bin/repl
    chmod +x bin/server
    chmod +x bin/serverinteractive
    chmod +x bin/runtask
    sed -i 's/log_to_file\s*=\s*true/log_to_file=false/g' config/env/prod.jl
    export JULIA_DEPOT_PATH="/tmp/.julia"
    julia --project -e 'using Pkg; Pkg.instantiate()'
    julia --project -e 'using Pkg; Pkg.precompile()'
    chmod -R a+wrx /tmp/.julia

%environment
    export JULIA_DEPOT_PATH="/tmp/.julia"
    export GENIE_ENV="prod"

%runscript
    cd /app
    bin/server
