close all; 
clear all; 
clc; 

D =cell2mat(struct2cell((load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\D_256_512_100_100_iterations.mat'))));
W = cell2mat(struct2cell((load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\W_256_512_100_100_iterations.mat'))));
