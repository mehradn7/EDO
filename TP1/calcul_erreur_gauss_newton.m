function [ log_err_x1, log_err_x2 ] = calcul_erreur_gauss_newton(methode, nb_appels_phi, handler_phi, handler_dphi, intervalle_tps,y0, option)
t0 = intervalle_tps(1);
tf = intervalle_tps(2);

abscisses_evals = [120:60:1080 1200:600:10800];
log_nfe = log10(abscisses_evals);
log_err_x1 = [];
log_err_x2 = [];


for N=1:length(log_nfe)
   [~,Y] = methode(handler_phi, handler_dphi,[t0 tf],y0, [abscisses_evals(N)/ nb_appels_phi, option(2), option(3)]);
   
   log_err_x1 = [log_err_x1, log10(Y(end,1)-Y(1,1))];
   log_err_x2 = [log_err_x2, log10(Y(end,2)-Y(1,2))];

end

end

