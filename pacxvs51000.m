% pacxvs51000.m
% script to plot CTD data from PacX vehicles during their stay at NDBC 51000



start = '2012-02-25 03:00:00';                                  % limit data to times when gliders are within 8km
stop = '2012-02-27 03:00:00';


%% Wave Glider CTD data from database
ctd_pcx1 = ctddo_getdata(start,stop,'380');
ctd_pcx2 = ctddo_getdata(start,stop,'381');
ctd_pcx3 = ctddo_getdata(start,stop,'382');
ctd_pcx4 = ctddo_getdata(start,stop,'383');


%pcx1_ctdtime = ctd_pcx1.absjday_float;
pcx2_ctdtime = ctd_pcx2.absjday_float;
pcx3_ctdtime = ctd_pcx3.absjday_float;
pcx4_ctdtime = ctd_pcx4.absjday_float;

%pcx1_pres = ctd_pcx1.pres4float;
pcx2_pres = ctd_pcx2.pres4float;
pcx3_pres = ctd_pcx3.pres4float;
pcx4_pres = ctd_pcx4.pres4float;

%pcx1_temp = ctd_pcx1.temp4float;
pcx2_temp = ctd_pcx2.temp4float;
pcx3_temp = ctd_pcx3.temp4float;
pcx4_temp = ctd_pcx4.temp4float;

%pcx1_con = ctd_pcx1.cond4float;
pcx2_con = ctd_pcx2.cond4float;
pcx3_con = ctd_pcx3.cond4float;
pcx4_con = ctd_pcx4.cond4float;

%pcx1_sal = ctd_pcx1.sal4float;
pcx2_sal = ctd_pcx2.sal4float;
pcx3_sal = ctd_pcx3.sal4float;
pcx4_sal = ctd_pcx4.sal4float;

%pcx1_do = ctd_pcx1.do4float;
pcx2_do = ctd_pcx2.do4float;
pcx3_do = ctd_pcx3.do4float;
pcx4_do = ctd_pcx4.do4float;

%pcx1_lat = ctd_pcx1.lat4float;
pcx2_lat = ctd_pcx2.lat4float;
pcx3_lat = ctd_pcx3.lat4float;
pcx4_lat = ctd_pcx4.lat4float;

%pcx1_lon = ctd_pcx1.lon4float;
pcx2_lon = ctd_pcx2.lon4float;
pcx3_lon = ctd_pcx3.lon4float;
pcx4_lon = ctd_pcx4.lon4float;

%pcx1_domLL = convertdo_pcx(pcx1_do,pcx1_temp,pcx1_pres,pcx1_sal,'0222');
pcx2_domLL = convertdo_pcx(pcx2_do,pcx2_temp,pcx2_pres,pcx2_sal,'0215');
pcx3_domLL = convertdo_pcx(pcx3_do,pcx3_temp,pcx3_pres,pcx3_sal,'0220');
pcx4_domLL = convertdo_pcx(pcx4_do,pcx4_temp,pcx4_pres,pcx4_sal,'0223');


% Calculate hourly averages of all data
count = 1;
hourL = datenum(2012,02,25,3,0,0);
%pcx1_timevec = datevec(pcx1_ctdtime);
pcx2_timevec = datevec(pcx2_ctdtime);
pcx3_timevec = datevec(pcx3_ctdtime);
pcx4_timevec = datevec(pcx4_ctdtime);
while hourL <= datenum(2012,2,27,3,0,0)
  timeL = datevec(hourL);
  
  i4pcx2 = find(pcx2_timevec(:,1) == timeL(1) & pcx2_timevec(:,2) == timeL(2) & pcx2_timevec(:,3) == timeL(3) & pcx2_timevec(:,4) == timeL(4));
  pcx2_tempM(count) = mean(pcx2_temp(i4pcx2));
  pcx2_salM(count) = mean(pcx2_sal(i4pcx2));
  pcx2_timeM(count) = hourL;

  i4pcx3 = find(pcx3_timevec(:,1) == timeL(1) & pcx3_timevec(:,2) == timeL(2) & pcx3_timevec(:,3) == timeL(3) & pcx3_timevec(:,4) == timeL(4));
  pcx3_tempM(count) = mean(pcx3_temp(i4pcx3));
  pcx3_salM(count) = mean(pcx3_sal(i4pcx3));
  pcx3_timeM(count) = hourL;

  i4pcx4 = find(pcx4_timevec(:,1) == timeL(1) & pcx4_timevec(:,2) == timeL(2) & pcx4_timevec(:,3) == timeL(3) & pcx4_timevec(:,4) == timeL(4));
  pcx4_tempM(count) = mean(pcx4_temp(i4pcx4));
  pcx4_salM(count) = mean(pcx4_sal(i4pcx4));
  pcx4_timeM(count) = hourL;
  
  hourL = hourL + 1.00000001/24;
  count = count + 1;
