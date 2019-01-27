function alpha_opt = GoldenSectionMethod( x, s, alpha_lower, alpha_upper, calcFunction )
    % ������
    r = ( ( -1 + sqrt( 5 ) ) / ( 2 ) );
    
    for cnt = 1:1000
        alpha_1 = alpha_lower + ( 1 - r ) * ( alpha_upper - alpha_lower );
        alpha_2 = alpha_lower + r * ( alpha_upper - alpha_lower );

        % ��Ԃ̕���eps�����Ȃ�I��
        if( abs( alpha_upper - alpha_lower ) < eps )
            break;
        % ��Ԃ̕���eps�ȏ�Ȃ物�������@�ɂ������X�V
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