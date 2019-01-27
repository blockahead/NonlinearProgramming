function alpha_opt = GoldenSectionMethod( x, s, alpha_lower, alpha_upper, calcFunction )
    % 黄金比
    r = ( ( -1 + sqrt( 5 ) ) / ( 2 ) );
    
    for cnt = 1:1000
        alpha_1 = alpha_lower + ( 1 - r ) * ( alpha_upper - alpha_lower );
        alpha_2 = alpha_lower + r * ( alpha_upper - alpha_lower );

        % 閉区間の幅がeps未満なら終了
        if( abs( alpha_upper - alpha_lower ) < eps )
            break;
        % 閉区間の幅がeps以上なら黄金分割法により解を更新
        else
            if( calcFunction( x + alpha_1 * s ) < calcFunction( x + alpha_2 * s ) )
                alpha_upper = alpha_2;
            else
                alpha_lower = alpha_1;
            end
        end
    end
    
    alpha_opt = alpha_upper;
end