end

ws_pcx2 = bpws_getdata(start,stop,'Benjamin');
ws_pcx3 = bpws_getdata(start,stop,'Piccard Maru');
ws_pcx4 = bpws_getdata(start,stop,'Fontaine Maru');

pcx2_time = ws_pcx2.absjday;
pcx3_time = ws_pcx3.absjday;
pcx4_time = ws_pcx4.absjday;

pcx2_lat = ws_pcx2.lat;
pcx3_lat = ws_pcx3.lat;
pcx4_lat = ws_pcx4.lat;

pcx2_lon = ws_pcx2.lon;
pcx3_lon = ws_pcx3.lon;
pcx4_lon = ws_pcx4.lon;

pcx2_ws = ws_pcx2.ws;
pcx3_ws = ws_pcx3.ws;
pcx4_ws = ws_pcx4.ws;

pcx2_wd = ws_pcx2.wd;
pcx3_wd = ws_pcx3.wd;
pcx4_wd = ws_pcx4.wd;

pcx2_wg = ws_pcx2.wg;
pcx3_wg = ws_pcx3.wg;
pcx4_wg = ws_pcx4.wg;

pcx2_bp = ws_pcx2.bp;
pcx3_bp = ws_pcx3.bp;
pcx4_bp = ws_pcx4.bp;

pcx2_temp = ws_pcx2.temp;
pcx3_temp = ws_pcx3.temp;
pcx4_temp = ws_pcx4.temp;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% average metsys data to hour intervals
hourL = datenum(2012,02,25,3,0,0);
count = 1;
pcx2_timevec = datevec(pcx2_time);
pcx3_timevec = datevec(pcx3_time);
pcx4_timevec = datevec(pcx4_time);
while hourL <= datenum(2012,2,27,3,0,0)
  timeL = datevec(hourL);
  
  i4pcx2 = find(pcx2_timevec(:,1) == timeL(1) & pcx2_timevec(:,2) == timeL(2) & pcx2_timevec(:,3) == timeL(3) & pcx2_timevec(:,4) == timeL(4));
  pcx2_atempM(count) = mean(pcx2_temp(i4pcx2));
  pcx2_wsM(count) = mean(pcx2_ws(i4pcx2));
  pcx2_wdM(count) = mean(pcx2_wd(i4pcx2));
  pcx2_wgM(count) = mean(pcx2_wg(i4pcx2));
  pcx2_bpM(count) = mean(pcx2_bp(i4pcx2));
  pcx2_timeM(count) = hourL;
  
  i4pcx3 = find(pcx3_timevec(:,1) == timeL(1) & pcx3_timevec(:,2) == timeL(2) & pcx3_timevec(:,3) == timeL(3) & pcx3_timevec(:,4) == timeL(4));
  pcx3_atempM(count) = mean(pcx3_temp(i4pcx3));
  pcx3_wsM(count) = mean(pcx3_ws(i4pcx3));
  pcx3_wdM(count) = mean(pcx3_wd(i4pcx3));
  pcx3_wgM(count) = mean(pcx3_wg(i4pcx3));
  pcx3_bpM(count) = mean(pcx3_bp(i4pcx3));
  pcx3_timeM(count) = hourL;
  
  i4pcx4 = find(pcx4_timevec(:,1) == timeL(1) & pcx4_timevec(:,2) == timeL(2) & pcx4_timevec(:,3) == timeL(3) & pcx4_timevec(:,4) == timeL(4));
  pcx4_atempM(count) = mean(pcx4_temp(i4pcx4));
  pcx4_wsM(count) = mean(pcx4_ws(i4pcx4));
  pcx4_wdM(count) = mean(pcx4_wd(i4pcx4));
  pcx4_wgM(count) = mean(pcx4_wg(i4pcx4));
  pcx4_bpM(count) = mean(pcx4_bp(i4pcx4));
  pcx4_timeM(count) = hourL;

  hourL = hourL + 1.00000001/24;                               % need to increment hourL to avoid 60 second problem
  count = count + 1;
end

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Extract wave data from database
wavdat4papa = moseG_getdata(start,stop,'380');
wav_tim4papa = wavdat4papa.wave_time;
wav_dir4papa = wavdat4papa.wave_dir;
wav_aper4papa = wavdat4papa.per_ave;
wav_dper4papa = wavdat4papa.per_dom;
wav_hgt4papa = wavdat4papa.wave_height;

wavdat4benj = moseG_getdata(start,stop,'381');
wav_tim4benj = wavdat4benj.wave_time;
wav_dir4benj = wavdat4benj.wave_dir;
wav_aper4benj = wavdat4benj.per_ave;
wav_dper4benj = wavdat4benj.per_dom;
wav_hgt4benj = wavdat4benj.wave_height;

