function dydt = edos(t,y)
global R1 R2 R3 C V L;

dydt = [ ...

% continuas

   % vc = y(1)
  -R1*y(2)/(C*(R1 + R3)) - y(1)/(C*(R1 + R3)) + V/(C*(R1 + R3)); ...
  % il = y(2)
  ((-R2 - R3)*R1 - R2*R3)*y(2)/(L*(R1 + R3)) + R1*y(1)/(L*(R1 + R3)) + R3*V/(L*(R1 + R3)); ...

% discontinuas

  % ic = y(3)
  -R1*y(4)/(L*(R1 + R3)) - y(3)/(C*(R1 + R3));...
  % vl = y(4)
  (-(R2 + R3)*R1 - R2*R3)*y(4)/(L*(R1 + R3)) + y(3)*R1/(C*(R1 + R3));...
];
end