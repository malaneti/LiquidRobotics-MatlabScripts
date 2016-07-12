% pacxAIRMARvs46092.m
% script to plot weather data from PacX vehicles during their stay at M1 in Monterey Bay



% reading data from NDBC website
 str = urlread('http://www.ndbc.noaa.gov/data/realtime2/46092.txt');
 i4header = findstr('ft',str);
 str = str(i4header+3:end)
 str = strrep(str,' MM ',' NaN ');
 str = strrep(str,' MM',' NaN ');
% 
 data = str2num(str);
 year = data(:,1);
 month = data(:,2);
 day = data(:,3);
 hour = data(:,4);
 minute = data(:,5);
 time46092 = datenum(year,month,day,hour,minute,0);
 wdir = data(:,6);
 wspd = data(:,7);                                        % wind speed in m/s
 wspd = wspd*1.9438444925                                 % convert to knots; conversion factor from onlineconversion.com
 pressure = data(:,13);
 atemp = data(:,14);
 wtemp = data(:,15);
%


atemp = ncread('C:\a_data\pac_crossing\m1\metsys_m1.nc','AirTemperature');
atemp = reshape(atemp,1,59988);

apres = ncread('C:\a_data\pac_crossing\m1\metsys_m1.nc','AirPressure');
apres = reshape(apres,1,59988);
apres = apres + 800;                                                                      % MBARI subtracts 800 millibars for data compression?

relh = ncread('C:\a_data\pac_crossing\m1\metsys_m1.nc','RelativeHumidity');
relh = reshape(relh,1,59988);

awspd_sonic = ncread('C:\a_data\pac_crossing\m1\metsys_m1.nc','AvgWindSpeed_Sonic');
awspd_sonic = reshape(awspd_sonic,1,59988);

awdir_sonic = ncread('C:\a_data\pac_crossing\m1\metsys_m1.nc','AvgWindDir_Sonic');
awdir_sonic = reshape(awdir_sonic,1,59988);

wspd_wbrd = ncread('C:\a_data\pac_crossing\m1\metsys_m1.nc','WindSpd_Windbird');
wspd_wbrd = reshape(wspd_wbrd,1,59988);

wdir_wbrd = ncread('C:\a_data\pac_crossing\m1\metsys_m1.nc','WindDir_Windbird');
wdir_wbrd = reshape(wdir_wbrd,1,59988);

esec4ws = ncread('C:\a_data\pac_crossing\m1\metsys_m1.nc','esecs');
esecs4ws = sec_date(esec4ws);

lat = ncread('C:\a_data\pac_crossing\m1\gps1621_m1.nc','latitude');
lat = reshape(lat,1,20044);
lon = ncread('C:\a_data\pac_crossing\m1\gps1621_m1.nc','longitude');
lon = reshape(lon,1,20044);
esec4gps = ncread('C:\a_data\pac_crossing\m1\gps1621_m1.nc','esecs');
esecs4gps = sec_date(esec4gps);

gpstime = datenum(esecs4gps(:,1),esecs4gps(:,2),esecs4gps(:,3),esecs4gps(:,4),esecs4gps(:,5),esecs4gps(:,6)); 
i4gps = find(gpstime >= datenum(2011,11,23,7,0,0) & gpstime <= datenum(2011,12,9,6,0,0));
gpstime = gpstime(i4gps);
m1_lat = lat(i4gps);
m1_lon = lon(i4gps);


