% �����T��
function [ alpha_lower, alpha_upper ] = LineSearch( x, s, h, calcFunction )
    value_pre = calcFunction( x );

    % �X�J���[
    alpha_pre = 0;
    alpha = 0;
    
    for cnt = 1:1000
        alpha = alpha + h;
        value = calcFunction( x + alpha * s );
        
        % �O��l�������������܂��͒�؂ł���ΏI��
        if( value >= value_pre )
            break;
        % �O��l�������������ł���Όp��
        else
            alpha_pre = alpha;
            value_pre = value;
        end
    end
    
    alpha_lower = alpha_pre;
    alpha_upper = alpha;
end