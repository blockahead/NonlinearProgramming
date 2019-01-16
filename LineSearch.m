% 直線探索
function alpha_opt = LineSearch( x, s, h )
    value_pre = calcFunction( x );

    % スカラー
    alpha = h;
    
    for cnt = 1:1000
        value = calcFunction( x + alpha * s );
        
        % 前回値よりも増加方向であれば終了
        if( value >= value_pre )
            break;
        % 前回値よりも減少方向であれば継続
        else
            alpha = alpha + h;
            value_pre = value;
        end
    end
    
    alpha_opt = alpha;
end