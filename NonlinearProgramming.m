close all;
clc;
clear;

%% ΕK»ΞΫΜi§ρΘ΅j
% QP
QP_A = [ 4, 1;1, 2 ];
if( det( QP_A ) <= 0 )
    error( 'QP_AΝΚΦΕΝΘ’' );
end
QP_b = [ -3;-4 ];

calcFunction = @QP_Function; % ΕK»ΞΫΜ
calcGradient = @QP_Gradient; % Μωz
calcHessian = @QP_Hessian; % ΜHessesρ
x_opt_Analytic = -( QP_A \ QP_b ); % πΝπ

% `ζΝΝ
x_min = -10;
x_max = 10;
y_min = -10;
y_max = 10;

% ϊθπ
x0 = [ -8, 8 ]';

% ΌόTυΜϋ©»θp[^
c = 0.01;
% έ
h = 0.5;


% % 4thOrder
% calcFunction = @cross_Function; % ΕK»ΞΫΜ
% calcGradient = @cross_Gradient; % Μωz
% calcHessian = @cross_Hessian; % ΜHessesρ
% x_opt_Analytic = [ 0, 0 ]'; % πΝπ
% 
% % `ζΝΝ
% x_min = -10;
% x_max = 10;
% y_min = -10;
% y_max = 10;
% 
% % ϊθπ
% x0 = [ -8, 5 ]';
% 
% % ΌόTυΜϋ©»θp[^
% c = 0.01;
% % έ
% h = 0.5;

% % cos
% calcFunction = @cos_Function; % ΕK»ΞΫΜ
% calcGradient = @cos_Gradient; % Μωz
% calcHessian = @cos_Hessian; % ΜHessesρ
% x_opt_Analytic = [ ( 0 ), ( 0 ) ]'; % πΝπ
% 
% % `ζΝΝ
% x_min = -0.5;
% x_max = 0.5;
% y_min = -0.25;
% y_max = 0.25;
% 
% % ϊθπ
% x0 = [ -0.4, 0.2 ]';
% 
% % ΌόTυΜϋ©»θp[^
% c = 0.01;
% % έ
% h = 0.03;

% % Rosenbrock
% calcFunction = @Rosenbrock_Function; % ΕK»ΞΫΜ
% calcGradient = @Rosenbrock_Gradient; % Μωz
% calcHessian = @Rosenbrock_Hessian; % ΜHessesρ
% x_opt_Analytic = [ ( 1 ), ( 1 ) ]'; % πΝπ
% 
% x_min = -1.5;
% x_max = 1.5;
% y_min = -1;
% y_max = 3;
% 
% % ϊθπ
% x0 = [ 0.1, 2.5 ]';
% 
% % ΌόTυΜϋ©»θp[^
% c = 0.01;
% % έ
% h = 0.5;

%% ]ΏΜ`ζp
% ]ΏΜvZΝΝ
x_vec = linspace( x_min, x_max, 31 )';
y_vec = linspace( y_min, y_max, 31 )';

X = zeros( length( x_vec ), length( y_vec ) );
Y = zeros( length( x_vec ), length( y_vec ) );
Z = zeros( length( x_vec ), length( y_vec ) );

