% hold on
% for i = 1:1:50
%     a(i) = aprDrift{i}(1)*100;
% end
% plot(1:50,a,'r');
% plot(1:50,outliersDrift,'b');
% hold off

hold on
for i = 1:1:50
    a(i) = aprNoneDrift{i}(1);
end
plot(1:50,a,'r');
plot(1:50,outliersNoneDrift,'b');
hold off