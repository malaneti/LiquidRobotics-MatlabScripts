% pacxGPCTDvs46092.m
% script to plot CTD data from PacX vehicles during their stay at M1 in Monterey Bay
% Luke Beatman; 11/30/11


% str = urlread('http://www.ndbc.noaa.gov/data/realtime2/46092.txt');
% i4header = findstr('ft',str);
% str = str(i4header+3:end);
% str = strrep(str,' MM ',' NaN ');
% str = strrep(str,' MM',' NaN ');
% 
% data = str2num(str);
% year = data(:,1);
% month = data(:,2);
% day = data(:,3);
% hour = data(:,4);
% minute = data(:,5);
% time46092 = datenum(year,month,day,hour,minute,0);
% wdir = data(:,6);
% wspd = data(:,7);
% pressure = data(:,13);
% atemp = data(:,14);
% wtemp = data(:,15);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  read M1 ctd data
saldat = ncread('C:\a_data\pac_crossing\m1\ctd0001_m1.nc','Salinity');
saldat = reshape(saldat,1,56981);

tempdat = ncread('C:\a_data\pac_crossing\m1\ctd0001_m1.nc','Temperature');
tempdat = reshape(tempdat,1,56981);

depthdat = ncread('C:\a_data\pac_crossing\m1\ctd0001_m1.nc','NominalDepth');

esec4ctd = ncread('C:\a_data\pac_crossing\m1\ctd0001_m1.nc','esecs');
esecs4ctd = sec_date(esec4ctd);

ctdtime = datenum(esecs4ctd(:,1),esecs4ctd(:,2),esecs4ctd(:,3),esecs4ctd(:,4),esecs4ctd(:,5),esecs4ctd(:,6)); 
i = find(ctdtime >= datenum(2011,11,23,7,0,0) & ctdtime <= datenum(2011,12,9,6,0,0));
ctdtime = ctdtime(i);
tempdat = tempdat(i);
saldat = saldat(i);

% average M1 ctd data to hour intervals
m1_timevec = datevec(ctdtime);
hourL = datenum(2011,11,23,7,0,0);
count = 1;
while hourL < datenum(2011,12,9,6,0,0)
  timeL = datevec(hourL);
  i = find(m1_timevec(:,1) == timeL(1) & m1_timevec(:,2) == timeL(2) & m1_timevec(:,3) == timeL(3) & m1_timevec(:,4) == timeL(4));
  salM(count) = mean(saldat(i));
  timeM(count) = hourL;
  hourL = hourL + 1.00000001/24;
  count = count + 1;
end

% read latitude and longitude from m1 gps file
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






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  read M1 aanderaa oxy data
oxydat = ncread('C:\a_data\pac_crossing\m1\aanderaaoxy_m1.nc','Oxygen');
oxydat = reshape(oxydat,1,56955);


esecs4oxy = ncread('C:\a_data\pac_crossing\m1\aanderaaoxy_m1.nc','esecs');
esecs4oxy = reshape(esecs4oxy,1,56955);
esecs4oxy = sec_date(esecs4oxy);

temp4oxy = ncread('C:\a_data\pac_crossing\m1\aanderaaoxy_m1.nc','Temperature');
temp4oxy = reshape(temp4oxy,1,56955);


oxytime = datenum(esecs4oxy(:,1),esecs4oxy(:,2),esecs4oxy(:,3),esecs4oxy(:,4),esecs4oxy(:,5),esecs4oxy(:,6));

i = find(oxytime >= datenum(2011,11,23,7,0,0));
temp4oxy = temp4oxy(i+1:end);
oxytime = oxytime(i+1:end);
oxydat = oxydat(i+1:end);                      % oxygen data from M1 is in millimoles/L

