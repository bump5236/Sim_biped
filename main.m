clear       % ワークスペースを初期化
close all   % すべてのウィンドウを閉じる


% デフォルト描画設定
set(0,'defaultAxesFontSize',16);
set(0,'defaultAxesFontName', 'Times new roman');
set(0,'defaultTextFontSize',16);
set(0,'defaultTextFontName', 'Times new roman');

% add dependent folders
addpath(pwd,'class')


%% Simulation
model = robot;

syms t
model.x_func(t);
model.z_func(t);
t_range = [model.t0, model.t1];
model.cal_J(pi/3, pi/3)
model.vel2dq;

%% 描画
figure;
fplot(model.vx, t_range, 'LineWidth', 1)
xlabel('$$t [s]$$','interpreter','latex')
ylabel('$$vx [m/s]$$','interpreter','latex')

figure;
subplot(3,1,1);
fplot(model.vz, t_range, 'LineWidth', 1)
xlabel('$$t [s]$$','interpreter','latex')
ylabel('$$vz [m/s]$$','interpreter','latex')

subplot(3,1,2);
fplot(model.az, t_range, 'LineWidth', 1)
xlabel('$$t [s]$$','interpreter','latex')
ylabel('$$az [m/s^2]$$','interpreter','latex')

subplot(3,1,3);
fplot(model.jz, t_range, 'LineWidth', 1)
xlabel('$$t [s]$$','interpreter','latex')
ylabel('$$jz [m/s^3]$$','interpreter','latex')

figure;
subplot(2,1,1);
fplot(model.dq1, t_range, 'LineWidth', 1)
xlabel('$$t [s]$$','interpreter','latex')
ylabel('$$dq1 [rad/s]$$','interpreter','latex')

subplot(2,1,2);
fplot(model.dq2, t_range, 'LineWidth', 1)
xlabel('$$t [s]$$','interpreter','latex')
ylabel('$$dq2 [rad/s]$$','interpreter','latex')


