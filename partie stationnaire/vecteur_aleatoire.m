function [theta,b,V_fusion] = vecteur_aleatoire(L, N,V_liquide,V_solide,display_bool)
    % L longueur de la barre
    % N Nombre de points de mesure 
    % V_liquide temperature de chauffe du liquide
    % V_solide temperature de chauffe du solide

    b = (L/10) + (8*L/10)*rand(1) ; % Créer un point au hasard entre 0 et L
    
    x = linspace(0, L, N); % vecteur d'abscisses
    V_fusion = 50; % temperature de fusion
    kl = -((V_liquide-V_fusion)/b);
    ks = ((V_solide-V_fusion)/(L-b));
    %séparation de x entre x inferieur à b et x superieur à b
    x_inf = x(x <= b); % valeurs de x inférieures ou égales à b
    x_sup = x(x > b); % valeurs de x supérieures à b


    if (display_bool)
        disp("Valeur de kl, ks et b definies:");
        disp(['kl = ', num2str(kl), ' ks = ', num2str(ks), ' b = ', num2str(b)]);
    end
    theta_liquide = (x_inf-b)*kl +V_fusion; %temperature dans le liquide
    theta_solide = (x_sup-b)*ks+V_fusion; %temperature dans le solide
    %disp(theta_solide);
    %disp(theta_liquide);
    theta = [theta_liquide,theta_solide];%temperature dans la barre

    %disp(theta);


    theta = (theta);
