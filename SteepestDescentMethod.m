function [ x_opt, x_history ] = SteepestDescentMethod( x0, c, h )
    % 解の初期推定値
    x = x0;
    
    % 解軌道の記録
    x_history = x';
    
    for cnt = 1:1000
        grad = calcGradient( x );
        
        % 勾配がc以下なら終了
        if( norm( grad ) < c )
            break;
        % 勾配がc以上なら直線探索により解を更新
        else
            s = -grad';
            alpha_opt = LineSearch( x, s, h );
            dx = alpha_opt * s;

            % 解軌道の記録用
            buff_x = linspace( x(1), x(1) + dx(1), floor( alpha_opt / h ) + 1 )';
            buff_y = linspace( x(2), x(2) + dx(2), floor( alpha_opt / h ) + 1 )';
            
            x = x + dx;
            
            x_history = [ x_history;[ buff_x, buff_y ] ];
        end
    end
    
    % 数値解
    x_opt = x;
end