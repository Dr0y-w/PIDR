function [best_l] = resolution_steffan(Ny,Nt,T,dt,dy,ks,kl,temperature_fusion,Nombre_de_simulation)
    V_solide = randi([0 40],1,1);
    V_liquide = randi([60 100],1,1);

    %initialisation des valeurs témoins
    chaleur_latente_t = 1;
    best_l = 1; % stocke la meilleure chaleur latente
    [theta_solide_t,theta_liquide_t,b0] = data_aleatoire(Ny,temperature_fusion,V_solide,V_liquide);
    b = ones(1,Nt);%vecteur b
    b(1) = b0;


    for t = 2:T
        %schema pour bn+1
        b(t) = b(t-1) + (dt/chaleur_latente_t)*((-kl/(1-b(t-1)))*(theta_liquide_t(1)-theta_liquide_t(1+1))/dy + (ks/(b(t-1)))*(theta_solide_t(Ny)-theta_solide_t(Ny-1))/dy);
        %schema pour theta_liquide et theta_solide
        for i = 2:Ny-1
            theta_solide_t(i) = theta_solide_t(i) + dy*i*(b(t)-b(t-1))/b(t)*(theta_solide_t(i+1)-theta_solide_t(i))/dy + 1/(b(t)*b(t))*(theta_solide_t(i+1)-2*theta_solide_t(i)+theta_solide_t(i-1))/(dy^2);
            theta_liquide_t(i) = theta_liquide_t(i) + -dy*i*(b(t)-b(t-1))/(1-b(t))*(theta_liquide_t(i+1)-theta_liquide_t(i))/dy + 1/((1-b(t))*(1-b(t)))*(theta_liquide_t(i+1)-2*theta_liquide_t(i)+theta_liquide_t(i-1))/(dy^2);
        end
        
    end

    min_sum = inf; % initialise à l'infini pour trouver le minimum plus facilement
    for k=1:Nombre_de_simulation
        chaleur_latente = 1+rand(1,1);
        %initialisation des valeurs
        [theta_solide,theta_liquide,b0] = data_aleatoire(Ny,temperature_fusion,V_solide,V_liquide);
        b = ones(1,Nt);%vecteur b
        b(1) = b0;


        for t = 2:T
            %schema pour bn+1
            b(t) = b(t-1) + (dt/chaleur_latente)*((-kl/(1-b(t-1)))*(theta_liquide(1)-theta_liquide(1+1))/dy + (ks/(b(t-1)))*(theta_solide(Ny)-theta_solide(Ny-1))/dy);
            %schema pour theta_liquide et theta_solide
            for i = 2:Ny-1
                theta_solide(i) = theta_solide(i) + dy*i*(b(t)-b(t-1))/b(t)*(theta_solide(i+1)-theta_solide(i))/dy + 1/(b(t)*b(t))*(theta_solide(i+1)-2*theta_solide(i)+theta_solide(i-1))/(dy^2);
                theta_liquide(i) = theta_liquide(i) + -dy*i*(b(t)-b(t-1))/(1-b(t))*(theta_liquide(i+1)-theta_liquide(i))/dy + 1/((1-b(t))*(1-b(t)))*(theta_liquide(i+1)-2*theta_liquide(i)+theta_liquide(i-1))/(dy^2);
            end
            
        end

        %difference quadratique
        diff = theta_solide_t(:, 2:Ny-1) - theta_solide(:, 2:Ny-1) + theta_liquide_t(:, 2:Ny-1) - theta_liquide(:, 2:Ny-1);
        if diff < min_sum % si on a trouvé une somme minimale
            best_l = chaleur_latente; % retient le meilleur chi
            min_sum = diff; % retient la somme des différences minimales
        end
    end 
    
end