wavdat4font = moseG_getdata(start,stop,'382');
wav_tim4font = wavdat4font.wave_time;
wav_dir4font = wavdat4font.wave_dir;
wav_aper4font = wavdat4font.per_ave;
wav_dper4font = wavdat4font.per_dom;
wav_hgt4font = wavdat4font.wave_height;

wavdat4picc = moseG_getdata(start,stop,'383');
wav_tim4picc = wavdat4picc.wave_time;
wav_dir4picc = wavdat4picc.wave_dir;
wav_aper4picc = wavdat4picc.per_ave;
wav_dper4picc = wavdat4picc.per_dom;
wav_hgt4picc = wavdat4picc.wave_height;


% average glider wave data to one hour intervals
time4papa = datevec(wav_tim4papa);
hourL = datenum(2012,2,25,3,0,0);
count = 1;
while hourL <= datenum(2012,2,27,3,0,0)
  timeL = datevec(hourL);
  i = find(time4papa(:,1) == timeL(1) & time4papa(:,2) == timeL(2) & time4papa(:,3) == timeL(3) & time4papa(:,4) == timeL(4));
  papa_wavhtM(count) = nanmean(wav_hgt4papa(i));
  papa_wavdirM(count) = nanmean(wav_dir4papa(i));
  papa_wavperM(count) = nanmean(wav_dper4papa(i));
  papa_wavaperM(count) = nanmean(wav_aper4papa(i));
  papa_timeM(count) = hourL;
  hourL = hourL + 1.00000001/24;
  count = count + 1;
end

time4benj = datevec(wav_tim4benj);
hourL = datenum(2012,2,25,3,0,0);
count = 1;
while hourL <= datenum(2012,2,27,3,0,0)
  timeL = datevec(hourL);
  i = find(time4benj(:,1) == timeL(1) & time4benj(:,2) == timeL(2) & time4benj(:,3) == timeL(3) & time4benj(:,4) == timeL(4));
  benj_wavhtM(count) = nanmean(wav_hgt4benj(i));
  benj_wavdirM(count) = nanmean(wav_dir4benj(i));
  benj_wavperM(count) = nanmean(wav_dper4benj(i));
  benj_wavaperM(count) = nanmean(wav_aper4benj(i));
  benj_timeM(count) = hourL;
  hourL = hourL + 1.00000001/24;
  count = count + 1;
end

time4picc = datevec(wav_tim4picc);
hourL = datenum(2012,2,25,3,0,0);
count = 1;
while hourL <= datenum(2012,2,27,3,0,0)
  timeL = datevec(hourL);
  i = find(time4picc(:,1) == timeL(1) & time4picc(:,2) == timeL(2) & time4picc(:,3) == timeL(3) & time4picc(:,4) == timeL(4));
  picc_wavhtM(count) = nanmean(wav_hgt4picc(i));
  picc_wavdirM(count) = nanmean(wav_dir4picc(i));
  picc_wavperM(count) = nanmean(wav_dper4picc(i));
  picc_wavaperM(count) = nanmean(wav_aper4picc(i));
  picc_timeM(count) = hourL;
  hourL = hourL + 1.00000001/24;
  count = count + 1;
end

time4font = datevec(wav_tim4font);
hourL = datenum(2012,2,25,3,0,0);
count = 1;
while hourL <= datenum(2012,2,27,3,0,0)
  timeL = datevec(hourL);
  i = find(time4font(:,1) == timeL(1) & time4font(:,2) == timeL(2) & time4font(:,3) == timeL(3) & time4font(:,4) == timeL(4));
  font_wavhtM(count) = nanmean(wav_hgt4font(i));
  font_wavdirM(count) = nanmean(wav_dir4font(i));
  font_wavperM(count) = nanmean(wav_dper4font(i));
  font_wavaperM(count) = nanmean(wav_aper4font(i));
  font_timeM(count) = hourL;
  hourL = hourL + 1.00000001/24;
  count = count + 1;
end



