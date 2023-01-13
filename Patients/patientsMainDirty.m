%% Main 

clear;
clc;
close all; 

codeFolder = ...
    ['/Users/duncan/OneDrive - University of Delaware - o365/Documents/' ...
     'ReproRehab/2022/TA Project/StyleM/Patients'];
cd(codeFolder); 

%% Load  
load('patients.mat');
blood_pressure=struct('blood_pressure_diastolic', Diastolic, 'blood_pressure_systolic', Systolic); 

%% Analyze  

wght = Weight.*.45359237; 
for i = 1:length(Gender)
    notMale=strcmpi(Gender(i),'Female');
    notFemale=strcmpi(Gender(i),'Male'); 
    if notMale
        is_male(i) =false; is_female(i) = true;
    elseif notFemale
        is_female(i) = false; is_male(i)=true;
    end
end

%% Statistics 

p_sig_thresh = 0.05; 
[~, pValueAge] =ttest2(Age(Smoker), Age(~Smoker));
[~,pValueDiastolic]= ttest2(blood_pressure.blood_pressure_diastolic(Smoker), blood_pressure.blood_pressure_diastolic(~Smoker));
[~, pValueSystolic]= ttest2(blood_pressure.blood_pressure_systolic(Smoker), blood_pressure.blood_pressure_systolic(~Smoker));
[~,pValueHeight] =ttest2(Height(Smoker), Height(~Smoker));
[~,   pValueWeight] =ttest2(wght(Smoker), wght(~Smoker));

%% Visualize 

maleMarkers = '.';
female_markers = 'x'; 
defaultRGB = 'k';

% Age 
fig = figure();
boxchartData(1, Age(Smoker & is_male'), Age(Smoker & is_female'));
boxchartData(2, Age(~Smoker & is_male'), Age(~Smoker & is_female'));
males = plot(nan, nan, ...
    'Marker', maleMarkers, ...
    'color', defaultRGB, ...
    'LineStyle', 'none', ...
    'DisplayName', 'Male'); 
females = plot(nan, nan, ...
    'Marker', female_markers, ...
    'color', defaultRGB, ...
    'LineStyle', 'none', ...
    'DisplayName', 'Female'); 
legend([males, females], 'location', 'best'); 
axis('padded')
xticks(1:2);
xticklabels({'Smoker', 'Non-Smoker'});
ylabel('Age'); 
if pValueAge > p_sig_thresh
    title(sprintf('Two-sided independent samples t-test not surprising\np = %.2f', pValueAge));
else
    title(sprintf('Two-sided independent samples t-test surprising\np = %.2f', pValueAge));
end

%Diastolic 
fig = figure();
boxchartData(1,blood_pressure.blood_pressure_diastolic(Smoker & is_male'), blood_pressure.blood_pressure_diastolic(Smoker & is_female'));
boxchartData(2, blood_pressure.blood_pressure_diastolic(~Smoker & is_male'),blood_pressure.blood_pressure_diastolic(~Smoker & is_female'));
males = plot(nan, nan, ...
    'Marker', maleMarkers, ...
    'color', defaultRGB, ...
    'LineStyle', 'none', ...
    'DisplayName', 'Male'); 
females = plot(nan, nan, ...
    'Marker', female_markers, ...
    'color', defaultRGB, ...
    'LineStyle', 'none', ...
    'DisplayName', 'Female'); 
legend([males, females], 'location', 'best'); 
axis('padded')
xticks(1:2);
xticklabels({'Smoker', 'Non-Smoker'});
ylabel('Diastolic BP'); 
if pValueDiastolic > p_sig_thresh
    title(sprintf('Two-sided independent samples t-test not surprising\np = %.2f',pValueDiastolic));
else
    title(sprintf('Two-sided independent samples t-test surprising\np = %.2f',pValueDiastolic));
