function [ x_opt, x_history ] = NewtonMethod( x0, c, ~ )
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
            dx = -( calcHessian( x ) ) \ ( calcGradient( x )' );
            
            % ���O���̋L�^�p
            buff_x = linspace( x(1), x(1) + dx(1), 1 )';
            buff_y = linspace( x(2), x(2) + dx(2), 1 )';
            
            x = x + dx;
            
            x_history = [ x_history;[ buff_x, buff_y ] ];
        end
    end
    
    % ���l��
    x_opt = x;
end