%Stergios Koukouftopoulos 8694
load('sounds.mat');
n = length(d);
num = 500;
%ypologismos tou p kai tou r gia 500 deigmata
a1 = xcorr(u,u,num-1,'unbiased');
a1 = a1(num:(2*num-1));
R = toeplitz(a1);
a2 = xcorr(u,d,num,'unbiased');
P = a2(num:(2*num-1));
%arxikopoihsh kai upologimos tou m
w = -ones(num,1);
e2 = eig(R);
L = max(e2);
m = 2 / ceil(L);
%efarmogh tou steepest descent
wt = zeros([num,n]);%arxikopoihsh
wt(:,1) = w;%wt will record the evolution of w
y = zeros(n, 1);
%arxikopoihsh
A = zeros(num-1,1);
s = [A; u];
for i=num:n
  w = w + m*(P-R*w); % Adaptation equation
  wt(:,i) = w;
  y(i) = s(i:-1:i-499)' * w; % filter
end
%teliko y
y=[y(num:end); A];
%telikos upologismos tou e afou vrhka pleo kai to y
e = d - y;
%akouusma tou kommatiou
clip = audioplayer(e, Fs);
play(clip);
%Stergios Koukouftopoulso 8694