# Stochastic Dynamical Control [![Build Status](https://travis-ci.org/stelmo/Stochastic-Dynamical-Control-Code.svg?branch=master)](https://travis-ci.org/stelmo/Stochastic-Dynamical-Control-Code)
Code for M. Eng. in Control Engineering

## Required External Julia Packages:

1. Distributions
2. PyPlot
3. NLsolve
4. JuMP
5. Ipopt (including the optimisation library)
6. Mosek (including the optimisation library)
7. KernelDensity

## Running the Code:

**It is necessary to run the script `init_sys.jl` in the root directory to load all the external and internal libraries.**

Please see the folder `openloop_scenarios_*` or `closedloop_scenarios_*` to run simulations/demonstrations. The folders `openloop` and `closedloop` are meant as testing ground before scripts move into the scenario folders. If the readmes in the scenratio folders are cryptic it is because the names of the scripts indicate their function (this is explained in the relevant readmes).

## Testing:

Please execute the script `test_all.jl` to perform the tests manually. This is done automatically with Travis-CI.
