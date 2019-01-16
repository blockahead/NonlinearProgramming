function [ x_opt, x_history ] = SteepestDescentMethod( x0, c, h )
    % ���̏�������l
    x = x0;
    
    % ���O���̋L�^
    x_history = x';
    
    for cnt = 1:1000
        grad = calcGradient( x );
        
        % ���z��c�ȉ��Ȃ�I��
        if( norm( grad ) < c )
            break;
        % ���z��c�ȏ�Ȃ璼���T���ɂ������X�V
        else
            s = -grad';
            alpha_opt = LineSearch( x, s, h );
            dx = alpha_opt * s;

            % ���O���̋L�^�p
            buff_x = linspace( x(1), x(1) + dx(1), floor( alpha_opt / h ) + 1 )';
            buff_y = linspace( x(2), x(2) + dx(2), floor( alpha_opt / h ) + 1 )';
            
            x = x + dx;
            
            x_history = [ x_history;[ buff_x, buff_y ] ];
        end
    end
    
    % ���l��
    x_opt = x;
end