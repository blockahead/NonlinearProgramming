% •]‰¿”Ÿ”‚ÌŒù”z‚ğ‹‚ß‚é
function grad = QP_Gradient( x )
    A = evalin( 'base', 'QP_A' );
    b = evalin( 'base', 'QP_b' );
    
    grad = ( A * x + b )';
end