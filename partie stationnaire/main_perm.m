% détermmination de kl,ks,theta_fusion, et b en fonction de
% la température de chauffe, de la longueur de la barre et du nombre de point de mesure


V_liquide = 100;%temperature de chauffe du liquide
V_solide = 30; %temperature de chauffe du solide
V_fusion = 50; %temperature de fusion
Nombre_de_point = 10; %nombre de point de mesure
L = 1; %longueur de la barre
N = 10; %nombre de simulation
ecart_type = 0; %ecart type de la loi normale

[theta_r,b,theta_m] = vecteur_aleatoire(L,Nombre_de_point,V_liquide,V_solide,false);
kl_r = -((V_liquide-V_fusion)/b);
ks_r = ((V_solide-V_fusion)/(L-b));

separation_optimale = zeros(1,N);
kl_optimale = zeros(1,N);
ks_optimale = zeros(1,N);
b_optimale = zeros(1,N);
theta_fusion_optimale = zeros(1,N);
for i = 1:N-1
    
    % Ajout de bruit
    eps = [0,ecart_type*(-1 + 2*rand(1, N-2)),0]; % vecteur de bruit
    theta = (theta_r + eps)';
    
    diff = inf;
    x = linspace(0,L,Nombre_de_point);
    for separation = 1:Nombre_de_point
        [kl,ks,cl,cs,~,~] = regim_perm_t(theta,Nombre_de_point,L,separation,false);
        yl = -1*x(1:separation)*kl + cl*ones(1,separation);
        ys = x(separation+1:end)*ks + cs*ones(1,Nombre_de_point-separation);
        
        temp = sum((yl'-theta(1:separation)).^2) + sum((ys'-theta(separation+1:end)).^2);
        if temp < diff
            diff = temp;
            separation_optimale(i) = separation;
        end
    end
    
    
    [kl,ks,cl,cs,b,theta_fusion] = regim_perm_t(theta,Nombre_de_point,L,separation_optimale,false);
    kl_optimale(i) = kl;
    ks_optimale(i) = ks;
    b_optimale(i) = b;
    theta_fusion_optimale(i) = theta_fusion;
end
disp("valeur réel :")
disp("kl : "+kl_r+" | ks : "+ks_r+"| b :"+b+" | theta_fusion : "+theta_m)
disp("moyenne des paramètres :")
disp("kl : "+mean(kl_optimale)+" | ks : "+mean(ks_optimale)+" | b : "+mean(b_optimale)+" | theta_fusion : "+mean(theta_fusion_optimale));
y1 = -x*mean(kl_optimale)+V_liquide;
y2 = (x-L)*mean(ks_optimale)+V_solide;

plot(x,theta_r,'ro ',x,y1,'g',x,y2,'b',x,mean(theta_fusion_optimale)*ones(size(x)),'k -');
legend('Temperature','kl','ks','T° de fusion'); xlabel('x'); ylabel('temperature'); title('Temperature en fonction de x');
ylim([0 130])
grid on;