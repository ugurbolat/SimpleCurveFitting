clear all
close all
clc

%% Parabola for nice curve and local minimum

par =  @(x1,x2) (x1-1).^2 + (x2-1).^2 - 2;

x1 = -4:0.5:5;
x2 = -4:0.5:5;

[X1,X2] = meshgrid(x1,x2);

par_ = par(X1,X2);

f1 = figure
surfc(x1, x2, par_)
hold on
colormap(f1, 'summer')
alpha 0.7
[~,i] = min(par_(:));
h = scatter3(1,1,par_(i),'filled', 'r');
h.SizeData = 350;
title('A Quadratic Function')
zlabel('F(x)')
xlabel('x1')
ylabel('x2')

%% Curve Fitting
f_org = @(x) 2*x+1;
in = 0:0.5:10;
out = f_org(in);
noisy_out = out + 2 * rand(1,length(out));

f = @(x,a) x(1)*a + x(2);

x0 = [4; 4];

options = optimoptions('lsqcurvefit','Algorithm','Levenberg-Marquardt','Diagnostics','on','Display','iter-detailed');
[xstar,resnorm,residual,exitflag,output,lambda,jacobian] = lsqcurvefit(f,x0,in,noisy_out,[],[],options);


figure
plot(in, noisy_out,'b*');
title('Least Squares Measurement Dataset')
xlabel('a')
ylabel('S')

figure
plot(in, noisy_out,'b*');
hold on

temp_in = 0:0.1:11;
temp_out = f(xstar, temp_in);
plot(temp_in, temp_out,'r-');
title('Least Squares Curve Fitting Operation')
xlabel('a')
ylabel('S')

% g = @(x1,x2) sum(((x1*v.^2 + x2*v) * 1000 - d).^2);
g = @(x1,x2) function_model_for_surfc(x1,x2, in, noisy_out);

x1 = -2:0.5:6;
x2 = -2:0.5:6;

[X1,X2] = meshgrid(x1,x2);

g_ = g(X1,X2);

f2 = figure
surfc(x1, x2, g_)
hold on
colormap(f2, 'summer')
alpha 0.7
[~,i] = min(par_(:));
title('The Objective Function')
zlabel('F(x)')
xlabel('x1')
ylabel('x2')
h = scatter3(xstar(1),xstar(2),g(xstar(1), xstar(2)),'filled', 'r');
h.SizeData = 350;
q = scatter3(x0(1),x0(2),g(x0(1), x0(2)),'filled', 'b');
q.SizeData = 350;
x = linspace(xstar(1),x0(1));
y = linspace(xstar(2),x0(2));
for i=1:length(x)
    z(i) = g(x(i),y(i));
end
plot3(x, y, z, 'LineWidth',1, 'Color','k')


% contour3(x1, x2, g_, [0:10:5000], 'LineWidth',1, 'Color','k')