function [T,Y,nphi,ndphi,ifail] = ode_gauss_newton(handler_phi,handler_dphi,intervalle_tps,y0,option)
n = size(y0, 1);
N = option(1);
nb_itmax = option(2);
f_eps = option(3);
t0 = intervalle_tps(1);
tf = intervalle_tps(2);
h = (tf - t0)/N;
Y = [];
T = [];
Y = zeros(N+1, n);
T = zeros(N+1,1);
Y(1,:) = y0;
T(1) = intervalle_tps(1);
nphi = 0;
ndphi = 0;
ifail = [];
for i=2:N+1
    X = [handler_phi(t0 + (1/2 - sqrt(3)/6)*h, Y(i-1, :)); handler_phi(t0 + (1/2 + sqrt(3)/6)*h, Y(i-1, :))];
    nphi = nphi + 2;
    X_prec = X + 1;
    k = 0;
    while (norm(X - X_prec) > f_eps) && (k < nb_itmax)
        X_prec = X;
        F1 = handler_phi(t0 + (1/2 - sqrt(3)/6)*h, Y(i-1,:) + h*((1/4)*[X(1), X(2)] + ...
        + (1/4 - sqrt(3)/6) * [X(3), X(4)]));
        F2 = handler_phi(t0 + (1/2 + sqrt(3)/6)*h, Y(i-1,:) + h*((1/4 +sqrt(3)/6)*[X(1), X(2)] + ...
        + (1/4) * [X(3), X(4)]));
        % Calcul de X - F(X)
        G = X_prec - [F1; F2];
        % Calcul de la jacobienne
        dphi1 = handler_dphi(t0 + (1/2+sqrt(3)/6)*h, Y(i-1,:) + h*((1/4)*[X(1), X(2)] + ...
        + (1/4 - sqrt(3)/6) * [X(3), X(4)]));
        dphi2 = handler_dphi(t0 + (1/2-sqrt(3)/6)*h, Y(i-1,:) + h*((1/4 +sqrt(3)/6)*[X(1), X(2)] + ...
        + (1/4) * [X(3), X(4)]));
    
        J_F = eye(4) - [(1/4)*dphi1 , (1/4 - sqrt(3)/6)*dphi1 ; (1/4 +sqrt(3)/6)*dphi2, (1/4)*dphi2];
        X = X + (J_F\(-G));
        
        nphi = nphi + 2;
        ndphi = ndphi + 2;
        k = k+1;
    end
    if (norm(X - X_prec) > f_eps) 
        ifail = [ifail -1];
    else
        ifail = [ifail k];
    end
    
    k1 = [X(1), X(2)];
    k2 = [X(3), X(4)];
    
    Y(i,:) = Y(i-1, :) + (1/2)*h*k1 + (1/2)*h*k2;
    T(i) = T(i-1) + h;

end

end