oxydatM1_gpL = oxydat * (32/1000);                     % convert from millimoles/L to grams/L
oxyvol_1M = 0.082 * (temp4oxy + 273.15) * (760/835);   % convert from grams/L to milliliters/L using temps from aandera; calculate volume of one mole of Oxygen at T and P;  835 is a standard atm in mmHg(760) + 1 decibar pressure(75.006 mmHg)

oxyden_1M = 32./oxyvol_1M;
oxyM1_mLL = oxydatM1_gpL./oxyden_1M;


start = '2011-11-23 07:00:00';                                  % limit data to times when gliders are within 8km
stop = '2011-12-09 06:00:00';
dnum4start = datenum(2011,11,23,7,0,0);
dnum4stop = datenum(2011,12,9,6,0,0);

%% Wave Glider CTD data from database
ctd_pcx1 = ctddo_getdata(start,stop,'380');
ctd_pcx2 = ctddo_getdata(start,stop,'381');
ctd_pcx3 = ctddo_getdata(start,stop,'382');
ctd_pcx4 = ctddo_getdata(start,stop,'383');

pcx1_ctdtime = ctd_pcx1.absjday_float;
pcx2_ctdtime = ctd_pcx2.absjday_float;
pcx3_ctdtime = ctd_pcx3.absjday_float;
pcx4_ctdtime = ctd_pcx4.absjday_float;

pcx1_pres = ctd_pcx1.pres4float;
pcx2_pres = ctd_pcx2.pres4float;
pcx3_pres = ctd_pcx3.pres4float;
pcx4_pres = ctd_pcx4.pres4float;

pcx1_temp = ctd_pcx1.temp4float;
pcx2_temp = ctd_pcx2.temp4float;
pcx3_temp = ctd_pcx3.temp4float;
pcx4_temp = ctd_pcx4.temp4float;

pcx1_con = ctd_pcx1.cond4float;
pcx2_con = ctd_pcx2.cond4float;
pcx3_con = ctd_pcx3.cond4float;
pcx4_con = ctd_pcx4.cond4float;

pcx1_sal = ctd_pcx1.sal4float;
pcx2_sal = ctd_pcx2.sal4float;
pcx3_sal = ctd_pcx3.sal4float;
pcx4_sal = ctd_pcx4.sal4float;

pcx1_do = ctd_pcx1.do4float;
pcx2_do = ctd_pcx2.do4float;
pcx3_do = ctd_pcx3.do4float;
pcx4_do = ctd_pcx4.do4float;

pcx1_lat = ctd_pcx1.lat4float;
pcx2_lat = ctd_pcx2.lat4float;
pcx3_lat = ctd_pcx3.lat4float;
pcx4_lat = ctd_pcx4.lat4float;

pcx1_lon = ctd_pcx1.lon4float;
pcx2_lon = ctd_pcx2.lon4float;
pcx3_lon = ctd_pcx3.lon4float;
pcx4_lon = ctd_pcx4.lon4float;

pcx1_domLL = convertdo_pcx(pcx1_do,pcx1_temp,pcx1_pres,pcx1_sal,'0222');
pcx2_domLL = convertdo_pcx(pcx2_do,pcx2_temp,pcx2_pres,pcx2_sal,'0215');
pcx3_domLL = convertdo_pcx(pcx3_do,pcx3_temp,pcx3_pres,pcx3_sal,'0220');
pcx4_domLL = convertdo_pcx(pcx4_do,pcx4_temp,pcx4_pres,pcx4_sal,'0223');

% for j = 1:length(pcx1_lat)
%   pcx1_sd(j) = gcircle_(36.750,-122.020,pcx1_lat(j),pcx1_lon(j),0);
% end
% 
% for j = 1:length(pcx2_lat)
%   pcx2_sd(j) = gcircle_(pcx2_lat(j),pcx2_lon(j),36.750,-122.020);
% end
% 
% for j = 1:length(pcx3_lat)
%   pcx3_sd(j) = gcircle_(36.750,-122.020,pcx3_lat(j),pcx3_lon(j));
% end
% 
% for j = 1:length(pcx4_lat)
%   pcx4_sd(j) = gcircle_(36.750,-122.020,pcx4_lat(j),pcx4_lon(j));
% end
% 