%%%%%%%%%%%%%% Extract data from 51000 mooring text file
fid = fopen('C:\a_data\pac_crossing\mooring_51000\51000_5day.txt');
fgetl(fid);
fgetl(fid);
filestr = fread(fid,inf,'char');
filestr = char(filestr');
filestr = strrep(filestr,'MM','NaN');
data = str2num(filestr);
year = data(:,1);
month = data(:,2);
day = data(:,3);
hour = data(:,4);
minute = data(:,5);
wind_direction = data(:,6);
wind_speed = data(:,7);
wind_speed = wind_speed * 1.944;
wind_gust = data(:,8);
wind_gust = wind_gust * 1.944;
wave_height = data(:,9);
dper = data(:,10);
aper = data(:,11);
wavdir = data(:,12);
pressure = data(:,13);
atemp = data(:,14);
wtemp = data(:,15);
absjday_51000 = datenum(year,month,day,hour,minute,0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% interpolate buoy data to the sampling times of the Wave Gliders
% YI = INTERP1(X,Y,XI)
wspeed_int = interp1(absjday_51000,wind_speed,benj_timeM);
wgust_int = interp1(absjday_51000,wind_gust,benj_timeM);
wdir_int = interp1(absjday_51000,wind_direction,benj_timeM);
waveheight_int = interp1(absjday_51000,wave_height,benj_timeM);
wavedir_int = interp1(absjday_51000,wavdir,benj_timeM);
wavaper_int = interp1(absjday_51000,aper,benj_timeM);
wavdper_int = interp1(absjday_51000,dper,benj_timeM);
press_int = interp1(absjday_51000,pressure,benj_timeM);
atemp_int = interp1(absjday_51000,atemp,benj_timeM);
wtemp_int = interp1(absjday_51000,wtemp,benj_timeM);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Calculate percent difference in water temperature between vehicles and buoy 51000
difpcx24wtemp = pcx2_tempM - wtemp_int;
avepcx24wtemp = (pcx2_tempM + wtemp_int)/2;
pd4pcx2_wtemp = abs(difpcx24wtemp./avepcx24wtemp) * 100;

difpcx34wtemp = pcx3_tempM - wtemp_int;
avepcx34wtemp = (pcx3_tempM + wtemp_int)/2;
pd4pcx3_wtemp = abs(difpcx34wtemp./avepcx34wtemp) * 100;

difpcx44wtemp = pcx4_tempM - wtemp_int;
avepcx44wtemp = (pcx4_tempM + wtemp_int)/2;
pd4pcx4_wtemp = abs(difpcx44wtemp./avepcx44wtemp) * 100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Calculate percent difference in air temperature between vehicles and buoy 51000
difpcx24atemp = pcx2_atempM - atemp_int;
avepcx24atemp = (pcx2_atempM + atemp_int)/2;
pd4pcx2_atemp = abs(difpcx24atemp./avepcx24atemp) * 100;

difpcx34atemp = pcx3_atempM - atemp_int;
avepcx34atemp = (pcx3_atempM + atemp_int)/2;
pd4pcx3_atemp = abs(difpcx34atemp./avepcx34atemp) * 100;

difpcx44atemp = pcx4_atempM - atemp_int;
avepcx44atemp = (pcx4_atempM + atemp_int)/2;
pd4pcx4_atemp = abs(difpcx44atemp./avepcx44atemp) * 100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Calculate percent difference in barometric pressure between vehicles and buoy 51000
difpcx24press = pcx2_bpM - press_int;
avepcx24press = (pcx2_bpM + press_int)/2;
pd4pcx2_press = abs(difpcx24press./avepcx24press) * 100;

difpcx34press = pcx3_bpM - press_int;
avepcx34press = (pcx3_bpM + press_int)/2;
pd4pcx3_press = abs(difpcx34press./avepcx34press) * 100;

difpcx44press = pcx4_bpM - press_int;
avepcx44press = (pcx4_bpM + press_int)/2;
pd4pcx4_press = abs(difpcx44press./avepcx44press) * 100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Calculate percent difference in wind speed between vehicles and buoy 51000
difpcx24wspeed = pcx2_wsM - wspeed_int;
avepcx24wspeed = (pcx2_wsM + wspeed_int)/2;
pd4pcx2_wspeed = abs(difpcx24wspeed./avepcx24wspeed) * 100;

difpcx34wspeed = pcx3_wsM - wspeed_int;
avepcx34wspeed = (pcx3_wsM + wspeed_int)/2;
pd4pcx3_wspeed = abs(difpcx34wspeed./avepcx34wspeed) * 100;

difpcx44wspeed = pcx4_wsM - wspeed_int;
avepcx44wspeed = (pcx4_wsM + wspeed_int)/2;
pd4pcx4_wspeed = abs(difpcx44wspeed./avepcx44wspeed) * 100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Calculate percent difference in wind direction between vehicles and buoy 51000
% difpcx24wdir = pcx2_wdM - wdir_int;
% avepcx24wdir = (pcx2_wdM + wdir_int)/2;
% pd4pcx2_wdir = abs(difpcx24wdir./avepcx24wdir) * 100;
% 
% difpcx34wdir = pcx3_wdM - wdir_int;
% avepcx34wdir = (pcx3_wdM + wdir_int)/2;
% pd4pcx3_wdir = abs(difpcx34wdir./avepcx34wdir) * 100;
% 
% difpcx44wdir = pcx4_wdM - wdir_int;
% avepcx44wdir = (pcx4_wdM + wdir_int)/2;
% pd4pcx4_wdir = abs(difpcx44wdir./avepcx44wdir) * 100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Calculate an absolute difference in degrees as an indication of wind direction agreement
for j = 1:length(pcx2_wdM)
  absdifpcx2_wdir(j) = absdiff_dir(pcx2_wdM(j),wdir_int(j));
end
for j = 1:length(pcx3_wdM)
  absdifpcx3_wdir(j) = absdiff_dir(pcx3_wdM(j),wdir_int(j));
end
for j = 1:length(pcx4_wdM)
  absdifpcx4_wdir(j) = absdiff_dir(pcx4_wdM(j),wdir_int(j));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Calculate percent difference in wind gust between vehicles and buoy 51000
difpcx24wgust = pcx2_wgM - wgust_int;
avepcx24wgust = (pcx2_wgM + wgust_int)/2;
pd4pcx2_wgust = abs(difpcx24wgust./avepcx24wgust) * 100;

difpcx34wgust = pcx3_wgM - wgust_int;
avepcx34wgust = (pcx3_wgM + wgust_int)/2;
pd4pcx3_wgust = abs(difpcx34wgust./avepcx34wgust) * 100;

difpcx44wgust = pcx4_wgM - wgust_int;
avepcx44wgust = (pcx4_wgM + wgust_int)/2;
pd4pcx4_wgust = abs(difpcx44wgust./avepcx44wgust) * 100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Calculate percent difference in wave height between vehicles and buoy 51000
difpcx24wavht = benj_wavhtM - waveheight_int;
avepcx24wavht = (benj_wavhtM + waveheight_int)/2;
pd4pcx2_wavht = abs(difpcx24wavht./avepcx24wavht) * 100;

difpcx34wavht = picc_wavhtM - waveheight_int;
avepcx34wavht = (picc_wavhtM + waveheight_int)/2;
pd4pcx3_wavht = abs(difpcx34wavht./avepcx34wavht) * 100;

difpcx44wavht = font_wavhtM - waveheight_int;
avepcx44wavht = (font_wavhtM + wgust_int)/2;
pd4pcx4_wavht = abs(difpcx44wavht./avepcx44wavht) * 100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Calculate percent difference in wave direction between vehicles and buoy 51000
% difpcx24wavdir = benj_wavdirM - wavedir_int;
% avepcx24wavdir = (benj_wavdirM + wavedir_int)/2;
% pd4pcx2_wavdir = abs(difpcx24wavdir./avepcx24wavdir) * 100;
% 
% difpcx34wavdir = picc_wavdirM - wavedir_int;
% avepcx34wavdir = (picc_wavdirM + wavedir_int)/2;
% pd4pcx3_wavdir = abs(difpcx34wavdir./avepcx34wavdir) * 100;
% 
% difpcx44wavdir = font_wavdirM - wavedir_int;
% avepcx44wavdir = (font_wavdirM + wavedir_int)/2;
% pd4pcx4_wavdir = abs(difpcx44wavdir./avepcx44wavdir) * 100;
for j = 1:length(benj_wavdirM)
  absdifpcx2_wavdir(j) = absdiff_dir(benj_wavdirM(j),wavedir_int(j));
end
for j = 1:length(picc_wavdirM)
  absdifpcx3_wavdir(j) = absdiff_dir(picc_wavdirM(j),wavedir_int(j));
end
for j = 1:length(font_wavdirM)
  absdifpcx4_wavdir(j) = absdiff_dir(font_wavdirM(j),wavedir_int(j));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Calculate percent difference in wave average period between vehicles and buoy 51000
difpcx24wavaper = benj_wavaperM - wavaper_int;
avepcx24wavaper = (benj_wavaperM + wavaper_int)/2;
pd4pcx2_wavaper = abs(difpcx24wavaper./avepcx24wavaper) * 100;

difpcx34wavaper = picc_wavaperM - wavaper_int;
avepcx34wavaper = (picc_wavaperM + wavaper_int)/2;
pd4pcx3_wavaper = abs(difpcx34wavaper./avepcx34wavaper) * 100;

difpcx44wavaper = font_wavaperM - wavaper_int;
avepcx44wavaper = (font_wavaperM + wavaper_int)/2;
pd4pcx4_wavaper = abs(difpcx44wavaper./avepcx44wavaper) * 100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Calculate percent difference in wave dominant period between vehicles and buoy 51000
difpcx24wavdper = benj_wavperM - wavdper_int;
avepcx24wavdper = (benj_wavperM + wavdper_int)/2;
pd4pcx2_wavdper = abs(difpcx24wavdper./avepcx24wavdper) * 100;

difpcx34wavdper = picc_wavperM - wavdper_int;
avepcx34wavdper = (picc_wavperM + wavdper_int)/2;
pd4pcx3_wavdper = abs(difpcx34wavdper./avepcx34wavdper) * 100;

difpcx44wavdper = font_wavperM - wavdper_int;
avepcx44wavdper = (font_wavperM + wavdper_int)/2;
pd4pcx4_wavdper = abs(difpcx44wavdper./avepcx44wavdper) * 100;


% Plot Water temperature Comparison
 figure(1)
 hold on
 plot(pcx2_timeM,pcx2_tempM,'g.-')
 plot(pcx3_timeM,pcx3_tempM,'r.-')
 plot(pcx4_timeM,pcx4_tempM,'c.-')
 plot(pcx2_timeM,wtemp_int,'k.-')
 title('Water Temperature for PacX Gliders and NDBC 51000')
 xlabel('Date')
 ylabel('Water Temperature(degrees C)')
 legend('Benjamin','Piccard Maru','Fontaine Maru','NDBC 51000','location','SouthEast')
 datetick('x',6,'keepticks','keeplimits')
 print -dpng 'C:\a_data\pac_crossing\mooring_51000\pacxwtempvs51000.png'
% 
% 
 figure(2)
 hold on
 plot(benj_timeM,pd4pcx2_wtemp,'g.-')
 hold on
 plot(picc_timeM,pd4pcx3_wtemp,'r.-')
 plot(font_timeM,pd4pcx4_wtemp,'c.-')
 title('Percent Difference in Water Temperature between PacX Gliders and NDBC 51000')
 xlabel('Date')
 ylabel('Percent Difference')
 legend('Benjamin','Piccard Maru','Fontaine Maru','location','SouthEast')
 datetick('x',6,'keepticks','keeplimits')
 print -dpng 'C:\a_data\pac_crossing\mooring_51000\pacxwtempvs51000_pd.png'

% Plot Air temperature Comparison
 figure(1)
 hold on
 plot(pcx2_timeM,pcx2_atempM,'g.-')
 plot(pcx3_timeM,pcx3_atempM,'r.-')
 plot(pcx4_timeM,pcx4_atempM,'c.-')
 plot(benj_timeM,atemp_int,'k.-')
 title('Air Temperature for PacX Gliders and NDBC 51000')
 xlabel('Date')
 ylabel('Air Temperature(degrees C)')
 legend('Benjamin','Piccard Maru','Fontaine Maru','NDBC 51000','location','SouthEast')
 datetick('x',6,'keepticks','keeplimits')
 print -dpng 'C:\a_data\pac_crossing\mooring_51000\pacxatempvs51000.png'
% 
 figure(2)
 hold on
 plot(benj_timeM,pd4pcx2_atemp,'g.-')
 hold on
 plot(picc_timeM,pd4pcx3_atemp,'r.-')
 plot(font_timeM,pd4pcx4_atemp,'c.-')
 title('Percent Difference in Air Temperature between PacX Gliders and NDBC 51000')
 xlabel('Date')
 ylabel('Percent Difference')
 legend('Benjamin','Piccard Maru','Fontaine Maru','location','SouthEast')
 datetick('x',6,'keepticks','keeplimits')
 print -dpng 'C:\a_data\pac_crossing\mooring_51000\pacxatempvs51000_pd.png'
% 
% % Plot Barometric Pressure Comparison
 figure(3)
 hold on
 plot(pcx2_timeM,pcx2_bpM,'g.-')
 plot(pcx3_timeM,pcx3_bpM,'r.-')
 plot(pcx4_timeM,pcx4_bpM,'c.-')
 plot(benj_timeM,press_int,'k.-')
 title('Barometric Pressure for PacX Gliders and NDBC 51000')
 xlabel('Date')
 ylabel('Barometric Pressure(milllibars)')
 legend('Benjamin','Piccard Maru','Fontaine Maru','NDBC 51000','location','SouthEast')
 datetick('x',6,'keepticks','keeplimits')
 print -dpng 'C:\a_data\pac_crossing\mooring_51000\pacxpressvs51000.png'
% 
 figure(4)
 hold on
 plot(benj_timeM,pd4pcx2_press,'g.-')
 hold on
 plot(picc_timeM,pd4pcx3_press,'r.-')
 plot(font_timeM,pd4pcx4_press,'c.-')
 title('Percent Difference in Barometric Pressure between PacX Gliders and NDBC 51000')
 xlabel('Date')
 ylabel('Percent Difference')
 legend('Benjamin','Piccard Maru','Fontaine Maru','location','SouthEast')
 datetick('x',6,'keepticks','keeplimits')
 print -dpng 'C:\a_data\pac_crossing\mooring_51000\pacxpressvs51000_pd.png'
 return
% 
% 
 figure(5)
 hold on
 plot(pcx2_lon,pcx2_lat,'g.-')
 hold on
 plot(pcx3_lon,pcx3_lat,'r.-')
 plot(pcx4_lon,pcx4_lat,'b.-')
 title('Position of PacX Wave Gliders')
 xlabel('Longitude')
 ylabel('Latitude')
 legend('Benjamin','Piccard Maru','Fontaine Maru')
 datetick('x',6,'keepticks','keeplimits')
% 
 return

% Plot Wind Speed Comparison
 figure(1)
 hold on
 plot(pcx2_timeM,pcx2_wsM,'g.-')
 plot(pcx3_timeM,pcx3_wsM,'r.-')
 plot(pcx4_timeM,pcx4_wsM,'c.-')
 plot(benj_timeM,wspeed_int,'k.-')
 title('Wind Speed for PacX Gliders and NDBC 51000')
 xlabel('Date')
 ylabel('Wind Speed(knots)')
 legend('Benjamin','Piccard Maru','Fontaine Maru','NDBC 51000','location','SouthEast')
 datetick('x',6,'keepticks','keeplimits')
 print -dpng 'C:\a_data\pac_crossing\mooring_51000\pacxwsvs51000.png'
% 
 figure(2)
 hold on
 plot(benj_timeM,pd4pcx2_wspeed,'g.-')
 hold on
 plot(picc_timeM,pd4pcx3_wspeed,'r.-')
 plot(font_timeM,pd4pcx4_wspeed,'c.-')
 title('Percent Difference in Wind Speed between PacX Gliders and NDBC 51000')
 xlabel('Date')
 ylabel('Percent Difference')
 legend('Benjamin','Piccard Maru','Fontaine Maru','location','SouthEast')
 datetick('x',6,'keepticks','keeplimits')
 print -dpng 'C:\a_data\pac_crossing\mooring_51000\pacxwsvs51000_pd.png'
% 
% 
% % Plot Wind Gust Comparison
 figure(3)
 hold on          
 plot(pcx2_timeM,pcx2_wgM,'g.-')
 plot(pcx3_timeM,pcx3_wgM,'r.-')
 plot(pcx4_timeM,pcx4_wgM,'c.-')
 plot(benj_timeM,wgust_int,'k.-')
 title('Wind Gust for PacX Gliders and NDBC 51000')
 xlabel('Date')
 ylabel('Wind Gust(knots)')
 legend('Benjamin','Piccard Maru','Fontaine Maru','NDBC 51000','location','SouthEast')
 datetick('x',6,'keepticks','keeplimits')
% 
 figure(4)
 hold on
 plot(benj_timeM,pd4pcx2_wgust,'g.-')
 hold on
 plot(picc_timeM,pd4pcx3_wgust,'r.-')
 plot(font_timeM,pd4pcx4_wgust,'c.-')
 title('Percent Difference in Wind Gust between PacX Gliders and NDBC 51000')
 xlabel('Date')
 ylabel('Percent Difference')
 legend('Benjamin','Piccard Maru','Fontaine Maru','location','SouthEast')
 datetick('x',6,'keepticks','keeplimits')
% 
% Plot Wind Direction Comparison


 figure(1)
 hold on
 plot(pcx2_timeM,pcx2_wdM,'g.-')
 plot(pcx3_timeM,pcx3_wdM,'r.-')
 plot(pcx4_timeM,pcx4_wdM,'c.-')
 plot(benj_timeM,wdir_int,'k.-')
 title('Wind Direction for PacX Gliders and NDBC 51000')
 xlabel('Date')
 ylabel('Wind Gust(knots)')
 legend('Benjamin','Piccard Maru','Fontaine Maru','NDBC 51000','location','SouthEast')
 datetick('x',6,'keepticks','keeplimits')
 print -dpng 'C:\a_data\pac_crossing\mooring_51000\pacxwdirvs51000.png'
% 
 figure(2)
 hold on
 plot(benj_timeM,absdifpcx2_wdir,'g.-')
 hold on
 plot(picc_timeM,absdifpcx3_wdir,'r.-')
 plot(font_timeM,absdifpcx4_wdir,'c.-')
 title('Absolute Difference in Wind Direction between PacX Gliders and NDBC 51000')
 xlabel('Date')
 ylabel('Absolute Difference(degrees)')
 legend('Benjamin','Piccard Maru','Fontaine Maru','location','SouthEast')
 datetick('x',6,'keepticks','keeplimits')
 print -dpng 'C:\a_data\pac_crossing\mooring_51000\pacxwdirvs51000_pd.png'

% 
% 
% 
% return
% Plot Wave Height Comparison
figure(1)
hold on
plot(pcx2_timeM,benj_wavhtM,'g.-')
plot(pcx3_timeM,picc_wavhtM,'r.-')
plot(pcx4_timeM,font_wavhtM,'c.-')
plot(benj_timeM,waveheight_int,'k.-')
title('Wave Height for PacX Gliders and NDBC 51000')
xlabel('Date')
ylabel('Wave Height(meters)')
legend('Benjamin','Piccard Maru','Fontaine Maru','NDBC 51000','location','SouthEast')
datetick('x',6,'keepticks','keeplimits')
print -dpng 'C:\a_data\pac_crossing\mooring_51000\pacxwhvs51000.png'

figure(2)
hold on
plot(benj_timeM,pd4pcx2_wavht,'g.-')
hold on
plot(picc_timeM,pd4pcx3_wavht,'r.-')
plot(font_timeM,pd4pcx4_wavht,'c.-')
title('Percent Difference in Wave Height between PacX Gliders and NDBC 51000')
xlabel('Date')
ylabel('Percent Difference')
legend('Benjamin','Piccard Maru','Fontaine Maru','location','SouthEast')
datetick('x',6,'keepticks','keeplimits')
print -dpng 'C:\a_data\pac_crossing\mooring_51000\pacxwhvs51000_pd.png'


% Plot Wave Direction Comparison
figure(3)
hold on
plot(pcx2_timeM,benj_wavdirM,'g.-')
plot(pcx3_timeM,picc_wavdirM,'r.-')
plot(pcx4_timeM,font_wavdirM,'c.-')
plot(benj_timeM,wavedir_int,'k.-')
title('Wave Direction for PacX Gliders and NDBC 51000')
xlabel('Date')
ylabel('Wave Direction(degrees T)')
legend('Benjamin','Piccard Maru','Fontaine Maru','NDBC 51000','location','NorthWest')
datetick('x',6,'keepticks','keeplimits')
print -dpng 'C:\a_data\pac_crossing\mooring_51000\pacxwdvs51000.png'

figure(4)
hold on
plot(benj_timeM,absdifpcx2_wavdir,'g.-')
hold on
plot(picc_timeM,absdifpcx3_wavdir,'r.-')
plot(font_timeM,absdifpcx4_wavdir,'c.-')
title('Absolute Difference in Wave Direction between PacX Gliders and NDBC 51000')
xlabel('Date')
ylabel('Absolute Difference(degrees)')
legend('Benjamin','Piccard Maru','Fontaine Maru','location','NorthWest')
datetick('x',6,'keepticks','keeplimits')
print -dpng 'C:\a_data\pac_crossing\mooring_51000\pacxwdvs51000_ad.png'

return
% Plot Wave Average Period Comparison
figure(5)
hold on
plot(pcx2_timeM,benj_wavaperM,'g.-')
plot(pcx3_timeM,picc_wavaperM,'r.-')
plot(pcx4_timeM,font_wavaperM,'c.-')
plot(benj_timeM,wavaper_int,'k.-')
title('Average Wave Period for PacX Gliders and NDBC 51000')
xlabel('Date')
ylabel('Average Wave Period(seconds)')
legend('Benjamin','Piccard Maru','Fontaine Maru','NDBC 51000','location','NorthWest')
datetick('x',6,'keepticks','keeplimits')
print -dpng 'C:\a_data\pac_crossing\mooring_51000\pacxapvs51000.png'

figure(6)
hold on
plot(benj_timeM,pd4pcx2_wavaper,'g.-')
hold on
plot(picc_timeM,pd4pcx3_wavaper,'r.-')
plot(font_timeM,pd4pcx4_wavaper,'c.-')
title('Percent Difference in Average Wave Period between PacX Gliders and NDBC 51000')
xlabel('Date')
ylabel('Percent Difference')
legend('Benjamin','Piccard Maru','Fontaine Maru','location','NorthWest')
datetick('x',6,'keepticks','keeplimits')
print -dpng 'C:\a_data\pac_crossing\mooring_51000\pacxapvs51000_pd.png'

% Plot Dominant Average Period Comparison
figure(7)
hold on
plot(pcx2_timeM,benj_wavperM,'g.-')
plot(pcx3_timeM,picc_wavperM,'r.-')
plot(pcx4_timeM,font_wavperM,'c.-')
plot(benj_timeM,wavdper_int,'k.-')
title('Dominant Wave Period for PacX Gliders and NDBC 51000')
xlabel('Date')
ylabel('Dominant Wave Period(seconds)')
legend('Benjamin','Piccard Maru','Fontaine Maru','NDBC 51000','location','NorthWest')
datetick('x',6,'keepticks','keeplimits')
print -dpng 'C:\a_data\pac_crossing\mooring_51000\pacxdpvs51000.png'

figure(8)
hold on
plot(benj_timeM,pd4pcx2_wavdper,'g.-')
hold on
plot(picc_timeM,pd4pcx3_wavdper,'r.-')
plot(font_timeM,pd4pcx4_wavdper,'c.-')
title('Percent Difference in Dominant Wave Period between PacX Gliders and NDBC 51000')
xlabel('Date')
ylabel('Percent Difference')
legend('Benjamin','Piccard Maru','Fontaine Maru','location','NorthWest')
datetick('x',6,'keepticks','keeplimits')
print -dpng 'C:\a_data\pac_crossing\mooring_51000\pacxdpvs51000_pd.png'
