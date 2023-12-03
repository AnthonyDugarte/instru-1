global R1 R2 R3 V vc0 il0 ic0 vl0 x0;

ic0 = (-R1*il0 - vc0 + V)/(R1 + R3);
vl0 = (((-R2 - R3)*R1 - R2*R3)*il0 + R3*V + R1*vc0)/(R1 + R3);

x0 = [ vc0; il0; ic0; vl0];