% Calculate hourly averages of all data based on M1 ctd times
% average pcx1 ctd data to same hours as M1 data
m1times = datevec(timeM);
count = 1;
hourL = datenum(2011,11,23,7,0,0);
pcx1_timevec = datevec(pcx1_ctdtime);
pcx2_timevec = datevec(pcx2_ctdtime);
pcx3_timevec = datevec(pcx3_ctdtime);
pcx4_timevec = datevec(pcx4_ctdtime);
while hourL < datenum(2011,12,9,6,0,0)
  timeL = datevec(hourL)
  i4pcx1 = find(pcx1_timevec(:,1) == timeL(1) & pcx1_timevec(:,2) == timeL(2) & pcx1_timevec(:,3) == timeL(3) & pcx1_timevec(:,4) == timeL(4));
  pcx1_tempM(count) = mean(pcx1_temp(i4pcx1));
  pcx1_salM(count) = mean(pcx1_sal(i4pcx1));
  pcx1_timeM(count) = hourL;
  %pcx1_latM(count) = mean(pcx1_lat(i4pcx1));                get these from query of vehicle parsed outputs instead
  %pcx1_lonM(count) = mean(pcx1_lon(i4pcx1));
  
  i4pcx2 = find(pcx2_timevec(:,1) == timeL(1) & pcx2_timevec(:,2) == timeL(2) & pcx2_timevec(:,3) == timeL(3) & pcx2_timevec(:,4) == timeL(4));
  pcx2_tempM(count) = mean(pcx2_temp(i4pcx2));
  pcx2_salM(count) = mean(pcx2_sal(i4pcx2));
  pcx2_timeM(count) = hourL;
  %pcx2_latM(count) = mean(pcx2_lat(i4pcx2));
  %pcx2_lonM(count) = mean(pcx2_lon(i4pcx2));

  i4pcx3 = find(pcx3_timevec(:,1) == timeL(1) & pcx3_timevec(:,2) == timeL(2) & pcx3_timevec(:,3) == timeL(3) & pcx3_timevec(:,4) == timeL(4));
  pcx3_tempM(count) = mean(pcx3_temp(i4pcx3));
  pcx3_salM(count) = mean(pcx3_sal(i4pcx3));
  pcx3_timeM(count) = hourL;
  %pcx3_latM(count) = mean(pcx3_lat(i4pcx3));
  %pcx3_lonM(count) = mean(pcx3_lon(i4pcx3));

  i4pcx4 = find(pcx4_timevec(:,1) == timeL(1) & pcx4_timevec(:,2) == timeL(2) & pcx4_timevec(:,3) == timeL(3) & pcx4_timevec(:,4) == timeL(4));
  pcx4_tempM(count) = mean(pcx4_temp(i4pcx4));
  pcx4_salM(count) = mean(pcx4_sal(i4pcx4));
  pcx4_timeM(count) = hourL;
  %pcx4_latM(count) = mean(pcx4_lat(i4pcx4));
  %pcx4_lonM(count) = mean(pcx4_lon(i4pcx4));
  
  hourL = hourL + 1.00000001/24;
  count = count + 1;
end

% Extract lat and longitude data from vehicle parsed outputs query
vpodata_pcx1 = vpo_getdata('2011-11-23 07:00:00','2011-12-09 06:00:00','380');
vpots_pcx1 = vpodata_pcx1.vpo_TS;
vpolat_pcx1 = vpodata_pcx1.vpo_lat;
vpolon_pcx1 = vpodata_pcx1.vpo_lon;

vpodata_pcx2 = vpo_getdata('2011-11-23 07:00:00','2011-12-09 06:00:00','381');
vpots_pcx2 = vpodata_pcx2.vpo_TS;
vpolat_pcx2 = vpodata_pcx2.vpo_lat;
vpolon_pcx2 = vpodata_pcx2.vpo_lon;