wstime = datenum(esecs4ws(:,1),esecs4ws(:,2),esecs4ws(:,3),esecs4ws(:,4),esecs4ws(:,5),esecs4ws(:,6)); 
i = find(wstime >= datenum(2011,11,23,7,0,0) & wstime <= datenum(2011,12,9,6,0,0));
wstime = wstime(i);
atemp = atemp(i);
apres = apres(i);
relh = relh(i);
awspd_sonic = awspd_sonic(i);
awdir_sonic = awdir_sonic(i);
wspd_wbrd = wspd_wbrd(i);
wdir_wbrd = wdir_wbrd(i);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% % Get Wave Glider data from database
ws_pcx1 = bpws_getdata('2011-11-23 07:00:00','2011-12-09 06:00:00','Papa Mau');
ws_pcx2 = bpws_getdata('2011-11-23 07:00:00','2011-12-09 06:00:00','Benjamin');
ws_pcx3 = bpws_getdata('2011-11-23 07:00:00','2011-12-09 06:00:00','Piccard Maru');
ws_pcx4 = bpws_getdata('2011-11-23 07:00:00','2011-12-09 06:00:00','Fontaine Maru');
%return
pcx1_time = ws_pcx1.absjday;
pcx2_time = ws_pcx2.absjday;
pcx3_time = ws_pcx3.absjday;
pcx4_time = ws_pcx4.absjday;

pcx1_lat = ws_pcx1.lat;
pcx2_lat = ws_pcx2.lat;
pcx3_lat = ws_pcx3.lat;
pcx4_lat = ws_pcx4.lat;

pcx1_lon = ws_pcx1.lon;
pcx2_lon = ws_pcx2.lon;
pcx3_lon = ws_pcx3.lon;
pcx4_lon = ws_pcx4.lon;

pcx1_ws = ws_pcx1.ws;
pcx2_ws = ws_pcx2.ws;
pcx3_ws = ws_pcx3.ws;
pcx4_ws = ws_pcx4.ws;

pcx1_wd = ws_pcx1.wd;
pcx2_wd = ws_pcx2.wd;
pcx3_wd = ws_pcx3.wd;
pcx4_wd = ws_pcx4.wd;

pcx1_wg = ws_pcx1.wg;
pcx2_wg = ws_pcx2.wg;
pcx3_wg = ws_pcx3.wg;
pcx4_wg = ws_pcx4.wg;

pcx1_bp = ws_pcx1.bp;
pcx2_bp = ws_pcx2.bp;
pcx3_bp = ws_pcx3.bp;
pcx4_bp = ws_pcx4.bp;

pcx1_temp = ws_pcx1.temp;
pcx2_temp = ws_pcx2.temp;
pcx3_temp = ws_pcx3.temp;
pcx4_temp = ws_pcx4.temp;


% average M1 latitude and longitudes into one hour intervals
m1_gpstimevec = datevec(gpstime);
hourL = datenum(2011,11,23,7,0,0);
count = 1;
while hourL < datenum(2011,12,9,6,0,0)
  timeL = datevec(hourL);
  i = find(m1_gpstimevec(:,1) == timeL(1) & m1_gpstimevec(:,2) == timeL(2) & m1_gpstimevec(:,3) == timeL(3) & m1_gpstimevec(:,4) == timeL(4));
  if isempty(i)
    m1_latM(count) = NaN;
    m1_lonM(count) = NaN;
    m1gps_timeM(count) = hourL;
  else
    m1_latM(count) = mean(m1_lat(i));
    m1_lonM(count) = mean(m1_lon(i));
    m1gps_timeM(count) = hourL;
  end
  hourL = hourL + 1.00000001/24;
  count = count + 1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% average M1 metsys data to hour intervals
m1_timevec = datevec(wstime);
hourL = datenum(2011,11,23,7,0,0);
count = 1;
while hourL < datenum(2011,12,9,6,0,0)
  timeL = datevec(hourL);
  i = find(m1_timevec(:,1) == timeL(1) & m1_timevec(:,2) == timeL(2) & m1_timevec(:,3) == timeL(3) & m1_timevec(:,4) == timeL(4));
  timeM(count) = hourL;
  atempM(count) = mean(atemp(i));
  apresM(count) = mean(apres(i));
  relhM(count) = mean(relh(i));
  latM(count) = mean(lat(i));
  lonM(count) = mean(lon(i));
  awspd_sonicM(count) = mean(awspd_sonic(i));
  awdir_sonicM(count) = mean(awdir_sonic(i));
  wspd_wbrdM(count) = mean(wspd_wbrd(i));
  wdir_wbrdM(count) = mean(wdir_wbrd(i));
  hourL = hourL + 1.00000001/24;
  count = count + 1;
