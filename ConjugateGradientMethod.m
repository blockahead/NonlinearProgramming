function [ x_opt, x_history ] = ConjugateGradientMethod( x0, c, h, calcFunction, calcGradient )
    % ���̏�������l
    x = x0;
    
    % ���O���̋L�^
    x_history = x';
    
    % �������z
    d_pre = -( calcGradient( x )' );
    
    % �����T�������i�ŋ}�~���@�Ɠ����j
    s = d_pre;
    
    % ���݂̔�����
    k = 0;
    
    for cnt = 1:1000
        % d��c�����Ȃ�I��
        if( norm( d_pre ) < c )
            break;
        % ���z��c�ȏ�Ȃ璼���T���ɂ������X�V
        else
            % �P�ʃx�N�g���ɕϊ�
            s_unit = s / norm( s );
            % �����T���@�ōœK������[ alpha_lower, alpha_upper ]�Ɉ͂�����
            [ alpha_lower, alpha_upper ] = LineSearch( x, s_unit, h, calcFunction );
            % ���������@�ŕ�ԓ���T��
            alpha_opt = GoldenSectionMethod( x, s_unit, alpha_lower, alpha_upper, calcFunction );
            dx = alpha_opt * s_unit;
            
            % ���O���̋L�^ ��������
            buff_x = linspace( x(1), x(1) + dx(1), floor( alpha_opt / h ) + 1 )';
            buff_y = linspace( x(2), x(2) + dx(2), floor( alpha_opt / h ) + 1 )';
            x_history = [ x_history;[ buff_x, buff_y ] ];
            % ���O���̋L�^ �����܂�
            
            x = x + dx;

            if( k == ( length( x0 ) - 1 ) )
                k = 0;
                d_pre  = -( calcGradient( x )' );
                % �T���������v�Z
                s = d_pre;
                
                continue;
            else
                d = -( calcGradient( x )' );
                beta = ( d' * ( d - d_pre ) / ( d_pre' * d_pre ) );
                % �T���������v�Z
                s = d + beta * s;
                
                d_pre = d;
                
                k = k + 1;
            end
        end
    end
    
    % ���l��
    x_opt = x;
end