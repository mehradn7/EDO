%% Script appelant - TP ordre

t0 = 0;
tf = 6.6632868593231301896996820305;
y0 = [2.00861986087484313650940188; 0];
N = 25;
abscisses_evals = [120:60:1080 1200:600:10800];

%% Calcul de la solution pour chaque méthode
[T,Y_euler] = ode_euler(@phi,[t0 tf],y0,N);
[T,Y_runge] = ode_runge(@phi,[t0 tf],y0,N);
[T,Y_heun] = ode_heun(@phi,[t0 tf],y0,N);
[T,Y_rk4_1] = ode_rk4_1(@phi,[t0 tf],y0,N);
[T,Y_rk4_2] = ode_rk4_2(@phi,[t0 tf],y0,N);

[T,Y_gauss_fp,nphi_fp,ifail_fp] = ode_gauss_fp(@phi,[t0 tf],y0,[N 15 1e-12]);
[T,Y_gauss_fp_2,~,~] = ode_gauss_fp(@phi,[t0 tf],y0,[N 2 1e-12]);
[T,Y_gauss_fp_3,~,~] = ode_gauss_fp(@phi,[t0 tf],y0,[N 15 1e-6]);

[T,Y_gauss_newton,nphi_newton,ndphi_newton,ifail_newton] = ode_gauss_newton(@phi,@dphi,[t0 tf],y0,[N 15 1e-12]);
[T,Y_gauss_newton_2,~,~,~] = ode_gauss_newton(@phi,@dphi,[t0 tf],y0,[N 2 1e-12]);
[T,Y_gauss_newton_3,~,~,~] = ode_gauss_newton(@phi,@dphi,[t0 tf],y0,[N 15 1e-6]);



%% Calcul des erreurs pour chaque méthode
[log_err_euler_x1, log_err_euler_x2] = calcul_erreur(@ode_euler, 1, @phi, [t0 tf],y0);
[log_err_runge_x1, log_err_runge_x2] = calcul_erreur(@ode_runge, 2, @phi, [t0 tf],y0);
[log_err_heun_x1, log_err_heun_x2] = calcul_erreur(@ode_heun, 3, @phi, [t0 tf],y0);
[log_err_rk4_1_x1, log_err_rk4_1_x2] = calcul_erreur(@ode_rk4_1, 4, @phi, [t0 tf],y0);
[log_err_rk4_2_x1, log_err_rk4_2_x2] = calcul_erreur(@ode_rk4_2, 4, @phi, [t0 tf],y0);

[log_err_gauss_fp_x1, log_err_gauss_fp_x2] = calcul_erreur_gauss_fp(@ode_gauss_fp, 4, @phi, [t0 tf],y0, [N, 15, 1e-12]);
[log_err_gauss_newton_x1, log_err_gauss_newton_x2] = calcul_erreur_gauss_newton(@ode_gauss_newton, 4, @phi, @dphi, [t0 tf],y0, [N, 15, 1e-12]);




%% Affichage de y1(t)
figure(1)
subplot(2,2,1)
hold on
plot(T, Y_euler(:,1));
plot(T, Y_runge(:,1));
plot(T, Y_heun(:,1));
plot(T, Y_rk4_1(:,1));
plot(T, Y_rk4_2(:,1));
plot(T, Y_gauss_fp(:,1));
plot(T, Y_gauss_newton(:,1));

xlabel('t')
ylabel('y_1(t)')

%% Affichage de y2(t)
subplot(2,2,2)
hold on
plot(T, Y_euler(:,2));
plot(T, Y_runge(:,2));
plot(T, Y_heun(:,2));
plot(T, Y_rk4_1(:,2));
plot(T, Y_rk4_2(:,2));
plot(T, Y_gauss_fp(:,2));
plot(T, Y_gauss_newton(:,2));

xlabel('t')
ylabel('y_2(t)')

%% Affichage du plan de phase
subplot(2,2,[3,4])
hold on
plot(Y_euler(:,1), Y_euler(:,2));
plot(Y_runge(:,1), Y_runge(:,2));
plot(Y_heun(:,1), Y_heun(:,2));
plot(Y_rk4_1(:,1), Y_rk4_1(:,2));
plot(Y_rk4_2(:,1), Y_rk4_2(:,2));
plot(Y_gauss_fp(:,1), Y_gauss_fp(:,2));
plot(Y_gauss_newton(:,1), Y_gauss_newton(:,2));

ylabel('y_1(t)')
ylabel('y_2(t)')
xlabel('t')

