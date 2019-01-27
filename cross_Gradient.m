function grad = cross_Gradient( x )
    grad = [
        2 * x(1) + 2 * x(1) * x(2)^2;
        2 * x(1)^2 * x(2) + 9 * 2 * x(2);
    ]';
end