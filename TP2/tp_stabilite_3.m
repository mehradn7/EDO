%% TP Stabilité des EDO
A1 = [-1, -4;1 -1];
A2 = [1, -4;1 -1];
A3 = [1, 1;4 -2];

t0 = 0;
tf_12 = 2*pi/sqrt(3);
tf_3 = 1;
N = 100;% nombre de pas pour chaque equadiffn
nb_ci = 10;% nombre de points sur le cercle

% Tracé des cercles des points de départ
th = 0:pi/50:2*pi;
xunit_12 = 0.3 * cos(th) + 0.8;
yunit_12 = 0.3 * sin(th) + 0.8;
xunit_3 = 0.1 * cos(th) + 0.15;
yunit_3 = 0.1 * sin(th) - 0.6;
hold on

xunit = xunit_3;
yunit = yunit_3;
plot(xunit, yunit)

T_12 = linspace(t0, tf_12, N);
T_3 = linspace(t0, tf_3, N);

A = A3;
T = T_3;



mat_y0 = [xunit(1:nb_ci:100); yunit(1:nb_ci:100)];
% Calcul de la solution pour chaque condition initiale
for k=1:size(mat_y0, 2)
    Y = [];
    for t=1:length(T)
        Y = [Y, expm(T(t)*A)*mat_y0(:,k)];
    end
    plot(Y(1,:), Y(2,:), 'b');
end

T_cercles_12 = linspace(t0, tf_12, 10);
T_cercles_3 = linspace(t0, tf_3, 5);

T_cercles = T_cercles_3;

mat_y0_cercles = [xunit(1:100); yunit(1:100)];

for t=1:length(T_cercles)
    Y_cercles = [];
    for k=1:size(mat_y0_cercles, 2)
        Y_cercles = [Y_cercles, [expm(T_cercles(t)*A)*mat_y0_cercles(:,k)]];
    end
    h = fill(Y_cercles(1,:), Y_cercles(2,:), 'g');
    set(h, 'facealpha', 0.5)
end













