function hessian = cross_Hessian( x )
    hessian = [
        2 + 2 * x(2)^2, 2 * 2 * x(1) * x(2);
        2 * 2 * x(1) * x(2), 2 * x(1)^2 + 9 * 2;
   ];
end