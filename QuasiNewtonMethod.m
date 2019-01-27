function [ x_opt, x_history ] = QuasiNewtonMethod( x0, c, h, calcFunction, calcGradient, method )
    % 解の初期推定値
    x = x0;
    
    % Hesse行列の近似行列の初期値
    H = eye( length( x0 ) );
    
    % 解軌道の記録
    x_history = x';
    
    for cnt = 1:1000
        grad = calcGradient( x );
        
        % 勾配がc以下なら終了
        if( norm( grad ) < c )
            break;
        % 勾配がc以上なら直線探索により解を更新
        else
            % 探索方向を計算
            s = -( H ) \ ( calcGradient( x )' );
            % 単位ベクトルに変換
            s_unit = s / norm( s );
            
            % 直線探索法で最適解を閉区間[ alpha_lower, alpha_upper ]に囲い込む
            [ alpha_lower, alpha_upper ] = LineSearch( x, s_unit, h, calcFunction );
            % 黄金分割法で閉区間内を探索
            alpha_opt = GoldenSectionMethod( x, s_unit, alpha_lower, alpha_upper, calcFunction );
            dx = alpha_opt * s_unit;
            
            % 解軌道の記録 ここから
            buff_x = linspace( x(1), x(1) + dx(1), floor( alpha_opt / h ) + 1 )';
            buff_y = linspace( x(2), x(2) + dx(2), floor( alpha_opt / h ) + 1 )';
            x_history = [ x_history;[ buff_x, buff_y ] ];
            % 解軌道の記録 ここまで
            
            y = ( calcGradient( x + dx )' - calcGradient( x )' );
            
            if( strcmp( method, 'BFGS' ) )
                % Broyden-Fletcher-Goldfarb-Shanno法（BFGS法）
                H = H + ( ( y * y' ) / ( y' * dx ) ) - ( ( H * ( dx * dx' ) * H ) / ( dx' * H * dx ) );
            elseif( strcmp( method, 'DFP' ) )
                % Davidon-Fletcher-Powell法（DFP法）
                E = eye( size( H ) );
                H = ( ( y * y' ) / ( y' * dx ) ) +  ( E - ( ( y * dx' ) / ( y' * dx ) ) ) * H * ( E - ( ( dx * y' ) / ( dx' * y ) ) );
            else
                error( 'Undefined method' );
            end
            
            x = x + dx;
        end
    end
    
    % 数値解
    x_opt = x;
end