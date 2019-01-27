close all;
clc;
clear;

%% �œK���Ώۂ̔����i���񂠂�j
% QP
QP_A = [ 4, 1;1, 2 ];
if( det( QP_A ) <= 0 )
    error( 'QP_A�͓ʊ֐��ł͂Ȃ�' );
end
QP_b = [ -3;-4 ];

calcFunction = @QP_Function; % �œK���Ώۂ̔���
calcGradient = @QP_Gradient; % �����̌��z
calcHessian = @QP_Hessian; % ������Hesse�s��
calcConstraint = @QP_Constraint;
x_opt_Analytic = -( QP_A \ QP_b ); % ��͉�

% �`��͈�
x_min = -10;
x_max = 10;
y_min = -10;
y_max = 10;

% ���������
x0 = [ -8, 8 ]';

%% �]�������̕`��p
% �]�������̌v�Z�͈�
x_vec = linspace( x_min, x_max, 31 )';
y_vec = linspace( y_min, y_max, 31 )';

X = zeros( length( x_vec ), length( y_vec ) );
Y = zeros( length( x_vec ), length( y_vec ) );
Z = zeros( length( x_vec ), length( y_vec ) );

% �]�������̌v�Z
for cnt_x = 1:length( x_vec )
    for cnt_y = 1:length( y_vec )
        X(cnt_x,cnt_y) = x_vec(cnt_x);
        Y(cnt_x,cnt_y) = y_vec(cnt_y);
        Z(cnt_x,cnt_y) = calcFunction( [ x_vec(cnt_x), y_vec(cnt_y) ]' );
    end
end
z_min = min( min( Z, [], 1 ) );
z_max = max( max( Z, [], 1 ) );

%% ����̕`��p
X_Constraint = zeros( length( x_vec ), length( y_vec ) );
Y_Constraint = zeros( length( x_vec ), length( y_vec ) );
Z_Constraint = zeros( length( x_vec ), length( y_vec ) );

for cnt_x = 1:length( x_vec )
    for cnt_y = 1:length( y_vec )
        X_Constraint(cnt_x,cnt_y) = x_vec(cnt_x);
        Y_Constraint(cnt_x,cnt_y) = y_vec(cnt_y);
        Z_Constraint(cnt_x,cnt_y) = calcFunction( [ x_vec(cnt_x), y_vec(cnt_y) ]' );
    end
end


%% �T��
% �����T���̎�������p�����[�^
c = 0.01;

% ���ݕ�
h = 0.03;

% �ŋ}�~���@
[ x_opt_SDM, x_history_SDM ] = SteepestDescentMethod( x0, c, h, calcFunction, calcGradient );
z_history_SDM = zeros( size( x_history_SDM(:,1) ) );
for cnt = 1:length( z_history_SDM )
    z_history_SDM(cnt) = calcFunction( x_history_SDM(cnt,:)' );
end

% ���b���z�@
[ x_opt_CGM, x_history_CGM ] = ConjugateGradientMethod( x0, c, h, calcFunction, calcGradient );
z_history_CGM = zeros( size( x_history_CGM(:,1) ) );
for cnt = 1:length( z_history_CGM )
    z_history_CGM(cnt) = calcFunction( x_history_CGM(cnt,:)' );
end

% Newton�@
[ x_opt_Newton, x_history_Newton] = NewtonMethod( x0, c, calcGradient, calcHessian );
z_history_Newton = zeros( size( x_history_Newton(:,1) ) );
for cnt = 1:length( z_history_Newton)
    z_history_Newton(cnt) = calcFunction( x_history_Newton(cnt,:)' );
end

% ��Newton�@�iBFGS�j
[ x_opt_QNewton_BFGS, x_history_QNewton_BFGS] = QuasiNewtonMethod( x0, c, h, calcFunction, calcGradient, 'BFGS' );
z_history_QNewton_BFGS = zeros( size( x_history_QNewton_BFGS(:,1) ) );
for cnt = 1:length( z_history_QNewton_BFGS)
    z_history_QNewton_BFGS(cnt) = calcFunction( x_history_QNewton_BFGS(cnt,:)' );
end

% ��Newton�@�iDFP�j
[ x_opt_QNewton_DFP, x_history_QNewton_DFP] = QuasiNewtonMethod( x0, c, h, calcFunction, calcGradient, 'DFP' );
z_history_QNewton_DFP = zeros( size( x_history_QNewton_DFP(:,1) ) );
for cnt = 1:length( z_history_QNewton_DFP)
    z_history_QNewton_DFP(cnt) = calcFunction( x_history_QNewton_DFP(cnt,:)' );
end


%% Plotting
figure( 'Name', 'Mesh', 'Position', [1300 50 600 900] );

%% ��i
subplot( 2, 1, 1 ); hold on;
Z_buff = Z;
% Z_buff( Z_buff > z_max ) = z_max;

% ���̔���
contour3( X, Y, Z_buff, 100 );

% ��͉�
scatter3( x_opt_Analytic(1), x_opt_Analytic(2), calcFunction(x_opt_Analytic), 50, 'MarkerEdgeColor', [ 0, 0, 0 ], 'MarkerFaceColor', [ 1, 0, 0 ] );

% �ŋ}�~���@
plot3_SDM = plot3( x_history_SDM(:,1), x_history_SDM(:,2), z_history_SDM(:,1), 'Color', [ 1, 0, 0 ], 'LineWidth', 1 );

% ���b���z�@
plot3_CGM = plot3( x_history_CGM(:,1), x_history_CGM(:,2), z_history_CGM(:,1), 'Color', [ 0, 0, 1 ], 'LineWidth', 1 );

% Newton�@
plot3_Newton = plot3( x_history_Newton(:,1), x_history_Newton(:,2), z_history_Newton(:,1), 'Color', [ 0, 0.75, 0 ], 'LineWidth', 1 );

% ��Newton�@�iBFGS�j
plot3_QNewton_BFGS = plot3( x_history_QNewton_BFGS(:,1), x_history_QNewton_BFGS(:,2), z_history_QNewton_BFGS(:,1), 'Color', [ 1, 0.5, 0 ], 'LineWidth', 1 );

% ��Newton�@�iBFGS�j
plot3_QNewton_DFP = plot3( x_history_QNewton_DFP(:,1), x_history_QNewton_DFP(:,2), z_history_QNewton_DFP(:,1), 'Color', [ 1, 0, 0.5 ], 'LineWidth', 1 );

% �e��ݒ�
colormap( jet(100) );
view( [ -5, 50 ] );
xlim( [ x_min, x_max ] );
ylim( [ y_min, y_max ] );
zlim( [ z_min, z_max ] );
legend( ...
    [ plot3_SDM, plot3_CGM, plot3_Newton, plot3_QNewton_BFGS, plot3_QNewton_DFP ], ...
    '�ŋ}�~���@', '���b���z�@', 'Newton�@', '��Newton�@�iBFGS�j', '��Newton�@�iDFP�j', 'Location', 'NorthEast' ...
    );

%% ���i
subplot( 2, 1, 2 ); hold on;

% ���̔���
contour( X, Y, Z, 100 );

% ��͉�
scatter( x_opt_Analytic(1), x_opt_Analytic(2), 50, 'MarkerEdgeColor', [ 0, 0, 0 ], 'MarkerFaceColor', [ 1, 0, 0 ] );

% �ŋ}�~���@
plot_SDM = plot( x_history_SDM(:,1), x_history_SDM(:,2), '-o', 'Color', [ 1, 0, 0 ], 'LineWidth', 0.5, 'MarkerSize', 3 );

% ���b���z�@
plot_CGM = plot( x_history_CGM(:,1), x_history_CGM(:,2), '-o', 'Color', [ 0, 0, 1 ], 'LineWidth', 0.5, 'MarkerSize', 3 );

% Newton�@
plot_Newton = plot( x_history_Newton(:,1), x_history_Newton(:,2), '-o', 'Color', [ 0, 0.75, 0 ], 'LineWidth', 0.5, 'MarkerSize', 3 );

% ��Newton�@�iBFGS�j
plot_QNewton_BFGS = plot( x_history_QNewton_BFGS(:,1), x_history_QNewton_BFGS(:,2), '-o', 'Color', [ 1, 0.5, 0 ], 'LineWidth', 0.5, 'MarkerSize', 3 );

% ��Newton�@�iDFP�j
plot_QNewton_DFP = plot( x_history_QNewton_DFP(:,1), x_history_QNewton_DFP(:,2), '-o', 'Color', [ 1, 0, 0.5 ], 'LineWidth', 0.5, 'MarkerSize', 3 );

% �e��ݒ�
xlim( [ x_min, x_max ] );
ylim( [ y_min, y_max ] );
legend( ...
    [ plot_SDM, plot_CGM, plot_Newton, plot_QNewton_BFGS, plot_QNewton_DFP ], ...
    '�ŋ}�~���@', '���b���z�@', 'Newton�@', '��Newton�@�iBFGS�j', '��Newton�@�iDFP�j', 'Location', 'NorthEast' ...
    );

clearvars -except x0 *history* *opt*