end


% Limit data to compare to M1 based on seperation distance being less than 8 km;  Use data from 11/23/2011 7:00 AM UTC to 12/9/2011 6:00 AM UTC


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% average pacx wsdata to hour intervals
hourL = datenum(2011,11,23,7,0,0);
pcx1_timevec = datevec(pcx1_time);
pcx2_timevec = datevec(pcx2_time);
pcx3_timevec = datevec(pcx3_time);
pcx4_timevec = datevec(pcx4_time);
count = 1;
while hourL < datenum(2011,12,9,6,0,0)
  timeL = datevec(hourL);
  i4pcx1 = find(pcx1_timevec(:,1) == timeL(1) & pcx1_timevec(:,2) == timeL(2) & pcx1_timevec(:,3) == timeL(3) & pcx1_timevec(:,4) == timeL(4));
  pcx1_atempM(count) = mean(pcx1_temp(i4pcx1));
  pcx1_wsM(count) = mean(pcx1_ws(i4pcx1));
  pcx1_wdM(count) = mean(pcx1_wd(i4pcx1));
  pcx1_wgM(count) = mean(pcx1_wg(i4pcx1));
  pcx1_bpM(count) = mean(pcx1_bp(i4pcx1));
  pcx1_latM(count) = mean(pcx1_lat(i4pcx1));
  pcx1_lonM(count) = mean(pcx1_lon(i4pcx1));
  pcx1_timeM(count) = hourL;
  
  i4pcx2 = find(pcx2_timevec(:,1) == timeL(1) & pcx2_timevec(:,2) == timeL(2) & pcx2_timevec(:,3) == timeL(3) & pcx2_timevec(:,4) == timeL(4));
  pcx2_atempM(count) = mean(pcx2_temp(i4pcx2));
  pcx2_wsM(count) = mean(pcx2_ws(i4pcx2));
  pcx2_wdM(count) = mean(pcx2_wd(i4pcx2));
  pcx2_wgM(count) = mean(pcx2_wg(i4pcx2));
  pcx2_bpM(count) = mean(pcx2_bp(i4pcx2));
  pcx2_latM(count) = mean(pcx2_lat(i4pcx1));
  pcx2_lonM(count) = mean(pcx2_lon(i4pcx1));
  pcx2_timeM(count) = hourL;
  
  i4pcx3 = find(pcx3_timevec(:,1) == timeL(1) & pcx3_timevec(:,2) == timeL(2) & pcx3_timevec(:,3) == timeL(3) & pcx3_timevec(:,4) == timeL(4));
  pcx3_atempM(count) = mean(pcx3_temp(i4pcx3));
  pcx3_wsM(count) = mean(pcx3_ws(i4pcx3));
  pcx3_wdM(count) = mean(pcx3_wd(i4pcx3));
  pcx3_wgM(count) = mean(pcx3_wg(i4pcx3));
  pcx3_bpM(count) = mean(pcx3_bp(i4pcx3));
  pcx3_latM(count) = mean(pcx3_lat(i4pcx1));
  pcx3_lonM(count) = mean(pcx3_lon(i4pcx1));
  pcx3_timeM(count) = hourL;
  
  i4pcx4 = find(pcx4_timevec(:,1) == timeL(1) & pcx4_timevec(:,2) == timeL(2) & pcx4_timevec(:,3) == timeL(3) & pcx4_timevec(:,4) == timeL(4));
  pcx4_atempM(count) = mean(pcx4_temp(i4pcx4));
  pcx4_wsM(count) = mean(pcx4_ws(i4pcx4));
  pcx4_wdM(count) = mean(pcx4_wd(i4pcx4));
  pcx4_wgM(count) = mean(pcx4_wg(i4pcx4));
  pcx4_bpM(count) = mean(pcx4_bp(i4pcx4));
  pcx4_latM(count) = mean(pcx4_lat(i4pcx1));
  pcx4_lonM(count) = mean(pcx4_lon(i4pcx1));
  pcx4_timeM(count) = hourL;

  hourL = hourL + 1.00000001/24;                               % need to increment hourL to avoid 60 second problem
  count = count + 1;
