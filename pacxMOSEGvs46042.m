% pacxMOSEGvs46042.m
% scrpit to coompare wave measuremetns from 46042 and PacX vehicles
% PacX Vehicles were in the vicinity of the MB moorings from 11/23/11 at 7:00 AM to 12/9/11 at 6:00 AM


 str = urlread('http://www.ndbc.noaa.gov/data/realtime2/46236.spec');
 i4header = findstr('degT',str);
 str = str(i4header(2)+4:end);
% 
 str = strrep(str,' N ',' 0 ');
 str = strrep(str,' NNW ',' 337.5 ');
 str = strrep(str,' NW ',' 315 ');
 str = strrep(str,' WNW ',' 292.5 ');
 str = strrep(str,' W ',' 270 ');
 str = strrep(str,' WSW ',' 247.5 ');
 str = strrep(str,' SW ',' 225 ');
 str = strrep(str,' SSW ',' 202.5 ');
 str = strrep(str,' S ',' 180 ');
 str = strrep(str,' SSE ',' 157.5 ');
 str = strrep(str,' SE ',' 135 ');
 str = strrep(str,' ESE ',' 112.5 ');
 str = strrep(str,' E ',' 90 ');
 str = strrep(str,' ENE ',' 67.5 ');
 str = strrep(str,' NE ',' 45 ');
 str = strrep(str,' NNE ',' 22.5 ');
% 
 str = strrep(str,' AVERAGE ',' 0 ');
 str = strrep(str,' SWELL ',' 1 ');
 str = strrep(str,' STEEP ',' 2 ');
 str = strrep(str,' VERY_STEEP ',' 3 ');
 str = strrep(str,' N/A ',' NaN ');
% 
 data = str2num(str);
 year = data(:,1);
 month = data(:,2);
 day = data(:,3);
 hour = data(:,4);
 minute = data(:,5);
% 
 time4wavedata = datenum(year,month,day,hour,minute,0);
 wave_height = data(:,6);
 swell_height = data(:,7);
 swell_period = data(:,8);
 windwave_height = data(:,9);
 windwave_period = data(:,10);
 swell_dir = data(:,11);
 windwave_dir = data(:,12);
 steep = data(:,13);
 average_period = data(:,14);
 meanwavedirection = data(:,15);



% read data from CDIP historical files for 46236
nov2011data = load('C:/a_data/pac_crossing/mooring_46236/nov2011_46236.txt');
dec2011data = load('C:/a_data/pac_crossing/mooring_46236/dec2011_46236.txt');
jan2012data = load('C:/a_data/pac_crossing/mooring_46236/jan2012_46236.txt');

wavdata = [nov2011data;dec2011data;jan2012data];
year = wavdata(:,1);
month = wavdata(:,2);
day = wavdata(:,3);
hour = wavdata(:,4);
minute = wavdata(:,5);
wav_height = wavdata(:,6);
wav_per = wavdata(:,7);
wav_dir = wavdata(:,8);
wav_aper = wavdata(:,9);
wav_time = datenum(year,month,day,hour,minute,0);
% average 46236 wav data to one hour intervals


timevec_wav = datevec(wav_time);
hourL = datenum(2011,11,23,7,0,0);
count = 1;
while hourL < datenum(2011,12,9,6,0,0)
  timeL = datevec(hourL);
  i = find(timevec_wav(:,1) == timeL(1) & timevec_wav(:,2) == timeL(2) & timevec_wav(:,3) == timeL(3) & timevec_wav(:,4) == timeL(4));
  wavheightM(count) = mean(wav_height(i));
  wavdirM(count) = mean(wav_dir(i));
  wavperM(count) = mean(wav_per(i));
  wavaperM(count) = mean(wav_aper(i));
  wavtimeM(count) = hourL;
  hourL = hourL + 1.00000001/24;
  count = count + 1;
end


