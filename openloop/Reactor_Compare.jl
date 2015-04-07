# Run some simulations

using Reactor

# Add a definition for convert to make our lives easier!
# But be careful now!
function Base.convert(::Type{Float64}, x::Array{Float64, 1})
  return x[1]
end

# Specify the nonlinear model
cstr1 = begin
  V = 5.0 #m3
  R = 8.314 #kJ/kmol.K
  CA0 = 1.0 #kmol/m3
  TA0 = 310.0 #K
  dH = -4.78e4 #kJ/kmol
  k0 = 72.0e7 #1/min
  E = 8.314e4 #kJ/kmol
  Cp = 0.239 #kJ/kgK
  rho = 1000.0 #kg/m3
  F = 100e-3 #m3/min
  Reactor.reactor(V, R, CA0, TA0, dH, k0, E, Cp, rho, F)
end

cstr2 = begin
  V = 2.0; #m3
  R = 8.314; #kJ/kmol.K
  CA0 = 1.0; #kmol/m3
  TA0 = 310.0; #K
  dH = -4.78e4; #kJ/kmol
  k0 = 72.0e7; #1/min
  E = 8.314e4; #kJ/kmol
  Cp = 0.239; #kJ/kgK
  rho = 1000.0; #kg/m3
  F = 100e-3; #m3/min
  Reactor.reactor(V, R, CA0, TA0, dH, k0, E, Cp, rho, F)
end

h = 0.001 # time discretisation
tend = 300. # end simulation time
ts = [0.0:h:tend]
N = length(ts)
xs1 = zeros(2, N)
xs2 = zeros(2, N)

initial_states = [0.5, 400]

us = ones(N)*0.0
xs1[:,1] = initial_states
xs2[:,1] = initial_states
# Loop through the rest of time
for t=2:N
  if ts[t] < 0.5
    xs1[:, t] = Reactor.run_reactor(xs1[:, t-1], us[t-1], h, cstr1) # actual plant
    xs2[:, t] = Reactor.run_reactor(xs2[:, t-1], us[t-1], h, cstr1) # actual plant
  else
    xs1[:, t] = Reactor.run_reactor(xs1[:, t-1], us[t-1], h, cstr1) # actual plant
    xs2[:, t] = Reactor.run_reactor(xs2[:, t-1], us[t-1], h, cstr2) # actual plant
  end
end

rc("font", family="serif", size=24)
skip = 50
# figure(1) #
# x1, = plot(xs1[1,:][:], xs1[2,:][:], "k", linewidth=3)
# x2, = plot(xs2[1,:][:], xs2[2,:][:], "r--", linewidth=3)
# ylabel("Temperature [K]")
# xlabel(L"Concentration [kmol.m$^{-3}$]")

figure(2) # Plot filtered results
subplot(2,1,1)
x1, = plot(ts, xs1[1,:]', "k", linewidth=3)
# x2, = plot(ts, xs2[1,:]', "r--", linewidth=3)
ylabel(L"Concentration [kmol.m$^{-3}$]")
xlim([0, tend])
subplot(2,1,2)
x1, = plot(ts, xs1[2,:]', "k", linewidth=3)
# x2, = plot(ts, xs2[2,:]', "r--", linewidth=3)
ylabel("Temperature [K]")
xlabel("Time [min]")
xlim([0, tend])

# legend([x1, x2], [string("CSTR: ", cstr1.V), string("CSTR: ", cstr2.V)])