end

% calculate seperation distance between vehicles and M1 position.
for j = 1:length(pcx1_latM)
    pcx1_sd(j) = gcircle_(m1_latM(j),m1_lonM(j),pcx1_latM(j),pcx1_lonM(j),0)                % output is in nautical miles
    pcx1_sd(j) = pos2dist(m1_latM(j),m1_lonM(j),pcx1_latM(j),pcx1_lonM(j),1);               % output is in km
end
pcx1_sd =  pcx1_sd * .53995680346;                                                        % 1 kilometer = 0.539 956 803 46 mile [nautical, US]; from onlineconversion.com
i4pcx1sd = find(pcx1_sd < 1)

for j = 1:length(pcx2_latM)
    pcx2_sd(j) = gcircle_(m1_latM(j),m1_lonM(j),pcx2_latM(j),pcx2_lonM(j),0);  
    pcx2_sd(j) = pos2dist(m1_latM(j),m1_lonM(j),pcx2_latM(j),pcx2_lonM(j),1);               % output is in km
end
pcx2_sd =  pcx2_sd * .53995680346;                                                        % 1 kilometer = 0.539 956 803 46 mile [nautical, US]; from onlineconversion.com
i4pcx2sd = find(pcx2_sd < 1)

for j = 1:length(pcx3_latM)
    pcx3_sd(j) = gcircle_(m1_latM(j),m1_lonM(j),pcx3_latM(j),pcx3_lonM(j),0);  
    pcx3_sd(j) = pos2dist(m1_latM(j),m1_lonM(j),pcx3_latM(j),pcx3_lonM(j),1);               % output is in km
end
pcx3_sd =  pcx3_sd * .53995680346;                                                        % 1 kilometer = 0.539 956 803 46 mile [nautical, US]; from onlineconversion.com
i4pcx3sd = find(pcx3_sd < 1)

for j = 1:length(pcx4_latM)
    pcx4_sd(j) = gcircle_(m1_latM(j),m1_lonM(j),pcx4_latM(j),pcx4_lonM(j),0);  
    pcx4_sd(j) = pos2dist(m1_latM(j),m1_lonM(j),pcx4_latM(j),pcx4_lonM(j),1);               % output is in km
end
pcx4_sd =  pcx4_sd * .53995680346;                                                        % 1 kilometer = 0.539 956 803 46 mile [nautical, US]; from onlineconversion.com
i4pcx4sd = find(pcx4_sd < 1)

 count = 1;
 for j = 1:length(pcx2_latM)
   pcx2time_M = datevec(pcx2_timeM(j))
   i = find(m1gpstimeM(:,1) == pcx2time_M(1) & m1gpstimeM(:,2) == pcx2time_M(2) & m1gpstimeM(:,3) == pcx2time_M(3) & m1gpstimeM(:,4) == pcx2time_M(4));
   if isempty(i)
     continue
   elseif  length(i) > 1
     pcx2_sd(count) = NaN;
     continue
   else
     pcx2_sd(count) = gcircle_(m1_latM(i),m1_lonM(i),pcx2_latM(j),pcx2_lonM(j),0);  
   end
   hourL = hourL + 1/24;
   count = count + 1;
 end