datstruct = load(urlwrite('http://data.liquidr.com/erddap/tabledap/DatawellMOSEPapaMau.mat?latitude,longitude,time,id,Hs,Tav,Tp,Dirp&time>=2011-11-18&time<=2012-01-09','test.mat'));
tvec = sec_date(datstruct.DatawellMOSEPapaMau.time);
timevec_papa = datenum(tvec(:,1),tvec(:,2),tvec(:,3),tvec(:,4),tvec(:,5),tvec(:,6));
wv_ht_papa = datstruct.DatawellMOSEPapaMau.Hs;
wv_ap_papa = datstruct.DatawellMOSEPapaMau.Tav;
wv_dp_papa = datstruct.DatawellMOSEPapaMau.Tp;
wv_dir_papa = datstruct.DatawellMOSEPapaMau.Dirp;

clear tvec
datstruct = load(urlwrite('http://data.liquidr.com/erddap/tabledap/DatawellMOSEBenjamin.mat?latitude,longitude,time,id,Hs,Tav,Tp,Dirp&time>=2011-11-18&time<=2012-01-09','test.mat'));
tvec = sec_date(datstruct.DatawellMOSEBenjamin.time);
timevec_benj = datenum(tvec(:,1),tvec(:,2),tvec(:,3),tvec(:,4),tvec(:,5),tvec(:,6));
wv_ht_benj = datstruct.DatawellMOSEBenjamin.Hs;
wv_ap_benj = datstruct.DatawellMOSEBenjamin.Tav;
wv_dp_benj = datstruct.DatawellMOSEBenjamin.Tp;
wv_dir_benj = datstruct.DatawellMOSEBenjamin.Dirp;

clear tvec
datstruct = load(urlwrite('http://data.liquidr.com/erddap/tabledap/DatawellMOSEPiccardMaru.mat?latitude,longitude,time,id,Hs,Tav,Tp,Dirp&time>=2011-11-18&time<=2012-01-09','test.mat'));
tvec = sec_date(datstruct.DatawellMOSEPiccardMaru.time);
timevec_picc = datenum(tvec(:,1),tvec(:,2),tvec(:,3),tvec(:,4),tvec(:,5),tvec(:,6));
wv_ht_picc = datstruct.DatawellMOSEPiccardMaru.Hs;
wv_ap_picc = datstruct.DatawellMOSEPiccardMaru.Tav;
wv_dp_picc = datstruct.DatawellMOSEPiccardMaru.Tp;
wv_dir_picc = datstruct.DatawellMOSEPiccardMaru.Dirp;

clear tvec
datstruct = load(urlwrite('http://data.liquidr.com/erddap/tabledap/DatawellMOSEFontaineMaru.mat?latitude,longitude,time,id,Hs,Tav,Tp,Dirp&time>=2011-11-18&time<=2012-01-09','test.mat'));
tvec = sec_date(datstruct.DatawellMOSEFontaineMaru.time);
timevec_font = datenum(tvec(:,1),tvec(:,2),tvec(:,3),tvec(:,4),tvec(:,5),tvec(:,6));
wv_ht_font = datstruct.DatawellMOSEFontaineMaru.Hs;
wv_ap_font = datstruct.DatawellMOSEFontaineMaru.Tav;
wv_dp_font = datstruct.DatawellMOSEFontaineMaru.Tp;
wv_dir_font = datstruct.DatawellMOSEFontaineMaru.Dirp;


% average glider wave data to one hour intervals
time4papa = datevec(timevec_papa);
hourL = datenum(2011,11,23,7,0,0);
count = 1;
while hourL < datenum(2011,12,9,6,0,0)
  timeL = datevec(hourL);
  i = find(time4papa(:,1) == timeL(1) & time4papa(:,2) == timeL(2) & time4papa(:,3) == timeL(3) & time4papa(:,4) == timeL(4));
  papa_wavhtM(count) = nanmean(wv_ht_papa(i));
  papa_wavdirM(count) = nanmean(wv_dir_papa(i));
  papa_wavperM(count) = nanmean(wv_dp_papa(i));
  papa_wavaperM(count) = nanmean(wv_ap_papa(i));
  papa_timeM(count) = hourL;
  hourL = hourL + 1.00000001/24;
  count = count + 1;
end

