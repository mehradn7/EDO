%% Script appelant - TP ordre

t0 = 0;
tf = 6.6632868593231301896996820305;
y0 = [2.00861986087484313650940188; 0];
N = 25;
abscisses_evals = [120:60:1080 1200:600:10800];


[T,Y_euler] = ode_euler(@phi,[t0 tf],y0,N);
[T,Y_runge] = ode_runge(@phi,[t0 tf],y0,N);
[T,Y_heun] = ode_heun(@phi,[t0 tf],y0,N);
[T,Y_rk4_1] = ode_rk4_1(@phi,[t0 tf],y0,N);
[T,Y_rk4_2] = ode_rk4_2(@phi,[t0 tf],y0,N);

[T,Y_gauss_fp,nphi,ifail] = ode_gauss_fp(@phi,[t0 tf],y0,[N 15 1e-12]);


[log_err_euler_x1, log_err_euler_x2] = calcul_erreur(@ode_euler, 1, @phi, [t0 tf],y0);
[log_err_runge_x1, log_err_runge_x2] = calcul_erreur(@ode_runge, 2, @phi, [t0 tf],y0);
[log_err_heun_x1, log_err_heun_x2] = calcul_erreur(@ode_heun, 3, @phi, [t0 tf],y0);
[log_err_rk4_1_x1, log_err_rk4_1_x2] = calcul_erreur(@ode_rk4_1, 4, @phi, [t0 tf],y0);
[log_err_rk4_2_x1, log_err_rk4_2_x2] = calcul_erreur(@ode_rk4_2, 4, @phi, [t0 tf],y0);
[log_err_gauss_fp_x1, log_err_gauss_fp_x2] = calcul_erreur_gauss(@ode_gauss_fp, 4, @phi, [t0 tf],y0, [N, 15, 1e-12]);





figure(1)
subplot(2,2,1)
hold on
plot(T, Y_euler(:,1));
plot(T, Y_runge(:,1));
plot(T, Y_heun(:,1));
plot(T, Y_rk4_1(:,1));
plot(T, Y_rk4_2(:,1));
plot(T, Y_gauss_fp(:,1));
xlabel('t')
ylabel('y_1(t)')

subplot(2,2,2)
hold on
plot(T, Y_euler(:,2));
plot(T, Y_runge(:,2));
plot(T, Y_heun(:,2));
plot(T, Y_rk4_1(:,2));
plot(T, Y_rk4_2(:,2));
plot(T, Y_gauss_fp(:,2));
xlabel('t')
ylabel('y_2(t)')

subplot(2,2,[3,4])
hold on
plot(Y_euler(:,1), Y_euler(:,2));
plot(Y_runge(:,1), Y_runge(:,2));
plot(Y_heun(:,1), Y_heun(:,2));
plot(Y_rk4_1(:,1), Y_rk4_1(:,2));
plot(Y_rk4_2(:,1), Y_rk4_2(:,2));
plot(Y_gauss_fp(:,1), Y_gauss_fp(:,2));
ylabel('y_1(t)')
ylabel('y_2(t)')

legend('Euler', 'Runge', 'Heun', 'RK4_1', 'RK4_2', 'Gauss')


figure(2)
subplot(1,2,1)
hold on

plot(log10(abscisses_evals), log_err_euler_x1)
plot(log10(abscisses_evals), log_err_runge_x1)
plot(log10(abscisses_evals), log_err_heun_x1)
plot(log10(abscisses_evals), log_err_rk4_1_x1)
plot(log10(abscisses_evals), log_err_rk4_2_x1)
plot(log10(abscisses_evals/4), log_err_gauss_fp_x1)


subplot(1,2,2)
hold on

plot(log10(abscisses_evals), log_err_euler_x2)
plot(log10(abscisses_evals), log_err_runge_x2)
plot(log10(abscisses_evals), log_err_heun_x2)
plot(log10(abscisses_evals), log_err_rk4_1_x2)
plot(log10(abscisses_evals), log_err_rk4_2_x2)
plot(log10(abscisses_evals/4), log_err_gauss_fp_x2)

legend('Euler', 'Runge', 'Heun', 'RK4_1', 'RK4_2', 'Gauss')





function [y_point] = phi(t,y)
    y_point = [y(2); (1-y(1)^2)*y(2) - y(1)];
end