function [T,Y] = ode_euler(handler_phi,intervalle_tps,y0,N)
n = size(y0, 1);
h = (intervalle_tps(2) - intervalle_tps(1))/N;
Y = [];
T = [];
Y = zeros(N+1, n);
T = zeros(N+1,1);
Y(1,:) = y0;
T(1) = intervalle_tps(1);
for i=2:N+1
    T(i) = T(i-1) + h;
    Y(i,:) = Y(i-1, :) + h*handler_phi(T(i-1),Y(i-1, :))';
    
end

end