legend('Euler', 'Runge', 'Heun', 'RK4_1', 'RK4_2', 'Gauss-fp', 'Gauss-newton')

%% Affichage des erreurs sur la 1re composante
figure(2)
subplot(1,2,1)
hold on

plot(log10(abscisses_evals), log_err_euler_x1)
plot(log10(abscisses_evals), log_err_runge_x1)
plot(log10(abscisses_evals), log_err_heun_x1)
plot(log10(abscisses_evals), log_err_rk4_1_x1)
plot(log10(abscisses_evals), log_err_rk4_2_x1)
plot(log10(abscisses_evals/4), log_err_gauss_fp_x1)
plot(log10(abscisses_evals/4), log_err_gauss_newton_x1)

xlabel('$log_{10}(nfe)$', 'Interpreter', 'Latex')
ylabel('$log_{10}(erreur pour x_1)$', 'Interpreter', 'Latex')


%% Affichage des erreurs sur la 2ème composante
subplot(1,2,2)
hold on

plot(log10(abscisses_evals), log_err_euler_x2)
plot(log10(abscisses_evals), log_err_runge_x2)
plot(log10(abscisses_evals), log_err_heun_x2)
plot(log10(abscisses_evals), log_err_rk4_1_x2)
plot(log10(abscisses_evals), log_err_rk4_2_x2)
plot(log10(abscisses_evals/4), log_err_gauss_fp_x2)
plot(log10(abscisses_evals/4), log_err_gauss_newton_x2)

xlabel('$log_{10}(nfe)$', 'Interpreter', 'Latex')
ylabel('$log_{10}(erreur pour x_2)$', 'Interpreter', 'Latex')


legend('Euler', 'Runge', 'Heun', 'RK4_1', 'RK4_2', 'Gauss-fp', 'Gauss-newton')

%% Affichage séparé des solution pour Gauss-point fixe avec différents paramètres
figure('Name', 'Gauss-point fixe')
subplot(2,2,1)
hold on

plot(T, Y_gauss_fp(:,1));
plot(T, Y_gauss_fp_2(:,1));
plot(T, Y_gauss_fp_3(:,1));
xlabel('t')
ylabel('y_1(t)')

subplot(2,2,2)
hold on
plot(T, Y_gauss_fp(:,2));
plot(T, Y_gauss_fp_2(:,2));
plot(T, Y_gauss_fp_3(:,2));
xlabel('t')
ylabel('y_2(t)')

subplot(2,2,[3,4])
hold on
plot(Y_gauss_fp(:,1), Y_gauss_fp(:,2));
plot(Y_gauss_fp_2(:,1), Y_gauss_fp_2(:,2));
plot(Y_gauss_fp_3(:,1), Y_gauss_fp_3(:,2));

ylabel('y_1(t)')
ylabel('y_2(t)')
xlabel('t')

legend('nb-itmax=15, f-eps=1e-12', 'nb-itmax=2, f-eps=1e-12', 'nb-itmax=15, f-eps=1e-6')

%% Affichage séparé des solution pour Gauss-Newton avec différents paramètres
figure('Name', 'Gauss-Newton')
subplot(2,2,1)
hold on

plot(T, Y_gauss_newton(:,1));
plot(T, Y_gauss_newton_2(:,1));
plot(T, Y_gauss_newton_3(:,1));
xlabel('t')
ylabel('y_1(t)')

subplot(2,2,2)
hold on
plot(T, Y_gauss_newton(:,2));
plot(T, Y_gauss_newton_2(:,2));
plot(T, Y_gauss_newton_3(:,2));
xlabel('t')
ylabel('y_2(t)')

subplot(2,2,[3,4])
hold on
plot(Y_gauss_newton(:,1), Y_gauss_newton(:,2));
plot(Y_gauss_newton_2(:,1), Y_gauss_newton_2(:,2));
plot(Y_gauss_newton_3(:,1), Y_gauss_newton_3(:,2));

ylabel('y_1(t)')
ylabel('y_2(t)')
xlabel('t')

legend('nb-itmax=15, f-eps=1e-12', 'nb-itmax=2, f-eps=1e-12', 'nb-itmax=15, f-eps=1e-6')



%% Fonctions phi et sa dérivée de l'équation de Van Der Pol
function [y_point] = phi(t,y)
    y_point = [y(2); (1-y(1)^2)*y(2) - y(1)];
end

function [jac_y] = dphi(t,y)
    jac_y = [0 1; -2*y(1).*y(2)-1 1-y(1).^2];
end