% 
 count = 1;
 for j = 1:length(pcx3_latM)
   pcx3time_M = datevec(pcx3_timeM(j))
   i = find(m1gpstimeM(:,1) == pcx3time_M(1) & m1gpstimeM(:,2) == pcx3time_M(2) & m1gpstimeM(:,3) == pcx3time_M(3) & m1gpstimeM(:,4) == pcx3time_M(4));
   if isempty(i)
     continue
   elseif  length(i) > 1
     pcx3_sd(count) = NaN;
     continue
   else
     pcx3_sd(count) = gcircle_(m1_latM(i),m1_lonM(i),pcx3_latM(j),pcx3_lonM(j),0);  
   end
   hourL = hourL + 1/24;
   count = count + 1;
 end
% 
 count = 1;
 for j = 1:length(pcx4_latM)
   pcx4time_M = datevec(pcx4_timeM(j))
   i = find(m1gpstimeM(:,1) == pcx4time_M(1) & m1gpstimeM(:,2) == pcx4time_M(2) & m1gpstimeM(:,3) == pcx4time_M(3) & m1gpstimeM(:,4) == pcx4time_M(4));
   if isempty(i)
     continue
   elseif  length(i) > 1
     pcx4_sd(count) = NaN;
     continue
   else
     pcx4_sd(count) = gcircle_(m1_latM(i),m1_lonM(i),pcx4_latM(j),pcx4_lonM(j),0);  
   end
   hourL = hourL + 1/24;
   count = count + 1;
 end
% return




% calculate percent difference for air temperature relative to M1
difpcx14atemp = pcx1_atempM - atempM;
avepcx14atemp = (pcx1_atempM + atempM)/2;
pd4pcx1_atemp = abs(difpcx14atemp./avepcx14atemp) * 100;

difpcx24atemp = pcx2_atempM - atempM;
avepcx24atemp = (pcx2_atempM + atempM)/2;
pd4pcx2_atemp = abs(difpcx24atemp./avepcx24atemp) * 100;

difpcx34atemp = pcx3_atempM - atempM;
avepcx34atemp = (pcx3_atempM + atempM)/2;
pd4pcx3_atemp = abs(difpcx34atemp./avepcx34atemp) * 100;

difpcx44atemp = pcx4_atempM - atempM;
avepcx44atemp = (pcx4_atempM + atempM)/2;
pd4pcx4_atemp = abs(difpcx44atemp./avepcx44atemp) * 100;


% calculate percent difference for wind speed relative to M1 wind bird
difpcx14ws = pcx1_wsM - wspd_wbrdM;
avepcx14ws = (pcx1_wsM + wspd_wbrdM)/2;
pd4pcx1_ws = abs(difpcx14ws./avepcx14ws) * 100;

difpcx24ws = pcx2_wsM - wspd_wbrdM;
avepcx24ws = (pcx2_wsM + wspd_wbrdM)/2;
pd4pcx2_ws = abs(difpcx24ws./avepcx24ws) * 100;

difpcx34ws = pcx3_wsM - wspd_wbrdM;
avepcx34ws = (pcx3_wsM + wspd_wbrdM)/2;
pd4pcx3_ws = abs(difpcx34ws./avepcx34ws) * 100;

difpcx44ws = pcx4_wsM - wspd_wbrdM;
avepcx44ws = (pcx4_wsM + wspd_wbrdM)/2;
pd4pcx4_ws = abs(difpcx44ws./avepcx44ws) * 100;

% calculate percent difference for wind direction relative to M1 wind bird
difpcx14wd = pcx1_wdM - wdir_wbrdM;
avepcx14wd = (pcx1_wdM + wdir_wbrdM)/2;
pd4pcx1_wd = abs(difpcx14wd./avepcx14wd) * 100;

difpcx24wd = pcx2_wdM - wdir_wbrdM;
avepcx24wd = (pcx2_wdM + wdir_wbrdM)/2;
pd4pcx2_wd = abs(difpcx24wd./avepcx24wd) * 100;

difpcx34wd = pcx3_wdM - wdir_wbrdM;
avepcx34wd = (pcx3_wdM + wdir_wbrdM)/2;
pd4pcx3_wd = abs(difpcx34wd./avepcx34wd) * 100;

