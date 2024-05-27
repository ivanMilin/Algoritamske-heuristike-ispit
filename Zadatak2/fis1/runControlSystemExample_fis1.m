%  IT2-FLS Toolbox is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     IT2-FLS Toolbox is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with IT2-FLS Toolbox.  If not, see <http://www.gnu.org/licenses/>.
%% Simulation parameters
Ke=40;
Kd=0.05/6;
Ka=0.002/6;
Kb=11.5/6;
SamplingTime=0.45;

%% System parameters
K=14;
T=0.0001*4;
L=0.001/4;

open_system('IT1_FPID_Controller.slx')
T1Controller=find_system('IT1_FPID_Controller','name',...
    'Interval Type-1 Fuzzy PID');
T1Controller=[T1Controller{1} '/Fuzzy Logic Controller'];


%% TR Method -> KM
sim('IT1_FPID_Controller.slx');
y_KM=y.signals.values;
u_KM=u.signals.values;

%% Reference and time arrays
ref=ref.signals.values;
time=y.time;

%% Plot figures
figure;
plot(time,ref,time,y_KM);
legend('Reference','IT 1-FPID');
ylim([min([min(ref) min(y_KM)]), max([max(ref) max(y_KM)]) + 0.2]);

figure;
plot(time,u_KM);