time4benj = datevec(timevec_benj);
hourL = datenum(2011,11,23,7,0,0);
count = 1;
while hourL < datenum(2011,12,9,6,0,0)
  timeL = datevec(hourL);
  i = find(time4benj(:,1) == timeL(1) & time4benj(:,2) == timeL(2) & time4benj(:,3) == timeL(3) & time4benj(:,4) == timeL(4));
  benj_wavhtM(count) = nanmean(wv_ht_benj(i));
  benj_wavdirM(count) = nanmean(wv_dir_benj(i));
  benj_wavperM(count) = nanmean(wv_dp_benj(i));
  benj_wavaperM(count) = nanmean(wv_ap_benj(i));
  benj_timeM(count) = hourL;
  hourL = hourL + 1.00000001/24;
  count = count + 1;
end

time4picc = datevec(timevec_picc);
hourL = datenum(2011,11,23,7,0,0);
count = 1;
while hourL < datenum(2011,12,9,6,0,0)
  timeL = datevec(hourL);
  i = find(time4picc(:,1) == timeL(1) & time4picc(:,2) == timeL(2) & time4picc(:,3) == timeL(3) & time4picc(:,4) == timeL(4));
  picc_wavhtM(count) = nanmean(wv_ht_picc(i));
  picc_wavdirM(count) = nanmean(wv_dir_picc(i));
  picc_wavperM(count) = nanmean(wv_dp_picc(i));
  picc_wavaperM(count) = nanmean(wv_ap_picc(i));
  picc_timeM(count) = hourL;
  hourL = hourL + 1.00000001/24;
  count = count + 1;
end

time4font = datevec(timevec_font);
hourL = datenum(2011,11,23,7,0,0);
count = 1;
while hourL < datenum(2011,12,9,6,0,0)
  timeL = datevec(hourL);
  i = find(time4font(:,1) == timeL(1) & time4font(:,2) == timeL(2) & time4font(:,3) == timeL(3) & time4font(:,4) == timeL(4));
  font_wavhtM(count) = nanmean(wv_ht_font(i));
  font_wavdirM(count) = nanmean(wv_dir_font(i));
  font_wavperM(count) = nanmean(wv_dp_font(i));
  font_wavaperM(count) = nanmean(wv_ap_font(i));
  font_timeM(count) = hourL;
  hourL = hourL + 1.00000001/24;
  count = count + 1;
end

% calculate percent differences for Wave Height, Wave Direction, Wave Average Period, Wave Dominant Period
% Wave Height
difpcx14wvht = papa_wavhtM - wavheightM;
avepcx14wvht = (papa_wavhtM + wavheightM)/2;
pd4pcx1_wvht = abs(difpcx14wvht./avepcx14wvht) * 100;

difpcx24wvht = benj_wavhtM - wavheightM;
avepcx24wvht = (benj_wavhtM + wavheightM)/2;
pd4pcx2_wvht = abs(difpcx24wvht./avepcx24wvht) * 100;

difpcx34wvht = picc_wavhtM - wavheightM;
avepcx34wvht = (picc_wavhtM + wavheightM)/2;
pd4pcx3_wvht = abs(difpcx34wvht./avepcx34wvht) * 100;

difpcx44wvht = font_wavhtM - wavheightM;
avepcx44wvht = (font_wavhtM + wavheightM)/2;
pd4pcx4_wvht = abs(difpcx44wvht./avepcx44wvht) * 100;


% Wave Direction
difpcx14wvdir = papa_wavdirM - wavdirM;
avepcx14wvdir = (papa_wavdirM + wavdirM)/2;
pd4pcx1_wvdir = abs(difpcx14wvdir./avepcx14wvdir) * 100;

difpcx24wvdir = benj_wavdirM - wavdirM;
avepcx24wvdir = (benj_wavdirM + wavdirM)/2;
pd4pcx2_wvdir = abs(difpcx24wvdir./avepcx24wvdir) * 100;

difpcx34wvdir = picc_wavdirM - wavdirM;
avepcx34wvdir = (picc_wavdirM + wavdirM)/2;
pd4pcx3_wvdir = abs(difpcx34wvdir./avepcx34wvdir) * 100;