vpodata_pcx3 = vpo_getdata('2011-11-23 07:00:00','2011-12-09 06:00:00','382');
vpots_pcx3 = vpodata_pcx3.vpo_TS;
vpolat_pcx3 = vpodata_pcx3.vpo_lat;
vpolon_pcx3 = vpodata_pcx3.vpo_lon;

vpodata_pcx4 = vpo_getdata('2011-11-23 07:00:00','2011-12-09 06:00:00','383');
vpots_pcx4 = vpodata_pcx4.vpo_TS;
vpolat_pcx4 = vpodata_pcx4.vpo_lat;
vpolon_pcx4 = vpodata_pcx4.vpo_lon;

hourL = datenum(2011,11,23,7,0,0);
pcx1_timevpo = datevec(vpots_pcx1);
pcx2_timevpo = datevec(vpots_pcx2);
pcx3_timevpo = datevec(vpots_pcx3);
pcx4_timevpo = datevec(vpots_pcx4);
count = 1;
while hourL < datenum(2011,12,9,6,0,0)
  timeL = datevec(hourL);
  i4pcx1 = find(pcx1_timevpo(:,1) == timeL(1) & pcx1_timevpo(:,2) == timeL(2) & pcx1_timevpo(:,3) == timeL(3) & pcx1_timevpo(:,4) == timeL(4));
  pcx1_latM(count) = mean(vpolat_pcx1(i4pcx1));          
  pcx1_lonM(count) = mean(vpolon_pcx1(i4pcx1));
  
  i4pcx2 = find(pcx2_timevpo(:,1) == timeL(1) & pcx2_timevpo(:,2) == timeL(2) & pcx2_timevpo(:,3) == timeL(3) & pcx2_timevpo(:,4) == timeL(4));
  pcx2_latM(count) = mean(vpolat_pcx2(i4pcx2));
  pcx2_lonM(count) = mean(vpolon_pcx2(i4pcx2));

  i4pcx3 = find(pcx3_timevpo(:,1) == timeL(1) & pcx3_timevpo(:,2) == timeL(2) & pcx3_timevpo(:,3) == timeL(3) & pcx3_timevpo(:,4) == timeL(4));
  pcx3_latM(count) = mean(vpolat_pcx3(i4pcx3));
  pcx3_lonM(count) = mean(vpolon_pcx3(i4pcx3));

  i4pcx4 = find(pcx4_timevpo(:,1) == timeL(1) & pcx4_timevpo(:,2) == timeL(2) & pcx4_timevpo(:,3) == timeL(3) & pcx4_timevpo(:,4) == timeL(4));
  pcx4_latM(count) = mean(vpolat_pcx4(i4pcx4));
  pcx4_lonM(count) = mean(vpolon_pcx4(i4pcx4));
  
  hourL = hourL + 1.00000001/24;
  count = count + 1;
end

% calculate seperation distance between vehicles and M1 position.
for j = 1:length(pcx1_latM)
    %pcx1_sd(j) = gcircle_(m1_latM(j),m1_lonM(j),pcx1_latM(j),pcx1_lonM(j),0)                % output is in nautical miles
    pcx1_sd(j) = pos2dist(m1_latM(j),m1_lonM(j),pcx1_latM(j),pcx1_lonM(j),1);               % output is in km
end
pcx1_sd =  pcx1_sd * .53995680346;                                                        % 1 kilometer = 0.539 956 803 46 mile [nautical, US]; from onlineconversion.com
i4pcx1sd = find(pcx1_sd < 1);

for j = 1:length(pcx2_latM)
    %pcx2_sd(j) = gcircle_(m1_latM(j),m1_lonM(j),pcx2_latM(j),pcx2_lonM(j),0);  
    pcx2_sd(j) = pos2dist(m1_latM(j),m1_lonM(j),pcx2_latM(j),pcx2_lonM(j),1);               % output is in km
