b = fir1(500, 5/8000);
x = filter(b,1,filtered_data{1}.data{1});
figure,plot(x)
b = fir1(500, 1/8000);
x = filter(b,1,filtered_data{1}.data{1});
figure,plot(x)
figure,plot(filtered_data{1}.data{1})
hold on
plot(x(500:end), 'r')
plot(100*x(500:end), 'r')
