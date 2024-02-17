restoredefaultpath; clear all; close all; clc;

%% Load path of the workspace
addpath(genpath('.'));

%% Load vehicle and command parameters
veh_model = loadjson('Conf/AUVParameters.json');
command_parameters = loadjson('Conf/PilotParameters.json');

%% Simulation parameters
SimuParameters.beginning_time_s = 0.0;
SimuParameters.sample_time_s = 0.1;
SimuParameters.simulation_time_s = 870;

%% Initialisation of state and simulink bus
% If you want, you can modify the initial states
[initial_state,initial_actuators] = SetInitialState();

% Do not touch
CreateSimulinkBus;
%% Load inputs
% You have 4 examples but you can create your own without any problem
inputs = SetInputs_FinalSimulation(SimuParameters.sample_time_s,SimuParameters.simulation_time_s);

%% Apply noise on vehicle state
% You are in simple mode, here all must be 'off'
noise = ApplyNoise(SimuParameters.sample_time_s);

%% Run the simulink
close all;
sim('MIR_AUVSimulator_R2021b');clear tout;

%% Plots the results
PlotMIRSimulation;