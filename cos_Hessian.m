function hessian = cos_Hessian( x )
    hessian = [
        ( 0.5 * pi )^2 * cos( 0.5 * pi * x(1) ) * cos( pi * x(2) ), -( 0.5 * pi *pi ) * sin( 0.5 * pi * x(1) ) * sin( pi * x(2) );
        -( 0.5 * pi *pi ) * sin( 0.5 * pi * x(1) ) * sin( pi * x(2) ), ( pi )^2 * cos( 0.5 * pi * x(1) ) * cos( pi * x(2) );
    ];
end