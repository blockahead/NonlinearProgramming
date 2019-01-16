close all;
clc;
clear;

x_min = -10;
x_max = 10;
y_min = -10;
y_max = 10;
z_min = -10;
z_max = 200;


x_vec = linspace( x_min, x_max, 31 )';
y_vec = linspace( y_min, y_max, 31 )';

X = zeros( length( x_vec ), length( y_vec ) );
Y = zeros( length( x_vec ), length( y_vec ) );
Z = zeros( length( x_vec ), length( y_vec ) );

%% 評価函数
for cnt_x = 1:length( x_vec )
    for cnt_y = 1:length( y_vec )
        X(cnt_x,cnt_y) = x_vec(cnt_x);
        Y(cnt_x,cnt_y) = y_vec(cnt_y);
        Z(cnt_x,cnt_y) = calcFunction( [ x_vec(cnt_x), y_vec(cnt_y) ]' );
    end
end

%% 探索
% 初期推定解
x0 = [ -8, 8 ]';

% 収束判定パラメータ
c = 0.01;

% 刻み幅
h = 0.03;

% 解析解
x_opt_Analytic = [ ( 2 / 7 ), ( 13 / 7 ) ]';

% 最急降下法
[ x_opt_SDM, x_history_SDM ] = SteepestDescentMethod( x0, c, h );
z_history_SDM = zeros( size( x_history_SDM(:,1) ) );
for cnt = 1:length( z_history_SDM )
    z_history_SDM(cnt) = calcFunction( x_history_SDM(cnt,:) );
end

% 共軛勾配法
[ x_opt_CGM, x_history_CGM ] = ConjugateGradientMethod( x0, c, h );
z_history_CGM = zeros( size( x_history_CGM(:,1) ) );
for cnt = 1:length( z_history_CGM )
    z_history_CGM(cnt) = calcFunction( x_history_CGM(cnt,:) );
end

% Newton法
[ x_opt_Newton, x_history_Newton] = NewtonMethod( x0, c, h );
z_history_Newton = zeros( size( x_history_Newton(:,1) ) );
for cnt = 1:length( z_history_Newton)
    z_history_Newton(cnt) = calcFunction( x_history_Newton(cnt,:) );
end

% 準Newton法（BFGS）
[ x_opt_QNewton_BFGS, x_history_QNewton_BFGS] = QuasiNewtonMethod( x0, c, h, 'BFGS' );
z_history_QNewton_BFGS = zeros( size( x_history_QNewton_BFGS(:,1) ) );
for cnt = 1:length( z_history_QNewton_BFGS)
    z_history_QNewton_BFGS(cnt) = calcFunction( x_history_QNewton_BFGS(cnt,:) );
end

% 準Newton法（DFP）
[ x_opt_QNewton_DFP, x_history_QNewton_DFP] = QuasiNewtonMethod( x0, c, h, 'DFP' );
z_history_QNewton_DFP = zeros( size( x_history_QNewton_DFP(:,1) ) );
for cnt = 1:length( z_history_QNewton_DFP)
    z_history_QNewton_DFP(cnt) = calcFunction( x_history_QNewton_DFP(cnt,:) );
end


%% Plotting
figure( 'Name', 'Mesh', 'Position', [ 3000, 10, 600, 1000 ] );

%% 上段
subplot( 2, 1, 1 ); hold on;
Z_buff = Z;
% Z_buff( Z_buff > z_max ) = z_max;

% 元の函数
contour3( X, Y, Z_buff, 100 );

% 解析解
scatter3( x_opt_Analytic(1), x_opt_Analytic(2), calcFunction(x_opt_Analytic), 50, 'MarkerEdgeColor', [ 0, 0, 0 ], 'MarkerFaceColor', [ 1, 0, 0 ] );

% 最急降下法
plot3_SDM = plot3( x_history_SDM(:,1), x_history_SDM(:,2), z_history_SDM(:,1), 'Color', [ 1, 0, 0 ], 'LineWidth', 1 );

% 共軛勾配法
plot3_CGM = plot3( x_history_CGM(:,1), x_history_CGM(:,2), z_history_CGM(:,1), 'Color', [ 0, 0, 1 ], 'LineWidth', 1 );

% Newton法
plot3_Newton = plot3( x_history_Newton(:,1), x_history_Newton(:,2), z_history_Newton(:,1), 'Color', [ 0, 0.75, 0 ], 'LineWidth', 1 );

% 準Newton法（BFGS）
plot3_QNewton_BFGS = plot3( x_history_QNewton_BFGS(:,1), x_history_QNewton_BFGS(:,2), z_history_QNewton_BFGS(:,1), 'Color', [ 1, 0.5, 0 ], 'LineWidth', 1 );

% 準Newton法（BFGS）
plot3_QNewton_DFP = plot3( x_history_QNewton_DFP(:,1), x_history_QNewton_DFP(:,2), z_history_QNewton_DFP(:,1), 'Color', [ 1, 0, 0.5 ], 'LineWidth', 1 );

% 各種設定
colormap( jet(100) );
view( [ -5, 50 ] );
legend( ...
    [ plot3_SDM, plot3_CGM, plot3_Newton, plot3_QNewton_BFGS, plot3_QNewton_DFP ], ...
    '最急降下法', '共軛勾配法', 'Newton法', '準Newton法（BFGS）', '準Newton法（DFP）', 'Location', 'NorthEast' ...
    );

%% 下段
subplot( 2, 1, 2 ); hold on;

% 元の函数
contour( X, Y, Z, 100 );

% 解析解
scatter( x_opt_Analytic(1), x_opt_Analytic(2), 50, 'MarkerEdgeColor', [ 0, 0, 0 ], 'MarkerFaceColor', [ 1, 0, 0 ] );

% 最急降下法
plot_SDM = plot( x_history_SDM(:,1), x_history_SDM(:,2), '-o', 'Color', [ 1, 0, 0 ], 'LineWidth', 0.5, 'MarkerSize', 3 );

% 共軛勾配法
plot_CGM = plot( x_history_CGM(:,1), x_history_CGM(:,2), '-o', 'Color', [ 0, 0, 1 ], 'LineWidth', 0.5, 'MarkerSize', 3 );

% Newton法
plot_Newton = plot( x_history_Newton(:,1), x_history_Newton(:,2), '-o', 'Color', [ 0, 0.75, 0 ], 'LineWidth', 0.5, 'MarkerSize', 3 );

% 準Newton法（BFGS）
plot_QNewton_BFGS = plot( x_history_QNewton_BFGS(:,1), x_history_QNewton_BFGS(:,2), '-o', 'Color', [ 1, 0.5, 0 ], 'LineWidth', 0.5, 'MarkerSize', 3 );

% 準Newton法（DFP）
plot_QNewton_DFP = plot( x_history_QNewton_DFP(:,1), x_history_QNewton_DFP(:,2), '-o', 'Color', [ 1, 0, 0.5 ], 'LineWidth', 0.5, 'MarkerSize', 3 );

% 各種設定
xlim( [ x_min, x_max ] );
ylim( [ y_min, y_max ] );
legend( ...
    [ plot_SDM, plot_CGM, plot_Newton, plot_QNewton_BFGS, plot_QNewton_DFP ], ...
    '最急降下法', '共軛勾配法', 'Newton法', '準Newton法（BFGS）', '準Newton法（DFP）', 'Location', 'NorthEast' ...
    );

clearvars -except x0 *history* *opt*