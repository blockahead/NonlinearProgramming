function [ x_opt, x_history ] = ConjugateGradientMethod( x0, c, h )
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
        % d��c�ȉ��Ȃ�I��
        if( norm( d_pre ) < c )
            break;
        % ���z��c�ȏ�Ȃ璼���T���ɂ������X�V
        else
            alpha_opt = LineSearch( x, s, h );
            dx = alpha_opt * s;
            
            % ���O���̋L�^�p
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
    
    % ���l��
    x_opt = x;
end