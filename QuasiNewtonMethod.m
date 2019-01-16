function [ x_opt, x_history ] = QuasiNewtonMethod( x0, c, h, method )
    % ���̏�������l
    x = x0;
    
    % Hesse�s��̋ߎ��s��̏����l
    H = eye( length( x0 ) );
    
    % ���O���̋L�^
    x_history = x';
    
    % ���݂̔�����
    k = 0;
    for cnt = 1:1000
        grad = calcGradient( x );
        
        % ���z��c�ȉ��Ȃ�I��
        if( norm( grad ) < c )
            break;
        % ���z��c�ȏ�Ȃ璼���T���ɂ������X�V
        else
            dx = -( H ) \ ( calcGradient( x )' );
            alpha_opt = LineSearch( x, dx, h );
            dx = alpha_opt * dx;
            s = dx;
            y = ( calcGradient( x + dx )' - calcGradient( x )' );
            
            if( strcmp( method, 'BFGS' ) )
                % Broyden-Fletcher-Goldfarb-Shanno�@�iBFGS�@�j
                H = H + ( ( y * y' ) / ( y' * s ) ) - ( ( H * ( s * s' ) * H ) / ( s' * H * s ) );
            elseif( strcmp( method, 'DFP' ) )
                % Davidon-Fletcher-Powell�@�iDFP�@�j
                E = eye( size( H ) );
                H = ( ( y * y' ) / ( y' * s ) ) +  ( E - ( ( y * s' ) / ( y' * s ) ) ) * H * ( E - ( ( s * y' ) / ( s' * y ) ) );
            else
                error( 'Undefined method' );
            end
            
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