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
legend('|E_x|^2','|E_y|^2','|E|^2')
grid('on')
xlabel('Phase rotation [deg]')
ylabel('Signal [arb.]')


%% Added length to phase rotation
% Assume propagation exp(-\alpha * Z)
% \alpha is phase rotation, Z is propagation distance
%Changed to realistic phase rotations and lengths
clear all; clc
Ein = [0.9 ;0.1];
HorzPol = [1 0 ; 0 0];
QWPP = [exp(i*pi/4) 0 ; 0 i*exp(i*pi/4)];
QWPN = [-exp(-i*pi/4) 0 ; 0 -i*exp(i*pi/4)];

for lmn = 1:90; %Phase rotation loop microrad
    for prq = 1:50 %distance loop microns
        
        z = (prq-1)./1e3;
        phi = exp((((lmn-1)*1e-3)*pi/180)*z);
        
        Ang =45*(pi/180);%lmn*pi/180;
        RotMat = [cos(Ang) -sin(Ang);sin(Ang) cos(Ang)];
        RotMatM = [cos(-Ang) -sin(-Ang);sin(-Ang) cos(-Ang)];
        
        Ang2 = Ang+(90*pi/180);%Ang + (90*pi/180);
        RotMat2 = [cos(Ang2) -sin(Ang2);sin(Ang2) cos(Ang2)];
        RotMatM2 = [cos(-Ang2) -sin(-Ang2);sin(-Ang2) cos(-Ang2)];
        
        BIREF = [phi 0 ; 0 -phi];
        
        Eout = RotMatM2*  HorzPol * QWPN * RotMat2 * BIREF *RotMatM*   QWPP * HorzPol  * RotMat * Ein;
        Ex(lmn,prq) = Eout(1);
        Ey(lmn,prq) = Eout(2);
        E(lmn,prq) = abs(Eout(1)).^2 + abs(Eout(2)).^2;
        zplot(prq) = z*1e6;
    end
    
    Phiplot(lmn) = (lmn)*pi/180;
    
    
end
figure(2)
clf
pcolor(zplot,Phiplot,E)
xlabel('Propagation Distance [{\mu}m]')
ylabel('Phase rotation')
shading interp
colorbar