% ]ΏΜvZ
for cnt_x = 1:length( x_vec )
    for cnt_y = 1:length( y_vec )
        X(cnt_x,cnt_y) = x_vec(cnt_x);
        Y(cnt_x,cnt_y) = y_vec(cnt_y);
        Z(cnt_x,cnt_y) = calcFunction( [ x_vec(cnt_x), y_vec(cnt_y) ]' );
    end
end
z_min = min( min( Z, [], 1 ) );
z_max = max( max( Z, [], 1 ) );

%% Tυ
% Ε}~Ί@
[ x_opt_SDM, x_history_SDM ] = SteepestDescentMethod( x0, c, h, calcFunction, calcGradient );
z_history_SDM = zeros( size( x_history_SDM(:,1) ) );
for cnt = 1:length( z_history_SDM )
    z_history_SDM(cnt) = calcFunction( x_history_SDM(cnt,:)' );
end

% €ηbωz@
[ x_opt_CGM, x_history_CGM ] = ConjugateGradientMethod( x0, c, h, calcFunction, calcGradient );
z_history_CGM = zeros( size( x_history_CGM(:,1) ) );
for cnt = 1:length( z_history_CGM )
    z_history_CGM(cnt) = calcFunction( x_history_CGM(cnt,:)' );
end

% Newton@
[ x_opt_Newton, x_history_Newton] = NewtonMethod( x0, c, calcGradient, calcHessian );
z_history_Newton = zeros( size( x_history_Newton(:,1) ) );
for cnt = 1:length( z_history_Newton)
    z_history_Newton(cnt) = calcFunction( x_history_Newton(cnt,:)' );
end

% Newton@iBFGSj
[ x_opt_QNewton_BFGS, x_history_QNewton_BFGS] = QuasiNewtonMethod( x0, c, h, calcFunction, calcGradient, 'BFGS' );
z_history_QNewton_BFGS = zeros( size( x_history_QNewton_BFGS(:,1) ) );
for cnt = 1:length( z_history_QNewton_BFGS)
    z_history_QNewton_BFGS(cnt) = calcFunction( x_history_QNewton_BFGS(cnt,:)' );
end

% Newton@iDFPj
[ x_opt_QNewton_DFP, x_history_QNewton_DFP] = QuasiNewtonMethod( x0, c, h, calcFunction, calcGradient, 'DFP' );
z_history_QNewton_DFP = zeros( size( x_history_QNewton_DFP(:,1) ) );
for cnt = 1:length( z_history_QNewton_DFP)
    z_history_QNewton_DFP(cnt) = calcFunction( x_history_QNewton_DFP(cnt,:)' );
end


%% Plotting
figure( 'Name', 'Mesh', 'Position', [1300 50 600 900] );

%% γi
subplot( 2, 1, 1 ); hold on;
Z_buff = Z;
% Z_buff( Z_buff > z_max ) = z_max;

% ³Μ
contour3( X, Y, Z_buff, 100 );

% πΝπ
scatter3( x_opt_Analytic(1), x_opt_Analytic(2), calcFunction(x_opt_Analytic), 50, 'MarkerEdgeColor', [ 0, 0, 0 ], 'MarkerFaceColor', [ 1, 0, 0 ] );

% Ε}~Ί@
plot3_SDM = plot3( x_history_SDM(:,1), x_history_SDM(:,2), z_history_SDM(:,1), 'Color', [ 1, 0, 0 ], 'LineWidth', 1 );

% €ηbωz@
plot3_CGM = plot3( x_history_CGM(:,1), x_history_CGM(:,2), z_history_CGM(:,1), 'Color', [ 0, 0, 1 ], 'LineWidth', 1 );

% Newton@
plot3_Newton = plot3( x_history_Newton(:,1), x_history_Newton(:,2), z_history_Newton(:,1), 'Color', [ 0, 0.75, 0 ], 'LineWidth', 1 );

% Newton@iBFGSj
plot3_QNewton_BFGS = plot3( x_history_QNewton_BFGS(:,1), x_history_QNewton_BFGS(:,2), z_history_QNewton_BFGS(:,1), 'Color', [ 1, 0.5, 0 ], 'LineWidth', 1 );

% Newton@iBFGSj
plot3_QNewton_DFP = plot3( x_history_QNewton_DFP(:,1), x_history_QNewton_DFP(:,2), z_history_QNewton_DFP(:,1), 'Color', [ 1, 0, 0.5 ], 'LineWidth', 1 );

% eνέθ
colormap( jet(100) );
view( [ -5, 50 ] );
xlim( [ x_min, x_max ] );
ylim( [ y_min, y_max ] );
zlim( [ z_min, z_max ] );
legend( ...
    [ plot3_SDM, plot3_CGM, plot3_Newton, plot3_QNewton_BFGS, plot3_QNewton_DFP ], ...
    'Ε}~Ί@', '€ηbωz@', 'Newton@', 'Newton@iBFGSj', 'Newton@iDFPj', 'Location', 'NorthEast' ...
    );

%% Ίi
subplot( 2, 1, 2 ); hold on;

% ³Μ
contour( X, Y, Z, 100 );

% πΝπ
scatter( x_opt_Analytic(1), x_opt_Analytic(2), 50, 'MarkerEdgeColor', [ 0, 0, 0 ], 'MarkerFaceColor', [ 1, 0, 0 ] );

% Ε}~Ί@
plot_SDM = plot( x_history_SDM(:,1), x_history_SDM(:,2), '-o', 'Color', [ 1, 0, 0 ], 'LineWidth', 0.5, 'MarkerSize', 3 );

% €ηbωz@
plot_CGM = plot( x_history_CGM(:,1), x_history_CGM(:,2), '-o', 'Color', [ 0, 0, 1 ], 'LineWidth', 0.5, 'MarkerSize', 3 );

% Newton@
plot_Newton = plot( x_history_Newton(:,1), x_history_Newton(:,2), '-o', 'Color', [ 0, 0.75, 0 ], 'LineWidth', 0.5, 'MarkerSize', 3 );

% Newton@iBFGSj
plot_QNewton_BFGS = plot( x_history_QNewton_BFGS(:,1), x_history_QNewton_BFGS(:,2), '-o', 'Color', [ 1, 0.5, 0 ], 'LineWidth', 0.5, 'MarkerSize', 3 );

% Newton@iDFPj
plot_QNewton_DFP = plot( x_history_QNewton_DFP(:,1), x_history_QNewton_DFP(:,2), '-o', 'Color', [ 1, 0, 0.5 ], 'LineWidth', 0.5, 'MarkerSize', 3 );

% eνέθ
xlim( [ x_min, x_max ] );
ylim( [ y_min, y_max ] );
legend( ...
    [ plot_SDM, plot_CGM, plot_Newton, plot_QNewton_BFGS, plot_QNewton_DFP ], ...
    'Ε}~Ί@', '€ηbωz@', 'Newton@', 'Newton@iBFGSj', 'Newton@iDFPj', 'Location', 'NorthEast' ...
    );

clearvars -except x0 *history* *opt*