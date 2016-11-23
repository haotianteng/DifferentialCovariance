RootFolderPath = 'C:\UQ\GoodhillIntern\SAResearch\CorrCode\';
FishName = '20150804-f3';
Fish = load([RootFolderPath,'Data\SA\',FishName,'\processed\',FishName,'-actProps.mat']);
Fish = Fish.actProps;
NeuronIndex = 10;
RasterTraces = Fish.rasterAlltrials;
addpath('C:\UQ\GoodhillIntern\DifferentialCovariance\APreconstruct\oopsi');


% set simulation metadata
V.dt    = 1/2;  % time step size

% initialize params
P.a     = 1;    % observation scale
P.b     = 0;    % observation bias
tau     = 1.5;    % decay time constant
P.gam   = 1-V.dt/tau; % C(t) = gam*C(t-1)
P.lam   = 0.1;  % firing rate = lam/dt
P.sig   = 0.1;  % standard deviation of observation noise 

F = RasterTraces(NeuronIndex,:)';
[Nhat Phat] = fast_oopsi(F,V,P);
[M P V] = smc_oopsi(F,V,P);

figure(1);
h(1)=subplot(311); plot(tvec,F); axis('tight'), ylabel('F (au)')
% h(2)=subplot(312); stem(tvec,N); hold on, plot(tvec,Nhat,'r','linewidth',1), axis('tight'), ylabel('fast')
Nsmc = M.nbar/max(M.nbar);
Nsmc(Nsmc<0.1)=0;
h(3)=subplot(313); stem(tvec,N); hold on, plot(tvec,Nsmc,'k','linewidth',2); axis('tight'), ylabel('smc')

% figure;
% RasterTraces = Fish.rasterAlltrials;
% [ImageStack,Map] = trace2movie(RasterTraces);
% Mov = immovie(ImageStack,Map);
% implay(Mov);

