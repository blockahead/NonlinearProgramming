% •]‰¿”Ÿ”‚ÌHesses—ñ‚ğ‹‚ß‚é
function hessian = QP_Hessian( ~ )
    A = evalin( 'base', 'QP_A' );
    b = evalin( 'base', 'QP_b' );
    
    hessian = A;
end