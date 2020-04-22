classdef robot < handle
    properties
        % parameters
        g = 9.80665;
        h = 0.02;
        t0 = 0.0;
        t1 = 0.03;
        
        l1 = 0.07;
        l2 = 0.07;
        phi = pi/4;
        
        Beta = 38.9;
        
        J = [];
        vx = [];
        vz = [];
        az = [];
        jz = [];
        dq1 = [];
        dq2 = [];
        
        
    end
    
    methods
        function cal_J(self, q1, q2)
            % 2リンクモデル
            XE_RHS = self.l1*cos(q1) + self.l2*cos(q1+q2);
            ZE_RHS = self.l1*sin(q1) + self.l2*sin(q1+q2);

            self.J = [-self.l1*sin(q1) - self.l2*sin(q1+q2), - self.l2*sin(q1+q2);
                    self.l1*cos(q1) + self.l2*cos(q1+q2), self.l2*cos(q1+q2)];
        end
        
        function x_func(self, t)
            self.vx = -self.Beta*t;
        end
        
        function z_func(self, t)
            % vzの境界条件
            vz0 = 0.0;
            vz1 = sqrt(2*self.g*self.h);
            az0 = 0.0;
            az1 = self.g;
            jz0 = 0.0;
            jz1 = 0.0;
            
            T = [self.t0, self.t1];
            param = [vz0, vz1, az0, az1, jz0, jz1];
            X = Spline5(T, param);
            self.vz = X(1)*t.^5 + X(2)*t.^4 + X(3)*t.^3 + X(4)*t.^2 + X(5)*t + X(6);
            self.az = 5*X(1)*t.^4 + 4*X(2)*t.^3 + 3*X(3)*t.^2 + 2*X(4)*t + X(5);
            self.jz = 20*X(1)*t.^3 + 12*X(2)*t.^2 + 6*X(3)*t + 2*X(4);
        end
        
        function vel2dq(self)
            v = [self.vx; self.vz];
            dq = self.J\v;
            
            self.dq1 = dq(1);
            self.dq2 = dq(2);
        end
        
    end
end
