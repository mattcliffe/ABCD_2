%%%%
% MJC ABCD For RCS Unit
%%%%

%% Laser through rotating polariser
% For test
Ein = [1 ;0];
HorzPol = [1 0 ; 0 0];

for lmn = 1:360
    
    Ang = lmn*pi/180;
    
    RotMatM = [cos(Ang) -sin(Ang);sin(Ang) cos(Ang)];
    RotMat = [cos(Ang) sin(Ang);-sin(Ang) cos(Ang)];
    
    Eout = RotMatM * HorzPol * RotMat * Ein;
    Ex(lmn) = Eout(1);
    Ey(lmn) = Eout(2);
    
end

figure(1)
clf
plot(abs(Ex).^2,'k');
hold on
plot(abs(Ey).^2,'r')

%% Laser through rotating polariser and QWP
% QWP and Polar are angle dependant.
clear all; clc
Ein = [0.9 ;0.1];
HorzPol = [1 0 ; 0 0];
QWPP = [exp(i*pi/4) 0 ; 0 i*exp(i*pi/4)];
QWPN = [-exp(-i*pi/4) 0 ; 0 -i*exp(i*pi/4)];

for lmn = 1:90;
    
    
    Ang =45*(pi/180);%lmn*pi/180;
    RotMat = [cos(Ang) -sin(Ang);sin(Ang) cos(Ang)];
    RotMatM = [cos(-Ang) -sin(-Ang);sin(-Ang) cos(-Ang)];
    
    Ang2 = Ang+(90*pi/180);%Ang + (90*pi/180);
    RotMat2 = [cos(Ang2) -sin(Ang2);sin(Ang2) cos(Ang2)];
    RotMatM2 = [cos(-Ang2) -sin(-Ang2);sin(-Ang2) cos(-Ang2)];
    
    phi = lmn*pi/180;
    BIREF = [exp(i*phi) 0 ; 0 exp(-i*phi)];

    Eout = RotMatM2*  HorzPol * QWPN * RotMat2 * BIREF *RotMatM*   QWPP * HorzPol  * RotMat * Ein;
    Ex(lmn) = Eout(1);
    Ey(lmn) = Eout(2);
    E(lmn) = abs(Eout(1)).^2 + abs(Eout(2)).^2;
end

figure(2)
clf()
plot(abs(Ex).^2,'k');
hold on
plot(abs(Ey).^2,'r')
hold on 
plot(E,'b')
legend('|E_x|^2','|E_y|^2','E')