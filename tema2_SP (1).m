N = 50; % numarul de coeficienti
D = 1; % durata
P = 40; % perioada
F=1/P; % frecventa 
w0=2*pi/P; % pulsatia
t=0:0.02:P-0.02; % timpul pe care calculam integrala (o perioada); 
                 % rezolutia temporala trebuie sa fie de 2 ori mai mica decat perioada semnalului (teorema esantionarii);
%% semnalul dreptungiular
x = zeros(1,size(t,2)); % initializarea lui x cu zerouri
x(t<=D/2) =1; % de la 0 la D/2 x are valoarea 1
x(t>P-D/2) =1; % de la D/2 la P x are valoarea 1
t_4perioade = 0:0.02:4*P-0.02; % vectorul timp pentru reprezentarea pe 4 perioade
x_4perioade = repmat(x,1,4); % vectorul x pentru reprezentarea pe 4 perioade
   
% integrala numerica prin functia trapz
for k = -N:N
    x_temp = x;
    x_temp = x_temp.*exp(-j*k*w0*t); % vectorul inmultit cu termenul corespunzator
    X(k+51) = trapz(t,x_temp); % trapz calculeaza integrala prin metoda trapezului 
    %(imparte suprafata in forme trapezoidale pentru a calcula mai usor aria)
end

x_refacut(1:length(t)) = 0; % initializarea semnalului reconstruit cu N puncte

%reconstructia lui x(t) folosind N coeficienti
for index = 1:length(t);
for k = -N:N
x_refacut(index) = x_refacut(index) + (1/P)*X(k+N+1)*exp(j*k*w0*t(index));
end
end

figure(1);
plot(t_4perioade,x_4perioade); % afisarea lui x(t)
title('x(t) cu linie solida si reconstructia folosind N=50 coeficienti(linie punctata)');
hold on
x_refacut_4perioade = repmat(x_refacut,1,4); % generarea lui x reconstruit pentru 4 perioade
plot(t_4perioade,x_refacut_4perioade,'--'); % afisarea lui x reconstruit pentru 4 perioade
xlabel('Timp [s]');
ylabel('Amplitudine');

f = -N*F:F:N*F; % generarea vectorului de frecvente
figure(2);
stem(f,abs(X)); % afisarea lui X
title('Spectrul lui x(t)');
xlabel('Frecventa [Hz]');
ylabel('|X|');

%%
% Teoria seriilor Fourier (trigonometrica, armonica si complexa) ne spune
% ca orice semnal periodic poate fi aproximat printr-o suma infinita de sinusi si
% cosinusi de diferite frecvente fiecare ponderat cu un anumit coeficient. Acesti coeficienti
% reprezinta practic spectrul (amplitudinea pentru anumite frecvente).
% Semnalul reconstruit folosind un numar finit de termeni se apropie ca
% forma de semnalul original cu o anumita marja de eroare. Cu cat marim
% numarul de coeficienti, aceasta marja de eroare va fi din ce in ce mai
% mica. In plus se observa faptul ca semnalul poate fi aproximat printr-o
% suma de sinusoide: variatiile semanlului au un caracter de sinusoida.