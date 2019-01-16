% �����T��
function alpha_opt = LineSearch( x, s, h )
    value_pre = calcFunction( x );

    % �X�J���[
    alpha = h;
    
    for cnt = 1:1000
        value = calcFunction( x + alpha * s );
        
        % �O��l�������������ł���ΏI��
        if( value >= value_pre )
            break;
        % �O��l�������������ł���Όp��
        else
            alpha = alpha + h;
            value_pre = value;
        end
    end
    
    alpha_opt = alpha;
end