difpcx44wvdir = font_wavdirM - wavdirM;
avepcx44wvdir = (font_wavdirM + wavdirM)/2;
pd4pcx4_wvdir = abs(difpcx44wvdir./avepcx44wvdir) * 100;


% Wave Dominant Period
difpcx14wvper = papa_wavperM - wavperM;
avepcx14wvper = (papa_wavperM + wavperM)/2;
pd4pcx1_wvper = abs(difpcx14wvper./avepcx14wvper) * 100;

difpcx24wvper = benj_wavperM - wavperM;
avepcx24wvper = (benj_wavperM + wavperM)/2;
pd4pcx2_wvper = abs(difpcx24wvper./avepcx24wvper) * 100;

difpcx34wvper = picc_wavperM - wavperM;
avepcx34wvper = (picc_wavperM + wavperM)/2;
pd4pcx3_wvper = abs(difpcx34wvper./avepcx34wvper) * 100;

difpcx44wvper = font_wavperM - wavperM;
avepcx44wvper = (font_wavperM + wavperM)/2;
pd4pcx4_wvper = abs(difpcx44wvper./avepcx44wvper) * 100;


% Wave Average Period
difpcx14wvaper = papa_wavaperM - wavaperM;
avepcx14wvaper = (papa_wavaperM + wavaperM)/2;
pd4pcx1_wvaper = abs(difpcx14wvaper./avepcx14wvaper) * 100;

difpcx24wvaper = benj_wavaperM - wavaperM;
avepcx24wvaper = (benj_wavaperM + wavaperM)/2;
pd4pcx2_wvaper = abs(difpcx24wvaper./avepcx24wvaper) * 100;

difpcx34wvaper = picc_wavaperM - wavaperM;
avepcx34wvaper = (picc_wavaperM + wavaperM)/2;
pd4pcx3_wvaper = abs(difpcx34wvaper./avepcx34wvaper) * 100;

difpcx44wvaper = font_wavaperM - wavaperM;
avepcx44wvaper = (font_wavaperM + wavaperM)/2;
pd4pcx4_wvaper = abs(difpcx44wvaper./avepcx44wvaper) * 100;



 texty = [0 80];
 textx = [datenum(2011,12,7,0,0,0) datenum(2011,12,7,0,0,0)];
 figure(1)
 hold on
 plot(papa_timeM,pd4pcx1_wvht,'b.-')
 plot(benj_timeM,pd4pcx2_wvht,'g.-')
 plot(picc_timeM,pd4pcx3_wvht,'r.-')
 plot(font_timeM,pd4pcx4_wvht,'c.-')
 plot(wavtimeM,wavheightM,'k.-')
 tH = plot(textx,texty,'color',[1 203/255 0])
 ylim([0 80])
 set(tH,'linewidth',1.5)
 text(datenum(2011,12,7,0,0,0),60,'Hardware/Software Servicing')
 title('Percent Difference in Wave Height between PacX Gliders and NDBC 46236')
 xlabel('Date')
 ylabel('Percent Difference')
 datetick('x','mm/dd','keepticks','keeplimits')
 legend('Papa Mau','Benjamin','Piccard Maru','Fontaine Maru','location','NorthWest')
 print -dpng 'C:\a_data\pac_crossing\pd_pacxwavhtvs46236.png'
% 
% 
 texty = [0 200]
 textx = [datenum(2011,12,7,0,0,0) datenum(2011,12,7,0,0,0)]
 figure(2)
 hold on
 plot(papa_timeM,pd4pcx1_wvper,'b.-')
 plot(benj_timeM,pd4pcx2_wvper,'g.-')
 plot(picc_timeM,pd4pcx3_wvper,'r.-')
 plot(font_timeM,pd4pcx4_wvper,'c.-')
 tH = plot(textx,texty,'color',[1 203/255 0])
 ylim([0 160])
 set(tH,'linewidth',1.5)
 text(datenum(2011,12,7,0,0,0),120,'Hardware/Software Servicing')
 title('Percent Difference in Wave Dominant Period between PacX Gliders and NDBC 46236')
 xlabel('Date')
 ylabel('Percent Difference')
 datetick('x','mm/dd','keepticks','keeplimits')
 legend('Papa Mau','Benjamin','Piccard Maru','Fontaine Maru','location','NorthWest')
 %print -dpng 'C:\a_data\pac_crossing\pd_pacxwavpervs46236.png'


