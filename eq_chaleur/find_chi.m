function [best_chi, min_sum] = find_chi()
    chi_temoin = 0.23; % valeur avant bruitage
    T_temoin = euler(chi_temoin); 
    best_chi = 0; % stocke le meilleur chi
    min_sum = inf; % initialise à l'infini pour trouver le minimum plus facilement
    Nc = 10; % nb de capteurs

    for n = 0:3 % nb d'itérations du schéma
        r = (rand(1)/2.5)-0.2; % valeur random entre -0.2 et 0.2
        chi_exp = chi_temoin + r; % bruitage
        T_exp = euler(chi_exp); % température pour le chi bruité

        % Calcul de la somme des différences quadratiques
        diff = T_temoin(:, 2:Nc-1) - T_exp(:, 2:Nc-1);
        sum_diff = sum(diff(:).^2); % somme des carrés des différences

        if sum_diff < min_sum % si on a trouvé une somme minimale
            best_chi = chi_exp; % retient le meilleur chi
            min_sum = sum_diff; % retient la somme des différences minimales
        end
    end
end