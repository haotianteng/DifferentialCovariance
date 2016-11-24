clc; clear all;
RootFolderPath = 'C:\UQ\GoodhillIntern\SAResearch\CorrCode\';
FishName = '20150804-f3';
Fish = load([RootFolderPath,'Data\SA\',FishName,'\processed\',FishName,'-actProps.mat']);
Fish = Fish.actProps;
NeuronIndex = 10;
RasterTraces = Fish.rasterAlltrials;
addpath('C:\UQ\GoodhillIntern\DifferentialCovariance\APreconstruct\oopsi');

F = RasterTraces(NeuronIndex,500:1000)';
% set simulation metadata
V.dt    = 1/2;  % time step size
T = size(F,1);
NeuronNum = size(RasterTraces,1);

% initialize params
P.a     = 1;    % observation scale
P.b     = 0;    % observation bias
tau     = 2;    % decay time constant
P.gam   = 1-V.dt/tau; % C(t) = gam*C(t-1)
P.lam   = 0.1;  % firing rate = lam/dt
P.sig   = 0.2;  % standard deviation of observation noise 


[Nhat Phat] = fast_oopsi(F,V,P);
% Nhat(Nhat<0.6) = 0;


% V.smc_iter_max = 1;
% [M P V] = smc_oopsi(F,V,P);
% tvec=0:V.dt:(T-1)*V.dt;

% figure(1);
% h(1)=subplot(211); plot(tvec,F); axis('tight'), ylabel('F (au)')
% h(2)=subplot(212); plot(tvec,Nhat,'r','linewidth',1), axis('tight'), ylabel('fast')

% Nsmc = M.nbar/max(M.nbar);
% Nsmc(Nsmc<0.1)=0;
% h(3)=subplot(313); stem(tvec,N); hold on, plot(tvec,Nsmc,'k','linewidth',2); axis('tight'), ylabel('smc')

% figure;
% RasterTraces = Fish.rasterAlltrials;
% [ImageStack,Map] = trace2movie(RasterTraces);
% Mov = immovie(ImageStack,Map);
% implay(Mov);

SpikeMatrix = zeros(size(RasterTraces));
fprintf('Reconstructed            ');
for NeuronIndex = 1:NeuronNum

    CurrentSpikeTrail = fast_oopsi(RasterTraces(NeuronIndex,:),V,P);
    SpikeMatrix(NeuronIndex,:) = CurrentSpikeTrail;
    
    IndexPrint = num2str(NeuronIndex);
    backSpace = length(IndexPrint);
    for i = 1:backSpace+8
        fprintf('\b');
    end
    fprintf('%d',NeuronIndex);
    fprintf(' trails.');

end
fprintf('\n');


