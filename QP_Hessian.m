% ]ΏΜHessesρπίι
function hessian = QP_Hessian( ~ )
    A = evalin( 'base', 'QP_A' );
    b = evalin( 'base', 'QP_b' );
    
    hessian = A;
end