difpcx44wd = pcx4_wdM - wdir_wbrdM;
avepcx44wd = (pcx4_wdM + wdir_wbrdM)/2;
pd4pcx4_wd = abs(difpcx44wd./avepcx44wd) * 100;

% calculate percent difference for wind speed relative to M1 sonic anemometer
dif2pcx14ws = pcx1_wsM - awspd_sonicM;
ave2pcx14ws = (pcx1_wsM + awspd_sonicM)/2;
pd24pcx1_ws = abs(dif2pcx14ws./ave2pcx14ws) * 100;

dif2pcx24ws = pcx2_wsM - awspd_sonicM;
ave2pcx24ws = (pcx2_wsM + awspd_sonicM)/2;
pd24pcx2_ws = abs(dif2pcx24ws./ave2pcx24ws) * 100;

dif2pcx34ws = pcx3_wsM - awspd_sonicM;
ave2pcx34ws = (pcx3_wsM + awspd_sonicM)/2;
pd24pcx3_ws = abs(dif2pcx34ws./ave2pcx34ws) * 100;

dif2pcx44ws = pcx4_wsM - awspd_sonicM;
ave2pcx44ws = (pcx4_wsM + awspd_sonicM)/2;
pd24pcx4_ws = abs(dif2pcx44ws./ave2pcx44ws) * 100;

% calculate percent difference for wind direction relative to M1 sonic anemometer
dif2pcx14wd = pcx1_wdM - awdir_sonicM;
ave2pcx14wd = (pcx1_wdM + awdir_sonicM)/2;
pd24pcx1_wd = abs(dif2pcx14wd./ave2pcx14wd) * 100;

dif2pcx24wd = pcx2_wdM - awdir_sonicM;
ave2pcx24wd = (pcx2_wdM + awdir_sonicM)/2;
pd24pcx2_wd = abs(dif2pcx24wd./ave2pcx24wd) * 100;

dif2pcx34wd = pcx3_wdM - awdir_sonicM;
ave2pcx34wd = (pcx3_wdM + awdir_sonicM)/2;
pd24pcx3_wd = abs(dif2pcx34wd./ave2pcx34wd) * 100;

dif2pcx44wd = pcx4_wdM - awdir_sonicM;
ave2pcx44wd = (pcx4_wdM + awdir_sonicM)/2;
pd24pcx4_wd = abs(dif2pcx44wd./ave2pcx44wd) * 100;

% calculate percent difference for barometric pressure relative to M1 
difpcx14bp = pcx1_bpM - apresM;
avepcx14bp = (pcx1_bpM + apresM)/2;
pd4pcx1_bp = abs(difpcx14bp./avepcx14bp) * 100;

difpcx24bp = pcx2_bpM - apresM;
avepcx24bp = (pcx2_bpM + apresM)/2;
pd4pcx2_bp = abs(difpcx24bp./avepcx24bp) * 100;

difpcx34bp = pcx3_bpM - apresM;
avepcx34bp = (pcx3_bpM + apresM)/2;
pd4pcx3_bp = abs(difpcx34bp./avepcx34bp) * 100;

difpcx44bp = pcx4_bpM - apresM;
avepcx44bp = (pcx4_bpM + apresM)/2;
pd4pcx4_bp = abs(difpcx44bp./avepcx44bp) * 100;


% dependance of percent difference on vehicle seperation distance 

 vehicle_pd_ws = [pd4pcx1_ws pd4pcx2_ws pd4pcx3_ws pd4pcx4_ws];
 vehicle_pd_wd = [pd4pcx1_wd pd4pcx2_wd pd4pcx3_wd pd4pcx4_wd];
 vehicle_pd_at = [pd4pcx1_atemp pd4pcx2_atemp pd4pcx3_atemp pd4pcx4_atemp];
 vehicle_pd_bp = [pd4pcx1_bp pd4pcx2_bp pd4pcx3_bp pd4pcx4_bp];
 vehicle_sd = [pcx1_sd pcx2_sd pcx3_sd pcx4_sd];
