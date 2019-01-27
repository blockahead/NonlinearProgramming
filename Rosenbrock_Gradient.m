function grad = Rosenbrock_Gradient( x )
    grad = [
        200 * ( x(2) - x(1)^2 ) * ( -2 * x(1) ) - ( 2 * ( 1 - x(1) ) );
        200 * ( x(2) - x(1)^2 );
    ]';
end