end
%Systolic 
fig = figure();
boxchartData(1, blood_pressure.blood_pressure_systolic(Smoker & is_male'), blood_pressure.blood_pressure_systolic(Smoker & is_female'));
boxchartData(2, blood_pressure.blood_pressure_systolic(~Smoker & is_male'),blood_pressure.blood_pressure_systolic(~Smoker & is_female'));
males = plot(nan, nan, ...
    'Marker', maleMarkers, ...
    'color', defaultRGB, ...
    'LineStyle', 'none', ...
    'DisplayName', 'Male'); 
females = plot(nan, nan, ...
    'Marker', female_markers, ...
    'color', defaultRGB, ...
    'LineStyle', 'none', ...
    'DisplayName', 'Female'); 
legend([males, females], 'location', 'best'); 
axis('padded')
xticks(1:2);
xticklabels({'Smoker', 'Non-Smoker'});
ylabel('Systolic BP'); 
if pValueSystolic > p_sig_thresh
    title(sprintf('Two-sided independent samples t-test not surprising\np = %.2f',pValueSystolic));
else
    title(sprintf('Two-sided independent samples t-test surprising\np = %.2f',pValueSystolic));
end
% Height 
fig = figure();
boxchartData(1, Height(Smoker & is_male'), Height(Smoker &is_female'));
boxchartData(2, Height(~Smoker &is_male'), Height(~Smoker & is_female'));
males = plot(nan, nan, ...
    'Marker', maleMarkers, ...
    'color', defaultRGB, ...
    'LineStyle', 'none', ...
    'DisplayName', 'Male'); 
females = plot(nan, nan, ...
    'Marker', female_markers, ...
    'color', defaultRGB, ...
    'LineStyle', 'none', ...
    'DisplayName', 'Female'); 
legend([males, females], 'location', 'best'); 
axis('padded')
xticks(1:2);
xticklabels({'Smoker','Non-Smoker'});
ylabel('Height'); 
if pValueHeight >p_sig_thresh
    title(sprintf('Two-sided independent samples t-test not surprising\np = %.2f', pValueHeight));
else
    title(sprintf('Two-sided independent samples t-test surprising\np = %.2f', pValueHeight));
end
%Weight 
fig = figure();
boxchartData(1, wght(Smoker & is_male'), wght(Smoker & is_female'));
boxchartData(2,wght(~Smoker & is_male'), wght(~Smoker & is_female'));
males = plot(nan, nan, ...
    'Marker', maleMarkers, ...
    'color', defaultRGB, ...
    'LineStyle', 'none', ...
    'DisplayName', 'Male'); 
females = plot(nan, nan, ...
    'Marker', female_markers, ...
    'color', defaultRGB, ...
    'LineStyle', 'none', ...
    'DisplayName', 'Female'); 
legend([males, females], 'location', 'best'); 
axis('padded')
xticks(1:2);
xticklabels({'Smoker','Non-Smoker'});
ylabel('Weight'); 
if pValueWeight >p_sig_thresh
    title(sprintf('Two-sided independent samples t-test not surprising\np = %.2f', pValueWeight));
else
    title(sprintf('Two-sided independent samples t-test surprising\np = %.2f', pValueWeight));
end

%% Local functions

function boxchartData(x, yMale, yFemale)
arguments (Input)
    x (1, 1) double;
    yMale (:, 1) double;
    yFemale (:, 1) double;
end

nMales = length(yMale);
nFemales = length(yFemale); 
nSamples = nMales + nFemales; 
bc = boxchart(repelem(x, nSamples), [yMale; yFemale]);
hold('on');
jitterMales = unifrnd(x - bc.BoxWidth/2, x + bc.BoxWidth/2, [nMales 1]);
plot(jitterMales, yMale, ...
    'marker', '.', ...
    'LineStyle', 'none', ...
    'color', bc.BoxFaceColor); 
jitterFemales = unifrnd(x - bc.BoxWidth/2, x + bc.BoxWidth/2, [nFemales 1]);
plot(jitterFemales, yFemale, ...
    'marker', 'x', ...
    'markersize', 12, ...
    'LineStyle', 'none', ...
    'color', bc.BoxFaceColor); 

end