% 
 i4vsd = isnan(vehicle_sd);
 vehicle_sd = vehicle_sd(~i4vsd);
% 
 vehicle_pd_bp = vehicle_pd_bp(~i4vsd); 
% 
 [B4bp,r4bp,n,s,C,S,DF,P1,P2,P3,yresid] = regress_(vehicle_sd,vehicle_pd_bp,1,1)
 ycalc4bp = (B4bp(2)*vehicle_sd) + B4bp(1);
% 
 plot(vehicle_sd,vehicle_pd_bp,'b.');hold on
 plot(vehicle_sd,ycalc4bp,'r-')
 disp(r4bp)
 return



 plot pacx vehicle wind speeds and M1 windbird and sonic anemometer
 plot(pcx1_timeM,pcx1_bpM,'b.-')
 hold on
 plot(pcx2_timeM,pcx2_bpM,'g.-')
 plot(pcx3_timeM,pcx3_bpM,'r.-')
 plot(pcx4_timeM,pcx4_bpM,'c.-')
 plot(timeM,apresM,'k.-')
 datetick('x','mm/dd','keepticks','keeplimits')
 xlabel('Date')
 ylabel('Barometric Pressure(millibars)')
 title('Barometric Pressure from PacX Gliders and M1(NDBC 46092)')
 legend('Papa Mau','Benjamin','Piccard Maru','Fontaine Maru','M1')
 box off
 print -dpng 'C:\a_data\pac_crossing\pacxbpvsM1.png'

hold on
plot(pcx1_timeM,pd4pcx1_bp,'b.-')
plot(pcx2_timeM,pd4pcx2_bp,'g.-')
plot(pcx3_timeM,pd4pcx3_bp,'r.-')
plot(pcx4_timeM,pd4pcx4_bp,'c.-')
datetick('x','mm/dd','keepticks','keeplimits')
xlabel('Date')
ylabel('Percent Difference')
title('Percent Difference in Barometric Pressure between PacX Gliders and M1')
legend('Papa Mau','Benjamin','Piccard Maru','Fontaine Maru')
print -dpng 'C:\a_data\pac_crossing\pacxpdbpvsM1.png'



return








% Percent Difference plots

figure(1)
hold on
plot(pcx1_timeM,pcx1_atempM,'b.-')
plot(pcx2_timeM,pcx2_atempM,'g.-')
plot(pcx3_timeM,pcx3_atempM,'r.-')
plot(pcx4_timeM,pcx4_atempM,'c.-')
plot(timeM,atempM,'k.-')
datetick('x','mm/dd','keepticks','keeplimits')
xlabel('Date')
ylabel('Air Temperature(degrees C)')
title('Air Temperature from PacX Gliders')
legend('Papa Mau','Benjamin','Piccard Maru','Fontaine Maru','M1:46092')
print -dpng 'C:\a_data\pac_crossing\pacxatempvsM1.png'

figure(2)
hold on
plot(pcx1_timeM,pd4pcx1_atemp,'b.-')
plot(pcx2_timeM,pd4pcx2_atemp,'g.-')
plot(pcx3_timeM,pd4pcx3_atemp,'r.-')
plot(pcx4_timeM,pd4pcx4_atemp,'c.-')
datetick('x','mm/dd','keepticks','keeplimits')
xlabel('Date')
ylabel('Percent Difference')
title('Percent Difference in Air Temperature between PacX Gliders and M1')
legend('Papa Mau','Benjamin','Piccard Maru','Fontaine Maru')
print -dpng 'C:\a_data\pac_crossing\pacxpdatvsM1.png'
return