end
pcx2_sd =  pcx2_sd * .53995680346;                                                        % 1 kilometer = 0.539 956 803 46 mile [nautical, US]; from onlineconversion.com
i4pcx2sd = find(pcx2_sd < 1);

for j = 1:length(pcx3_latM)
    %pcx3_sd(j) = gcircle_(m1_latM(j),m1_lonM(j),pcx3_latM(j),pcx3_lonM(j),0);  
    pcx3_sd(j) = pos2dist(m1_latM(j),m1_lonM(j),pcx3_latM(j),pcx3_lonM(j),1);               % output is in km
end
pcx3_sd =  pcx3_sd * .53995680346;                                                        % 1 kilometer = 0.539 956 803 46 mile [nautical, US]; from onlineconversion.com
i4pcx3sd = find(pcx3_sd < 1);

for j = 1:length(pcx4_latM)
    %pcx4_sd(j) = gcircle_(m1_latM(j),m1_lonM(j),pcx4_latM(j),pcx4_lonM(j),0);  
    pcx4_sd(j) = pos2dist(m1_latM(j),m1_lonM(j),pcx4_latM(j),pcx4_lonM(j),1);               % output is in km
end
pcx4_sd =  pcx4_sd * .53995680346;                                                        % 1 kilometer = 0.539 956 803 46 mile [nautical, US]; from onlineconversion.com
i4pcx4sd = find(pcx4_sd < 1);

% figure(1)
% hold on
% plot(pcx1_timeM,pcx1_sd,'b.-')
% plot(pcx2_timeM,pcx2_sd,'g.-')
% plot(pcx3_timeM,pcx3_sd,'r.-')
% plot(pcx4_timeM,pcx4_sd,'c.-')
% title('Separation Distance between PacX Gliders and M1(NDBC 46092)')
% xlabel('Date')
% ylabel('Separation Distance(nautical miles)')
% legend('Papa Mau','Benjamin','Piccard Maru','Fontaine Maru','location','SouthEast')
% datetick('x',6,'keepticks','keeplimits')
%return



% calculate percent differences between gliders and M1 for salinity
difpcx14sal = pcx1_salM - salM;
avepcx14sal = (pcx1_salM + salM)/2;
pd4pcx1_sal = abs(difpcx14sal./avepcx14sal) * 100;

difpcx24sal = pcx2_salM - salM;
avepcx24sal = (pcx2_salM + salM)/2;
pd4pcx2_sal = abs(difpcx24sal./avepcx24sal) * 100;

difpcx34sal = pcx3_salM - salM;
avepcx34sal = (pcx3_salM + salM)/2;
pd4pcx3_sal = abs(difpcx34sal./avepcx34sal) * 100;

difpcx44sal = pcx4_salM - salM;
avepcx44sal = (pcx4_salM + salM)/2;
pd4pcx4_sal = abs(difpcx44sal./avepcx44sal) * 100;

% calculate percent differences between gliders and M1 for temperature
difpcx14temp = pcx1_tempM - tempM;
avepcx14temp = (pcx1_tempM + tempM)/2;
pd4pcx1_temp = abs(difpcx14temp./avepcx14temp) * 100;

difpcx24temp = pcx2_tempM - tempM;
avepcx24temp = (pcx2_tempM + tempM)/2;
pd4pcx2_temp = abs(difpcx24temp./avepcx24temp) * 100;

difpcx34temp = pcx3_tempM - tempM;
avepcx34temp = (pcx3_tempM + tempM)/2;
pd4pcx3_temp = abs(difpcx34temp./avepcx34temp) * 100;

difpcx44temp = pcx4_tempM - tempM;
avepcx44temp = (pcx4_tempM + tempM)/2;
pd4pcx4_temp = abs(difpcx44temp./avepcx44temp) * 100;

return


