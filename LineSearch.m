% 直線探索
function [ alpha_lower, alpha_upper ] = LineSearch( x, s, h, calcFunction )
    value_pre = calcFunction( x );

    % スカラー
    alpha_pre = 0;
    alpha = 0;
    
    for cnt = 1:1000
        alpha = alpha + h;
        value = calcFunction( x + alpha * s );
        
        % 前回値よりも増加方向または停滞であれば終了
        if( value >= value_pre )
            break;
        % 前回値よりも減少方向であれば継続
        else
            alpha_pre = alpha;
            value_pre = value;
        end
    end
    
    alpha_lower = alpha_pre;
    alpha_upper = alpha;
end