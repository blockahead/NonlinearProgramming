function grad = cos_Gradient( x )
    grad = [
        ( 0.5 * pi ) * sin( 0.5 * pi * x(1) ) * cos( pi * x(2) );
        pi * cos( 0.5 * pi * x(1) ) * sin( pi * x(2) );
    ]';
end