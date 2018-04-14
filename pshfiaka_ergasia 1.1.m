%Stergios Koukouftopoulos 8694
N = 1000; 
n = 1:N;
%arxika dhmiourgw to x(n)
for n=1:N
x(n) = cos(pi*n)*sin((pi/25)*n + pi/3);
end
%akomh dhmiourgw to v kai to d
v = sqrt(0.19)*randn(1,N); 
v = v - mean(v);
d = v + x;
%epeita dhmiourgw to u
u = zeros(1,N);
u(1) = v(1);
for n = 2:N
    u(n) = -0.78*u(n-1) + v(n); 
end

%dhmioyrgw to R kai to P gia to prwto erwthma
a = xcorr(u,u,1,'unbiased');
R = toeplitz(a(2:3))
P = [0.19; 0 ]
%upologizw to w me vash thn wiener-hopf
wo = R\P 
%psaxnw to y prokeimenou na upologisw to error sth sunexeia
A = [ u' [ 0; u(1:N-1)'] ];
yo = A*wo; 
e = d' - yo;
% 2o Erwthma------------------------------------------
%Ypologizw to pedio timwn tou ì

e1 = eig(R);
L3 = max(e1);

%efarmogh steepest descent 3o erwthma
w = [-1; -1];
m=1.5
wt = zeros([2,N]);%wt will record the evolution of vector w
wt(:,1) = w;%arxikopoihsh
y = zeros(N,1);

for i=2:N
  w = w + m*(P-R*w); % Adaptation equation
  wt(:,i) = w;%wt records the evolution of w
  y(i) = A(i:-1:i-2+1) * w; % filter
end

%efarmogh tou krithriou Jw
K = 80;
ww = linspace(-10,10,K);
J = zeros([K,K]);
s = 0.1;
for i=1:K
  for k=1:K
    wp = [ww(i); ww(k)];
    J(k,i) = s - 2*P'*wp + wp'*R*wp;%ypologismos tou Jw
  end
end
Jmin = min(J(:));
Jmax = max(J(:));
difference = linspace(Jmin,Jmax,30);
%ektupwnw to diagramma-----------------------------------------------------
figure(1)
contour(ww, ww, J, difference); axis square
hold on
plot(wt(1,:), wt(2,:), 'xr--');
hold off
xlabel('w(1)');
ylabel('w(2)');
title('Diagram for Jw');
%Stergios Koukouftopoulos 8694