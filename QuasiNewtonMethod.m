function [ x_opt, x_history ] = QuasiNewtonMethod( x0, c, h, calcFunction, calcGradient, method )
    % ���̏�������l
    x = x0;
    
    % Hesse�s��̋ߎ��s��̏����l
    H = eye( length( x0 ) );
    
    % ���O���̋L�^
    x_history = x';
    
    for cnt = 1:1000
        grad = calcGradient( x );
        
        % ���z��c�ȉ��Ȃ�I��
        if( norm( grad ) < c )
            break;
        % ���z��c�ȏ�Ȃ璼���T���ɂ������X�V
        else
            % �T���������v�Z
            s = -( H ) \ ( calcGradient( x )' );
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
            
            y = ( calcGradient( x + dx )' - calcGradient( x )' );
            
            if( strcmp( method, 'BFGS' ) )
                % Broyden-Fletcher-Goldfarb-Shanno�@�iBFGS�@�j
                H = H + ( ( y * y' ) / ( y' * dx ) ) - ( ( H * ( dx * dx' ) * H ) / ( dx' * H * dx ) );
            elseif( strcmp( method, 'DFP' ) )
                % Davidon-Fletcher-Powell�@�iDFP�@�j
                E = eye( size( H ) );
                H = ( ( y * y' ) / ( y' * dx ) ) +  ( E - ( ( y * dx' ) / ( y' * dx ) ) ) * H * ( E - ( ( dx * y' ) / ( dx' * y ) ) );
            else
                error( 'Undefined method' );
            end
            
            x = x + dx;
        end
    end
    
    % ���l��
    x_opt = x;
end