texty = [0 26];
textx = [datenum(2011,12,7,0,0,0) datenum(2011,12,7,0,0,0)]';
figure(1)
hold on
plot(papa_timeM,papa_wavperM,'b.-')
plot(benj_timeM,benj_wavperM,'g.-')
plot(picc_timeM,picc_wavperM,'r.-')
plot(font_timeM,font_wavperM,'c.-')
plot(wavtimeM,wavperM,'k.-')
ylim([0 26])
tH = plot(textx,texty,'color',[1 203/255 0])
set(tH,'linewidth',1.5)
text(datenum(2011,12,7,0,0,0),20,'Hardware/Software Servicing')
title('Wave Dominant Period between PacX Gliders and NDBC 46236')
xlabel('Date')
ylabel('Period(seconds)')
datetick('x','mm/dd','keepticks','keeplimits')
legend('Papa Mau','Benjamin','Piccard Maru','Fontaine Maru','Mooring','location','NorthWest')
return
print -dpng 'C:\a_data\pac_crossing\pacxwavpervs46236.png'


% %print -dpng 'C:\a_data\pac_crossing\pd_pacxwavdirvs46236.png'

texty = [0 400];
textx = [datenum(2011,12,7,0,0,0) datenum(2011,12,7,0,0,0)];
figure(1)
hold on
plot(papa_timeM,pd4pcx1_wvper,'b.-')
plot(benj_timeM,pd4pcx2_wvper,'g.-')
plot(picc_timeM,pd4pcx3_wvper,'r.-')
plot(font_timeM,pd4pcx4_wvper,'c.-')
%plot(wavtimeM,wavaperM,'k.-')
ylim([0 200])
tH = plot(textx,texty,'color',[1 203/255 0])
set(tH,'linewidth',1.5)
ylim([0 160])
text(datenum(2011,12,7,0,0,0),120,'Hardware/Software Servicing')
title('Percent Difference in Wave Dominant Period between PacX Gliders and NDBC 46236')
xlabel('Date')
ylabel('Percent Difference')
datetick('x','mm/dd','keepticks','keeplimits')
legend('Papa Mau','Benjamin','Piccard Maru','Fontaine Maru','location','NorthWest')
return
print -dpng 'C:\a_data\pac_crossing\pd_pacxwavpervs46236.png'

 figure(4)
 hold on
 plot(papa_timeM,papa_wavperM,'b.-')
 plot(benj_timeM,benj_wavperM,'g.-')
 plot(picc_timeM,picc_wavperM,'r.-')
 plot(font_timeM,font_wavperM,'c.-')
 plot(wavtimeM,wavperM,'k.-')
 title('Wave Period from PacX vehicles vs. NDBC 46236')
 xlabel('Date')
 ylabel('Period(seconds)')
 datetick('x','mm/dd','keepticks','keeplimits')
 legend('Papa Mau','Benjamin','Piccard Maru','Fontaine Maru','Mooring')
 print -dpng 'C:\a_data\pac_crossing\pacxwavpervs46236.png'

figure(3)
% 
 hold on
 plot(timevec_papa,wv_dir_papa,'b.-')
 plot(timevec_benj,wv_dir_benj,'g.-')
 plot(timevec_picc,wv_dir_picc,'r.-')
 plot(timevec_font,wv_dir_font,'c.-')
 plot(wavtimeM,wavdirM,'k.-')
 xlim([datenum(2011,11,23,0,0,0) datenum(2011,12,11,0,0,0)])
 title('Wave Direction from PacX Gliders and NDBC 46236')
 xlabel('Date')
 ylabel('Direction(degrees T)')
 datetick('x','mm/dd','keepticks','keeplimits')
 legend('Papa Mau','Benjamin','Piccard Maru','Fontaine Maru','Mooring')
 return
 print -dpng 'C:\a_data\pac_crossing\pacxwavpervs46236.png'


