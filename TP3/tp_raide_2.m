%% Script appelant - TP raide

t0 = 0;
tf = 1.5;
y0_2 = 0;

N = floor(50*tf/1.974);


%% Calcul de la solution pour chaque méthode, pour chaque valeur de N
[T_1,Y_euler_1] = ode_euler(@phi_2,[t0 tf],y0_2,N);
[T_1,Y_runge_1] = ode_runge(@phi_2,[t0 tf],y0_2,N);
[T_1,Y_heun_1] = ode_heun(@phi_2,[t0 tf],y0_2,N);
[T_1,Y_rk4_1_1] = ode_rk4_1(@phi_2,[t0 tf],y0_2,N);
[T_1,Y_rk4_2_1] = ode_rk4_2(@phi_2,[t0 tf],y0_2,N);
[T_1,Y_gauss_fp_1,~,~] = ode_gauss_fp(@phi_2,[t0 tf],y0_2,[N 40 1e-6]);

N = floor(50*tf/1.875);

[T_2,Y_euler_2] = ode_euler(@phi_2,[t0 tf],y0_2,N);
[T_2,Y_runge_2] = ode_runge(@phi_2,[t0 tf],y0_2,N);
[T_2,Y_heun_2] = ode_heun(@phi_2,[t0 tf],y0_2,N);
[T_2,Y_rk4_1_2] = ode_rk4_1(@phi_2,[t0 tf],y0_2,N);
[T_2,Y_rk4_2_2] = ode_rk4_2(@phi_2,[t0 tf],y0_2,N);
[T_2,Y_gauss_fp_2,~,~] = ode_gauss_fp(@phi_2,[t0 tf],y0_2,[N 40 1e-6]);

N = 50;

[T_3,Y_euler_3] = ode_euler(@phi_2,[t0 tf],y0_2,N);
[T_3,Y_runge_3] = ode_runge(@phi_2,[t0 tf],y0_2,N);
[T_3,Y_heun_3] = ode_heun(@phi_2,[t0 tf],y0_2,N);
[T_3,Y_rk4_1_3] = ode_rk4_1(@phi_2,[t0 tf],y0_2,N);
[T_3,Y_rk4_2_3] = ode_rk4_2(@phi_2,[t0 tf],y0_2,N);
[T_3,Y_gauss_fp_3,~,~] = ode_gauss_fp(@phi_2,[t0 tf],y0_2,[N 40 1e-6]);

N = 100;

[T_4,Y_euler_4] = ode_euler(@phi_2,[t0 tf],y0_2,N);
[T_4,Y_runge_4] = ode_runge(@phi_2,[t0 tf],y0_2,N);
[T_4,Y_heun_4] = ode_heun(@phi_2,[t0 tf],y0_2,N);
[T_4,Y_rk4_1_4] = ode_rk4_1(@phi_2,[t0 tf],y0_2,N);
[T_4,Y_rk4_2_4] = ode_rk4_2(@phi_2,[t0 tf],y0_2,N);
[T_4,Y_gauss_fp_4,~,~] = ode_gauss_fp(@phi_2,[t0 tf],y0_2,[N 40 1e-6]);


%% Affichage de y(t) pour chaque valeur de N
figure(1)
subplot(2,2,1)
hold on
plot(T_1, Y_euler_1(:,1));
plot(T_1, Y_runge_1(:,1));
plot(T_1, Y_heun_1(:,1));
plot(T_1, Y_rk4_1_1(:,1));
plot(T_1, Y_rk4_2_1(:,1));
plot(T_1, Y_gauss_fp_1(:,1));

xlabel('t')
ylabel('y(t)')

subplot(2,2,2)
hold on
plot(T_2, Y_euler_2(:,1));
plot(T_2, Y_runge_2(:,1));
plot(T_2, Y_heun_2(:,1));
plot(T_2, Y_rk4_1_2(:,1));
plot(T_2, Y_rk4_2_2(:,1));
plot(T_2, Y_gauss_fp_2(:,1));

xlabel('t')
ylabel('y(t)')

subplot(2,2,3)
hold on
plot(T_3, Y_euler_3(:,1));
plot(T_3, Y_runge_3(:,1));
plot(T_3, Y_heun_3(:,1));
plot(T_3, Y_rk4_1_3(:,1));
plot(T_3, Y_rk4_2_3(:,1));
plot(T_3, Y_gauss_fp_3(:,1));

xlabel('t')
ylabel('y(t)')

subplot(2,2,4)
hold on
plot(T_4, Y_euler_4(:,1));
plot(T_4, Y_runge_4(:,1));
plot(T_4, Y_heun_4(:,1));
plot(T_4, Y_rk4_1_4(:,1));
plot(T_4, Y_rk4_2_4(:,1));
plot(T_4, Y_gauss_fp_4(:,1));

xlabel('t')
ylabel('y(t)')

legend('Euler', 'Runge', 'Heun', 'RK4_1', 'RK4_2', 'Gauss-fp')



%% Fonctions phi et sa dérivée de l'équation de Van Der Pol
function [y_point] = phi_2(t,y)
    y_point = -50*(y - cos(t));
end

function [jac_y] = dphi_2(t,y)
    jac_y = -50;
end