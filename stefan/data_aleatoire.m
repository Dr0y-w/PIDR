function [theta_solide,theta_liquide,b] = data_aleatoire(Ny,temperature_fusion,V_solide,V_liquide)

    b = 0.1+0.8*rand(1,1);

    theta_liquide = (V_liquide-temperature_fusion)*linspace(0,1,Ny)+temperature_fusion;
    theta_solide = (temperature_fusion-V_solide)*linspace(0,1,Ny)+V_solide;
    
    eps_solide = [0,1*(-1 + 2*rand(1, Ny-2)),0];
    eps_liquide = [0,1*(-1 + 2*rand(1, Ny-2)),0];

    theta_liquide = theta_liquide + eps_liquide;
    theta_solide = theta_solide + eps_solide;
end