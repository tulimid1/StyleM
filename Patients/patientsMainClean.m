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
ageYears = Age;
diastolicMmHg = Diastolic;
sex = Gender;
heightCm = Height;
lastName = LastName;
location = Location;
selfAssessedHealth = SelfAssessedHealthStatus;
isSmoker = Smoker;
systolicMmHg = Systolic;
weightLb = Weight; 
clearvars('Age', 'Diastolic', 'Gender', 'Height', 'LastName', 'Location', ...
    'SelfAssessedHealthStatus', 'Smoker', 'Systolic', 'Weight');

%% Analyze  

weightKg = convertLb2Kg(weightLb); 
clearvars('weightLbs')
isMale = strcmpi(sex, 'Male');
isFemale = strcmpi(sex, 'Female'); 

%% Statistics 

[~, pValueAge] = ttest2(ageYears(isSmoker), ageYears(~isSmoker));
[~, pValueDiastolic] = ttest2(diastolicMmHg(isSmoker), diastolicMmHg(~isSmoker));
[~, pValueSystolic] = ttest2(systolicMmHg(isSmoker), systolicMmHg(~isSmoker));
[~, pValueHeight] = ttest2(heightCm(isSmoker), heightCm(~isSmoker));
[~, pValueWeight] = ttest2(weightKg(isSmoker), weightKg(~isSmoker));

%% Visualize 

% Age 
figure();
boxchartData(1, ageYears(isSmoker & isMale), ageYears(isSmoker & isFemale));
boxchartData(2, ageYears(~isSmoker & isMale), ageYears(~isSmoker & isFemale));
legendMalesFemales(); 
axis('padded')
xticks(1:2);
xticklabels({'Smoker', 'Non-Smoker'});
ylabel('Age (years)'); 
title(sprintf('Two-sided independent samples t-test\np = %.2f', pValueAge));

% Diastolic 
figure();
boxchartData(1, diastolicMmHg(isSmoker & isMale), diastolicMmHg(isSmoker & isFemale));
boxchartData(2, diastolicMmHg(~isSmoker & isMale), diastolicMmHg(~isSmoker & isFemale));
legendMalesFemales(); 
axis('padded')
xticks(1:2);
xticklabels({'Smoker', 'Non-Smoker'});
ylabel('Diastolic BP (mm Hg)'); 
title(sprintf('Two-sided independent samples t-test\np = %.2f', pValueDiastolic));

% Systolic 
figure();
boxchartData(1, systolicMmHg(isSmoker & isMale), systolicMmHg(isSmoker & isFemale));
boxchartData(2, systolicMmHg(~isSmoker & isMale), systolicMmHg(~isSmoker & isFemale));
legendMalesFemales(); 
axis('padded')
xticks(1:2);
xticklabels({'Smoker', 'Non-Smoker'});
ylabel('Systolic BP (mm Hg)'); 
title(sprintf('Two-sided independent samples t-test\np = %.2f', pValueSystolic));

% Height 
figure();
boxchartData(1, heightCm(isSmoker & isMale), heightCm(isSmoker & isFemale));
boxchartData(2, heightCm(~isSmoker & isMale), heightCm(~isSmoker & isFemale));
legendMalesFemales(); 
axis('padded')
xticks(1:2);
xticklabels({'Smoker', 'Non-Smoker'});
ylabel('Height (cm)'); 
title(sprintf('Two-sided independent samples t-test\np = %.2f', pValueHeight))

% Weight 
figure();
boxchartData(1, weightKg(isSmoker & isMale), weightKg(isSmoker & isFemale));
boxchartData(2, weightKg(~isSmoker & isMale), weightKg(~isSmoker & isFemale));
legendMalesFemales(); 
axis('padded')
xticks(1:2);
xticklabels({'Smoker', 'Non-Smoker'});
ylabel('Weight (kg)'); 
title(sprintf('Two-sided independent samples t-test\np = %.2f', pValueWeight))


%% Local functions

function legendMalesFemales(ax, maleMarkers, femaleMarkers, defaultRGB)
arguments (Input)
    ax (1, 1) matlab.graphics.axis.Axes = gca(); 
    maleMarkers (1, 1) string = '.';
    femaleMarkers (1, 1) string = 'x'; 
    defaultRGB (1, 3) double = [0 0 0]; 
end
males = plot(ax, ...
    nan, nan, ...
    'Marker', maleMarkers, ...
    'color', defaultRGB, ...
    'LineStyle', 'none', ...
    'DisplayName', 'Male'); 
females = plot(ax, ...
    nan, nan, ...
    'Marker', femaleMarkers, ...
    'color', defaultRGB, ...
    'LineStyle', 'none', ...
    'DisplayName', 'Female'); 
legend([males, females], 'location', 'best'); 
end

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

function kgs = convertLb2Kg(lbs)
arguments (Input)
    lbs (:, 1) double {mustBePositive}; 
end
arguments (Output)
    kgs (:, 1) double {mustBePositive}; 
end
kgs = lbs .* 0.45359237;
end