%return
% 
 figure(3)
 hold on
 plot(pcx1_timeM,pcx1_wsM,'b.-')
 plot(pcx2_timeM,pcx2_wsM,'g.-')
 plot(pcx3_timeM,pcx3_wsM,'r.-')
 plot(pcx4_timeM,pcx4_wsM,'c.-')
 plot(timeM,wspd_wbrdM,'k.-')
 datetick('x','mm/dd','keepticks','keeplimits')
 xlabel('Date')
 ylabel('Wind Speed')
 title('Wind Speed from PacX Vehicles')
 legend('Papa Mau','Benjamin','Piccard Maru','Fontaine Maru','M1:46092')
% 
 figure(4)
 hold on
 plot(pcx1_timeM,pd4pcx1_ws,'b.-')
 plot(pcx2_timeM,pd4pcx2_ws,'g.-')
 plot(pcx3_timeM,pd4pcx3_ws,'r.-')
 plot(pcx4_timeM,pd4pcx4_ws,'c.-')
 datetick('x','mm/dd','keepticks','keeplimits')
 xlabel('Date')
 ylabel('Percent Difference')
 title('Percent Difference in Wind Speed between PacX Gliders and M1(NDBC 46092)')
 legend('Papa Mau','Benjamin','Piccard Maru','Fontaine Maru')
 print -dpng 'C:\a_data\pac_crossing\pacx_pdws_M1.png'
 return


% 
 figure(5)
 hold on
 plot(pcx1_timeM,pcx1_wdM,'b.-')
 plot(pcx2_timeM,pcx2_wdM,'g.-')
 plot(pcx3_timeM,pcx3_wdM,'r.-')
 plot(pcx4_timeM,pcx4_wdM,'c.-')
 plot(timeM,wdir_wbrdM,'k.-')
 datetick('x','mm/dd','keepticks','keeplimits')
 xlabel('Date')
 ylabel('Wind Direction')
 title('Wind Direction from PacX Vehicles')
 legend('Papa Mau','Benjamin','Piccard Maru','Fontaine Maru','M1:46092')
% 
 figure(6)
 hold on
 plot(pcx1_timeM,pd4pcx1_wd,'b.-')
 plot(pcx2_timeM,pd4pcx2_wd,'g.-')
 plot(pcx3_timeM,pd4pcx3_wd,'r.-')
 plot(pcx4_timeM,pd4pcx4_wd,'c.-')
 datetick('x','mm/dd','keepticks','keeplimits')
 xlabel('Date')
 ylabel('Percent Difference')
 title('Percent Difference in Wind Direction between PacX Gliders and M1 Wind Bird')
 legend('Papa Mau','Benjamin','Piccard Maru','Fontaine Maru')
 print -dpng 'C:\a_data\pac_crossing\pacx_pdwd_M1.png'
return



figure(1)
hold on
plot(pcx1_timeM,pcx1_wdM,'b.-')
plot(pcx2_timeM,pcx2_wdM,'g.-')
plot(pcx3_timeM,pcx3_wdM,'r.-')
plot(pcx4_timeM,pcx4_wdM,'c.-')
plot(timeM,awdir_sonicM,'k.-')
datetick('x','mm/dd','keepticks','keeplimits')
xlabel('Date')
ylabel('Wind Direction')
title('Wind Direction from PacX Vehicles')
legend('Papa Mau','Benjamin','Piccard Maru','Fontaine Maru','M1:46092')

figure(2)
hold on
plot(pcx1_timeM,pd24pcx1_wd,'b.-')
plot(pcx2_timeM,pd24pcx2_wd,'g.-')
plot(pcx3_timeM,pd24pcx3_wd,'r.-')
plot(pcx4_timeM,pd24pcx4_wd,'c.-')
datetick('x','mm/dd','keepticks','keeplimits')
xlabel('Date')
ylabel('Percent Difference')
title('Percent Difference in Wind Direction between PacX Vehicles and M1 Sonic Anemometer')
legend('Papa Mau','Benjamin','Piccard Maru','Fontaine Maru')

