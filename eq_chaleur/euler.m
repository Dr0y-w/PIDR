function [T] = euler()
    Nc = 10; %nb de capteurs 
    Nx = 100; %nb d'intervalles de distance
    N = 300000; %nb d'intervalles de temps
    xc = [0 0.12 0.15 0.27 0.36 0.44 0.63 0.77 0.85 1];%position des capteurs
    chi = 0.23;
    
    % ATTENTION : CONDITION DE STABILITE SCHEMA EULER EXPLICITE : COEFF2 =
    % DT/DX**2 < 1/2
    
    T_init = 298.15; % température initialisée (à la température ambiante) en Kelvin
    v_s = 303.15; % température imposée côté solide en Kelvin
    v_l = 373.15; % température imposée côté liquide en Kelvin

    t_min = 0; % temps de départ
    t_max = 10; % temps de fin
    dt = (t_max - t_min) / N; % intervalle de temps entre chaque point

    L = 1; % longueur du bac en mètre
    dx = L / Nx; % taille d'un échantillon de distance

    T = T_init * ones(N, Nx); % matrice contenant les températures en chaque point
    % en chaque instant dt initialisée 
    
    T(:, 1) = v_s; % on impose les conditions aux bords
    T(:, Nx) = v_l; % on impose les conditions aux bords
    % t = linspace(t_min, t_max, N); % échelle de temps
    x = linspace(0, 1, Nx); % échelle de distance
    
    coeff = (dt * chi) / (dx^2); % coefficient dans le schéma eulérien explicite 

    for i = 2:N 
        T(i, 2:Nx-1) = T(i-1, 2:Nx-1) + coeff * (-2 * T(i-1, 2:Nx-1) + T(i-1, 3:Nx) + T(i-1, 1:Nx-2));
    end

    T_interp = T_init * ones(N, Nc);
    for i = 1:N % l'interpolation doit se faire ligne par ligne
        T_interp(i, :) = interp1(x, T(i, :), xc);
    end
    T = T_interp;
    
    figure(1);
    plot(T(:, 1), 'b-', 'DisplayName', 'x1');
    hold on;
    plot(T(:, 2), 'r--', 'DisplayName', 'x2');
    plot(T(:, 3), 'g-', 'DisplayName', 'x3');
    plot(T(:, 4), 'k:', 'DisplayName', 'x4');
    plot(T(:, 5), 'm-', 'DisplayName', 'x5');
    plot(T(:, 6), 'c--', 'DisplayName', 'x6');
    plot(T(:, 7), 'y-', 'DisplayName', 'x7');
    plot(T(:, 8), 'r:', 'DisplayName', 'x8');
    plot(T(:, 9), 'g-', 'DisplayName', 'x9');
    plot(T(:, 10), 'b--', 'DisplayName', 'x10');
    
    legend('Location', 'east');
    xlabel('temps (en s)');
    ylabel('température (en K)');
    title('Evolution de la température en fonction du temps et de la position');
end