% create images for data report
% figure(1)
% title('Salinity from PacX Gliders and M1(NDBC 46092)')
% xlabel('Date')
% ylabel('Salinity(PSU)')
% hold on
% ylim([32.7 33.5])
% plot(timeM,salM,'k.-')
% plot(pcx1_timeM,pcx1_salM,'b.-')
% plot(pcx2_timeM,pcx2_salM,'g.-')
% plot(pcx3_timeM,pcx3_salM,'r.-')
% plot(pcx4_timeM,pcx4_salM,'c.-')
% datetick('x',6,'keepticks','keeplimits')
% legend('M1','Papa Mau','Benjamin','Piccard Maru','Fontaine Maru','location','SouthEast')
% print -dpng 'C:\a_data\pac_crossing\pacxsalvsM1_1.png'
% 
% figure(2)
title('Percent Difference in Salinity between PacX Gliders and M1(NDBC 46092)')
xlabel('Date')
ylabel('Percent Difference')
hold on
plot(pcx1_timeM,pd4pcx1_sal,'b.-')
plot(pcx2_timeM,pd4pcx2_sal,'g.-')
plot(pcx3_timeM,pd4pcx3_sal,'r.-')
plot(pcx4_timeM,pd4pcx4_sal,'c.-')
datetick('x',6,'keepticks','keeplimits')
legend('Papa Mau','Benjamin','Piccard Maru','Fontaine Maru','location','NorthWest')
% print -dpng 'C:\a_data\pac_crossing\pacxsalvsM1_2.png'
% 
% figure(3)
% title('Temperature from PacX Gliders and M1(NDBC 46092)')
% xlabel('Date')
% ylabel('Temperature(degrees C)')
% hold on
% %ylim([32.7 33.5])
% plot(timeM,tempM,'k.-')
% plot(pcx1_timeM,pcx1_tempM,'b.-')
% plot(pcx2_timeM,pcx2_tempM,'g.-')
% plot(pcx3_timeM,pcx3_tempM,'r.-')
% plot(pcx4_timeM,pcx4_tempM,'c.-')
% datetick('x',6,'keepticks','keeplimits')
% legend('M1','Papa Mau','Benjamin','Piccard Maru','Fontaine Maru','location','SouthWest')
% print -dpng 'C:\a_data\pac_crossing\pacxtempvsM1_1.png'
% 
% figure(4)
% title('Percent Difference in Temperature between PacX Gliders and M1(NDBC 46092)')
% xlabel('Date')
% ylabel('Percent Difference')
% hold on
% plot(pcx1_timeM,pd4pcx1_temp,'b.-')
% plot(pcx2_timeM,pd4pcx2_temp,'g.-')
% plot(pcx3_timeM,pd4pcx3_temp,'r.-')
% plot(pcx4_timeM,pd4pcx4_temp,'c.-')
% datetick('x',6,'keepticks','keeplimits')
% legend('Papa Mau','Benjamin','Piccard Maru','Fontaine Maru','location','NorthWest')
% print -dpng 'C:\a_data\pac_crossing\pacxtempvsM1_2.png'

figure(1)
plot(oxytime,oxyM1_mLL,'k.-')
hold on
plot(pcx1_ctdtime,pcx1_domLL,'b.-')
plot(pcx2_ctdtime,pcx2_domLL,'g.-')
plot(pcx3_ctdtime,pcx3_domLL,'r.-')
plot(pcx4_ctdtime,pcx4_domLL,'c.-')
title('Dissolved Oxygen from PacX Gliders and M1(NDBC 46092)')
xlabel('Date')
ylabel('Dissolved Oxygen(Milliliters/Liter)')
datetick('x',6,'keepticks','keeplimits')
legend('M1 Aanderaa','Papa Mau','Benjamin','Piccard Maru','Fontaine Maru')
box off
print -dpng 'C:\a_data\pac_crossing\pacxdovsM1_2.png'
return
