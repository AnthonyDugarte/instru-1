clear all;


global vcDB vcAng icDB icAng;

data;

%% VC

VC = tf([0.0067 509],[1.139e-8 0.0082653 1209]);

[mag, phase, wout] = bode(VC);

mag = squeeze(mag);
phase = squeeze(phase);

fout = wout/(2*pi);
dbout = 20*log10(mag);

f = figure(1);

subplot(2,1,1);
semilogx(fout, dbout); hold on
semilogx(vcDB(:,1), vcDB(:,2)); hold off

grid minor;

ylabel("Magnitude (dB)")
legend({'Model','Measured'})

subplot(2,1,2);
semilogx(fout, phase); hold on
semilogx(vcAng(:,1), vcAng(:,2)); hold off

grid minor;

ylabel("Phase (deg)")
legend({'Model','Measured'})

han=axes(f,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
xlabel(han,'Frequency (Hz)');
title(han, "Bode Diagram (VC)")


%% IL

IL = tf([0.000001 1],[1.139e-8 0.0082653 1209]);

[mag, phase, wout] = bode(IL);

mag = squeeze(mag);
phase = squeeze(phase);

fout = wout/(2*pi);
dbout = 20*log10(mag);

f = figure(2);

subplot(2,1,1);
semilogx(fout, dbout); hold on
semilogx(icDB(:,1), icDB(:,2)); hold off

grid minor;

ylabel("Magnitude (dB)")
legend({'Model','Measured'})

subplot(2,1,2);
semilogx(fout, phase); hold on
semilogx(icAng(:,1), icAng(:,2)); hold off

grid minor;

ylabel("Phase (deg)")
legend({'Model','Measured'})

han=axes(f,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
xlabel(han,'Frequency (Hz)');
title(han, "Bode Diagram (IC)")