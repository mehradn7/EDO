function [T,Y] = ode_rk4_1(handler_phi,intervalle_tps,y0,N)
n = size(y0, 1);
h = (intervalle_tps(2) - intervalle_tps(1))/N;
Y = [];
T = [];
Y = zeros(N+1, n);
T = zeros(N+1,1);
Y(1,:) = y0;
T(1) = intervalle_tps(1);
for i=2:N+1
    k1 = handler_phi(T(i-1),Y(i-1, :))';
    k2 = handler_phi(T(i-1),Y(i-1, :) + (1/2)*h*k1)';
    k3 = handler_phi(T(i-1),Y(i-1, :) + (1/2)*h*k2)';
    k4 = handler_phi(T(i-1),Y(i-1, :) + (1)*h*k3)';


    T(i) = T(i-1) + h;
    Y(i,:) = Y(i-1, :) + h*((1/6)*k1 + (2/6)*k2 + ...
        (2/6)*k3 + (1/6)*k4);
    
end

end
