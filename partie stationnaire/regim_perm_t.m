function [kl,ks,cl,cs,b,theta_fusion] = regim_perm_t(theta,Nombre_de_point,L,separation,display_bool)


    x = linspace(0,L,Nombre_de_point); %point de mesure
    %determiner theta_liquide et theta_solide :
    
    % en connaissant la temperature de fusion
    theta_liquide = theta(1:1:separation);
    theta_solide = theta(separation+1:end);
    
    
    
    
    
    
    %calculer kl, ks  et b 
    
    x_liquide = x(1:length(theta_liquide));
    Al = [-1*x_liquide',ones(size(theta_liquide))];
    
    
    x_solide = x(Nombre_de_point-length(theta_solide)+1:end);
    
    As = [x_solide',ones(size(theta_solide))];
    
    %resolution du systeme
    
    res1 = Al\theta_liquide; %(kl,bkl,t_fusion) (pas inversible donc t_fusion jamais obtenu)
    res2 = As\theta_solide; %(ks,bks,t_fusion)
    
    %conditionement des matrices pour avoir de meilleurs resultats
    
    kl = res1(1);   
    ks = res2(1);
    cl = res1(2);
    cs = res2(2);
    b = (cl-cs)/(ks+kl);
    theta_fusion = ks*b+cs;
    
    if (display_bool)
        disp("kl = "+-1*kl+" ks = "+ks+ " b = "+b + " t_fusion = "+theta_fusion);
        
        %affiche une droite de coefficient directeur kl et ks et les points de theta
        %y1 = -x*kl+V_liquide;
        %y2 = (x-L)*ks+V_solide;
        %plot theta
        %plot(x,theta,'ro ',x,y1,'g',x,y2,'b',x,theta_fusion*ones(size(x)),'k -');
        %legend('Temperature','kl','ks','T° de fusion'); xlabel('x'); ylabel('temperature'); title('Temperature en fonction de x');
        %ylim([0 130])
        %grid on;
    
    end
    
    