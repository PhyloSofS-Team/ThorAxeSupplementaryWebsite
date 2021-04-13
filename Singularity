Bootstrap: docker
From: julia:1.6

%files
    . /ThorAxeSuppl

%post
    cd /ThorAxeSuppl
    chmod +rx bin/server
    chmod +rx bin/repl
    chmod +rx bin/serverinteractive
    chmod +rx bin/runtask

%environment
    export JULIA_DEPOT_PATH="/ThorAxeSuppl/.julia"
    export GENIE_ENV="prod"

%runscript
    cd /ThorAxeSuppl
    julia --project -e 'using Pkg; Pkg.instantiate()'
    nohup bin/server &
