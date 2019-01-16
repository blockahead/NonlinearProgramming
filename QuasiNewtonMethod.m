function [ x_opt, x_history ] = QuasiNewtonMethod( x0, c, h, method )
    % 解の初期推定値
    x = x0;
    
    % Hesse行列の近似行列の初期値
    H = eye( length( x0 ) );
    
    % 解軌道の記録
    x_history = x';
    
    % 現在の反復回数
    k = 0;
    for cnt = 1:1000
        grad = calcGradient( x );
        
        % 勾配がc以下なら終了
        if( norm( grad ) < c )
            break;
        % 勾配がc以上なら直線探索により解を更新
        else
            dx = -( H ) \ ( calcGradient( x )' );
            alpha_opt = LineSearch( x, dx, h );
            dx = alpha_opt * dx;
            s = dx;
            y = ( calcGradient( x + dx )' - calcGradient( x )' );
            
            if( strcmp( method, 'BFGS' ) )
                % Broyden-Fletcher-Goldfarb-Shanno法（BFGS法）
                H = H + ( ( y * y' ) / ( y' * s ) ) - ( ( H * ( s * s' ) * H ) / ( s' * H * s ) );
            elseif( strcmp( method, 'DFP' ) )
                % Davidon-Fletcher-Powell法（DFP法）
                E = eye( size( H ) );
                H = ( ( y * y' ) / ( y' * s ) ) +  ( E - ( ( y * s' ) / ( y' * s ) ) ) * H * ( E - ( ( s * y' ) / ( s' * y ) ) );
            else
                error( 'Undefined method' );
            end
            
            % 解軌道の記録用
            buff_x = linspace( x(1), x(1) + dx(1), 1 )';
            buff_y = linspace( x(2), x(2) + dx(2), 1 )';
            
            x = x + dx;
            
            x_history = [ x_history;[ buff_x, buff_y ] ];
        end
    end
    
    % 数値解
    x_opt = x;
end