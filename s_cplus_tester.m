A = importdata('Results_eta3.txt');

v_patches = A(:,2);
v_rain = A(:,3);
v_patches = v_patches/mean(v_patches);
v_rain = v_rain/mean(v_rain);
v_t = A(:,1);
plot(v_t,v_patches,'r',v_t,v_rain,'b')