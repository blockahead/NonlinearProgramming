% •]‰¿”Ÿ”‚ÌŒù”z‚ğ‹‚ß‚é
% 2x^2 + xy + y^2 - 3x - 4y
function grad = calcGradient( x )
    grad = [
        4 * x(1) + x(2) - 3;
        x(1) + 2 * x(2) - 4;
    ]';
end