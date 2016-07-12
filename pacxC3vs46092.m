% pacxC3vs46092.m
% script to plot C3 data from PacX vehicles during their stay at M1 in Monterey Bay


% read wetstar fluorescence data from netCDF file
fldat = ncread('C:\a_data\pac_crossing\m1\wetstar_m1.nc','Fluorescence');
fldat = reshape(fldat,1,20178);


fl2dat = ncread('C:\a_data\pac_crossing\m1\wetstar_m1.nc','WETStar_data');
fl2dat = reshape(fl2dat,1,20178);


esecs4fl = ncread('C:\a_data\pac_crossing\m1\wetstar_m1.nc','esecs');
esecs4fl = reshape(esecs4fl,1,20178);
esecs4fl = sec_date(esecs4fl);
fltime = datenum(esecs4fl(:,1),esecs4fl(:,2),esecs4fl(:,3),esecs4fl(:,4),esecs4fl(:,5),esecs4fl(:,6));

i = find(fltime >= datenum(2011,11,20,0,0,0));
fltime = fltime(i+1:end);
fldat = fldat(i+1:end);
fldat = fldat/5;
fl2dat = fl2dat(i+1:end);


% Average M1 wetstar data to hourly intervals
timevec_m1 = datevec(fltime);
hourL = datenum(2011,11,23,7,0,0);
count = 1;
while hourL < datenum(2011,12,9,6,0,0)
  timeL = datevec(hourL);
  i = find(timevec_m1(:,1) == timeL(1) & timevec_m1(:,2) == timeL(2) & timevec_m1(:,3) == timeL(3) & timevec_m1(:,4) == timeL(4));
  m1chlaM(count) = mean(fldat(i));
  m1chlatimeM(count) = hourL;
  hourL = hourL + 1.00000001/24;
  count = count + 1;
end

[c31_pcx1,c32_pcx1,c33_pcx1] = bpc3_getdata('2011-11-20 00:00:00','2011-12-14 23:59:59','Papa Mau');
[c31_pcx2,c32_pcx2,c33_pcx2] = bpc3_getdata('2011-11-20 00:00:00','2011-12-14 23:59:59','Benjamin');
[c31_pcx3,c32_pcx3,c33_pcx3] = bpc3_getdata('2011-11-20 00:00:00','2011-12-14 23:59:59','Piccard Maru');
[c31_pcx4,c32_pcx4,c33_pcx4] = bpc3_getdata('2011-11-20 00:00:00','2011-12-14 23:59:59','Fontaine Maru');

pcx1_time = c31_pcx1.c31_absjday;
pcx2_time = c31_pcx2.c31_absjday;
pcx3_time = c31_pcx3.c31_absjday;
pcx4_time = c31_pcx4.c31_absjday;

pcx1_ch1 = c31_pcx1.c31_ch1/65535;
pcx2_ch1 = c31_pcx2.c31_ch1/65535;
pcx3_ch1 = c31_pcx3.c31_ch1/65535;
pcx4_ch1 = c31_pcx4.c31_ch1/65535;

pcx1_ch2 = c31_pcx1.c31_ch2/32768;
pcx2_ch2 = c31_pcx2.c31_ch2/32768;
pcx3_ch2 = c31_pcx3.c31_ch2/32768;
pcx4_ch2 = c31_pcx4.c31_ch2/32768;

pcx1_ch3 = c31_pcx1.c31_ch3/65535;
pcx2_ch3 = c31_pcx2.c31_ch3/65535;
pcx3_ch3 = c31_pcx3.c31_ch3/65535;
pcx4_ch3 = c31_pcx4.c31_ch3/65535;

pcx1_temp = c31_pcx1.c31_temp;
pcx2_temp = c31_pcx2.c31_temp;
pcx3_temp = c31_pcx3.c31_temp;
pcx4_temp = c31_pcx4.c31_temp;

% Calculate hourly averages of all C3 data
count = 1;
hourL = datenum(2011,11,23,7,0,0);
pcx1_timevec = datevec(pcx1_time);
pcx2_timevec = datevec(pcx2_time);
pcx3_timevec = datevec(pcx3_time);
pcx4_timevec = datevec(pcx4_time);
while hourL < datenum(2011,12,9,6,0,0)
  timeL = datevec(hourL)
  i4pcx1 = find(pcx1_timevec(:,1) == timeL(1) & pcx1_timevec(:,2) == timeL(2) & pcx1_timevec(:,3) == timeL(3) & pcx1_timevec(:,4) == timeL(4));
  pcx1_c3M(count) = mean(pcx1_ch2(i4pcx1));
  
  i4pcx2 = find(pcx2_timevec(:,1) == timeL(1) & pcx2_timevec(:,2) == timeL(2) & pcx2_timevec(:,3) == timeL(3) & pcx2_timevec(:,4) == timeL(4));
  pcx2_c3M(count) = mean(pcx2_ch2(i4pcx2));

  i4pcx3 = find(pcx3_timevec(:,1) == timeL(1) & pcx3_timevec(:,2) == timeL(2) & pcx3_timevec(:,3) == timeL(3) & pcx3_timevec(:,4) == timeL(4));
  pcx3_c3M(count) = mean(pcx3_ch2(i4pcx3));

  i4pcx4 = find(pcx4_timevec(:,1) == timeL(1) & pcx4_timevec(:,2) == timeL(2) & pcx4_timevec(:,3) == timeL(3) & pcx4_timevec(:,4) == timeL(4));
  pcx4_c3M(count) = mean(pcx4_ch2(i4pcx4));
  
  pcx_timeM(count) = hourL;
  hourL = hourL + 1.00000001/24;
  count = count + 1;
end

figure(1)
hold on 
plot(pcx_timeM,pcx1_c3M,'b.-')
plot(pcx_timeM,pcx2_c3M,'g.-')
plot(pcx_timeM,pcx3_c3M,'r.-')
plot(pcx_timeM,pcx4_c3M,'c.-')
plot(m1chlatimeM,m1chlaM,'k.-')
%plot(fltime,fl2dat,'y.-')
xlim([datenum(2011,12,4,0,0,0) datenum(2011,12,10,0,0,0)])
%ylim([0 0.05])
title('Chlorophyll-A Fluorescence from PacX Gliders and M1(NDBC 46092)')
xlabel('Date')
ylabel('Normalized RFU')
datetick('x','mm/dd','keepticks','keeplimits')
legend('Papa Mau','Benjamin','Piccard Maru','Fontaine Maru','M1 Wetstar','location','NorthWest')
print -dpng 'C:\a_data\pac_crossing\pacxC3vsM1_part.png'

return





