%{
Author : Maharshi Gurjar
Elec 4700 CMPA
%}
%%
clc; close all; clear;
set(0, 'DefaultFigureWindowStyle', 'docked')
Is = 0.01e-12;
Ib = 0.1e-12;
Vb = 1.3;
Gp = 0.1;
Is = 0.01e-12; 
Ib = 0.1e-12; 
Vb = 1.3; 
Gp = 0.1; 
Voltage = linspace(-1.95,0.7,200);
I_1 = Is*(exp((1.2*Voltage)/0.025)-1) + Gp*Voltage - Ib*(exp((-1.2*(Voltage+Vb))/0.025)-1);
variation = linspace(-0.2,0.2,41);
I_2 = I_1;
for i = 1:length(I_2)
    error = variation(randi(length(variation)));
    I_2(i) = I_2(i)*(1+error);
end
figure(1);
plot(Voltage,I_1)
legend();
grid on;
title('Diode Current without Error')
xlabel('Voltage (V)')
ylabel('Current (A)')
figure(2);
plot(Voltage,I_2)
legend()
grid on;
title('Diode Current with Error')
xlabel('Voltage (V)')
ylabel('Current (A)')
f5 = figure(5);
semilogy(Voltage,abs(I_1))
legend()
grid on;
title('Diode Current without Error')
xlabel('Voltage (V)')
ylabel('Current (A)')
f6 = figure(6);
semilogy(Voltage,abs(I_2),'DisplayName','Calculated Diode Current')
legend()
grid on;
title('Diode Current with Error')
xlabel('Voltage (V)')
ylabel('Current (A)')
%%
%Part 2
FthOrder1 = polyfit(Voltage,I_1,4);
fthOrder2 = polyfit(Voltage,I_2,4);
ethOrder1 = polyfit(Voltage,I_1,8);
ethOrder2 = polyfit(Voltage,I_2,8);
fthI1 = polyval(FthOrder1,Voltage);
fthI2 = polyval(fthOrder2,Voltage);
ethI1 = polyval(ethOrder1,Voltage);
ethI2 = polyval(ethOrder2,Voltage);
figure(1)
hold on
plot(Voltage,fthI1,'r','DisplayName','[Fitted] 4th Order (No Variation)')
plot(Voltage,ethI1,'b','DisplayName','[Fitted] 8th Order (No Variation)')
legend()
grid on;
hold off
figure(2)
hold on
plot(Voltage,fthI2,'r','DisplayName','[Fitted] 4th Order (with Variation)')
plot(Voltage,ethI2,'b','DisplayName','[Fitted] 8th Order (with Variation)')
legend()
grid on;
hold off
figure(5)
hold on
semilogy(Voltage,abs(fthI1),'r','DisplayName','[Fitted] 4th Order (No Variation)')
semilogy(Voltage,abs(ethI1),'b','DisplayName','[Fitted] 8th Order (No Variation)')
legend()
grid on;
hold off
figure(6)
hold on
semilogy(Voltage,abs(fthI2),'r','DisplayName','[Fitted] 4th Order (with Variation)')
semilogy(Voltage,abs(ethI2),'b','DisplayName','[Fitted] 8th Order (with Variation)')
legend()
grid on;
hold off
%%
%Part 3
fo = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+D))/25e-3)-1)');
Voltage = Voltage.';
I_1 = I_1.';
I_2 = I_2.';
NLfitI1 = fit(Voltage,I_1,fo);
NLfitI2 = fit(Voltage,I_2,fo);
nlI1 = NLfitI1(Voltage);
nlI2 = NLfitI2(Voltage);
fa = fittype('A.*(exp(1.2*x/25e-3)-1) + 0.1.*x - C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
NLfitI1A = fit(Voltage,I_1,fa);
NLfitI2A = fit(Voltage,I_2,fa);
nlI1A = NLfitI1A(Voltage);
nlI2A = NLfitI2A(Voltage);
f3 = figure(3);
plot(Voltage,I_1)
hold on
plot(Voltage,nlI1A,'b','DisplayName','[2-Parameter] Non-Linear Fit')
legend()
grid on;
title('Diode Current without Error')
xlabel('Voltage (V)')
ylabel('Current (A)')
f4 = figure(4);
plot(Voltage,I_2,'r','DisplayName','[Calculated] Diode Current')
hold on
plot(Voltage,nlI2A,'b','DisplayName','[2-Parameter] Non-Linear Fit')
legend()
grid on;
title('Diode Current with Error')
xlabel('Voltage (V)')
ylabel('Current (A)')
f7 = figure(7);
semilogy(Voltage,abs(I_1),'r','DisplayName','Calculated Diode Current')
hold on
semilogy(Voltage,abs(nlI1A),'b','DisplayName','2-Parameter Non-Linear Fit')
legend()
grid on;
title('Diode Current without Error')
xlabel('Voltage (V)')
ylabel('Current (A)')
f8 = figure(8);
semilogy(Voltage,abs(I_2),'r','DisplayName','[Calculated] Diode Current')
hold on
semilogy(Voltage,abs(nlI2A),'b','DisplayName','[2-Parameter] Non-Linear Fit')
legend()
grid on;
title('Diode Current with Error')
xlabel('Voltage (V)')
ylabel('Current (A)')
fb = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
NLfitI1B = fit(Voltage,I_1,fb);
NLfitI2B = fit(Voltage,I_2,fb);
nlI1B = NLfitI1B(Voltage);
nlI2B = NLfitI2B(Voltage);
figure(3)
hold on
plot(Voltage,nlI1B,'c','DisplayName','[3-Parameter] Non-Linear Fit')
legend()
grid on;
title('Diode Current without Error')
xlabel('Voltage (V)')
ylabel('Current (A)')
figure(4)
hold on
plot(Voltage,nlI2B,'r','DisplayName','[3-Parameter] Non-Linear Fit')
legend()
grid on;
title('Diode Current with Error')
xlabel('Voltage (V)')
ylabel('Current (A)')
figure(7)
hold on
semilogy(Voltage,abs(nlI1B),'r','DisplayName','[3-Parameter] Non-Linear Fit')
legend()
grid on;
title('Diode Current without Error')
xlabel('Voltage (V)')
ylabel('Current (A)')
figure(8)
hold on
semilogy(Voltage,abs(nlI2B),'r','DisplayName','[3-Parameter] Non-Linear Fit')
legend()
grid on;
title('Diode Current with Error')
xlabel('Voltage (V)')
ylabel('Current (A)')
%%
%Part 4
net1 = cascadeforwardnet([10,8,6,4,2]);
net2 = net1;
inputs = transpose(Voltage);
outputs1 = transpose(I_1);
outputs2 = transpose(I_2);
net1 = train(net1,inputs,outputs1);
net2 = train(net2,inputs,outputs2);
netI1 = net1(inputs);
netI2 = net2(inputs);
figure(3)
hold on
plot(inputs,netI1,'r','DisplayName','Neural Net Model')
legend()
grid on;
title('Diode Current without Error')
xlabel('Voltage (V)')
ylabel('Current (A)')
figure(4)
hold on
plot(inputs,netI2,'r','DisplayName','Neural Net Model')
legend()
grid on;
title('Diode Current with Error')
xlabel('Voltage (V)')
ylabel('Current (A)')
figure(7)
hold on
semilogy(inputs,abs(netI1),'r','DisplayName','Neural Net Model')
legend()
grid on;
title('Diode Current without Error')
xlabel('Voltage (V)')
ylabel('Current (A)')
figure(8)
hold on
semilogy(inputs,abs(netI2),'r','DisplayName','Neural Net Model')
legend()
grid on;
title('Diode Current with Error')
xlabel('Voltage (V)')
ylabel('Current (A)')