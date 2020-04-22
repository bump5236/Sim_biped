function [X] = Spline5(U, param) 
    % 制約条件
    u0 = U(1);
    u1 = U(2);
    p0 = param(1);
    p1 = param(2); 
    dp0 = param(3);
    dp1 = param(4);
    ddp0 = param(5);
    ddp1 = param(6);

    M = [u0^5 u0^4 u0^3 u0^2 u0 1;
            u1^5 u1^4 u1^3 u1^2 u1 1;
            5*u0^4 4*u0^3 3*u0^2 2*u0 1 0;
            5*u1^4 4*u1^3 3*u1^2 2*u1 1 0;
            20*u0^3 12*u0^2 6*u0 2 0 0;
            20*u1^3 12*u1^2 6*u1 2 0 0];

    V = [p0; p1; dp0; dp1; ddp0; ddp1];

    X = M\V;    % inv(M)より精度が良く、計算も速い
    
end




