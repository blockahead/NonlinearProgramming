function [ x_opt, x_history ] = ConjugateGradientMethod( x0, c, h )
    % 解の初期推定値
    x = x0;
    
    % 解軌道の記録
    x_history = x';
    
    % 初期勾配
    d_pre = -( calcGradient( x )' );
    
    % 初期探索方向（最急降下法と同じ）
    s = d_pre;
    
    % 現在の反復回数
    k = 0;
    
    for cnt = 1:1000
        % dがc以下なら終了
        if( norm( d_pre ) < c )
            break;
        % 勾配がc以上なら直線探索により解を更新
        else
            alpha_opt = LineSearch( x, s, h );
            dx = alpha_opt * s;
            
            % 解軌道の記録用
            buff_x = linspace( x(1), x(1) + dx(1), floor( alpha_opt / h ) + 1 )';
            buff_y = linspace( x(2), x(2) + dx(2), floor( alpha_opt / h ) + 1 )';
            
            x = x + dx;

            x_history = [ x_history;[ buff_x, buff_y ] ];

            if( k == ( length( x0 ) - 1 ) )
                k = 0;
                d_pre  = -( calcGradient( x )' );
                s = d_pre;
                continue;
            else
                d = -( calcGradient( x )' );
                beta = ( d' * ( d - d_pre ) / ( d_pre' * d_pre ) );
                s = d + beta * s;
                d_pre = d;
                
                k = k + 1;
            end
        end
    end
    
    % 数値解
    x_opt = x;
end