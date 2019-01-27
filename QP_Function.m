% •]‰¿”Ÿ”‚Ì’l‚ğ‹‚ß‚é
function ret = QP_Function( x )
    A = evalin( 'base', 'QP_A' );
    b = evalin( 'base', 'QP_b' );
    
    ret = ( 1 / 2 ) * x' * A * x + b' * x;
end