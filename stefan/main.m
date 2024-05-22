% Détermination de la chaleur latente en résolvant le probleme de steffan
% par des schemas euler explicite



%paramètre physique déterminé dans les autres experiences
ks = 1;%conductivité thermique du solide
kl = 1;%conductivité thermique du liquide
temperature_fusion = 50;%temperature de fusion

%grandeur physique de l'experience
T = 60;%temps de la simulation
Longueur = 1;%longueur de la barre


%initialisation
Nt = 2000; %nb d'intervalles de temps
dt = T/Nt;%intervalle de temps entre chaque point


dy = Longueur/100;%nombre de point de mesure
Ny = Longueur/dy;%taille d'un échantillon d'espace

Nombre_de_simulation = 10;%nombre de simulation pour trouver la chaleur latente
best_l= resolution_stefan(Ny,Nt,T,dt,dy,ks,kl,temperature_fusion,Nombre_de_simulation);%meilleur coefficient de chaleur latente obtenu
