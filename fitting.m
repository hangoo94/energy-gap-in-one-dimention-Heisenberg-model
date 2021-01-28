function fitting(do_pbc, do_negative)
if do_pbc && ~do_negative
    data = csvread('data_pbc.csv.');
  elseif do_negative && ~do_pbc
    data = csvread('data_negative.csv');
  elseif do_pbc && do_negative
     data = csvread('data_negative_pbc.csv');
  else
    data = csvread('data.csv');
  end
x = 1./data(1:end,1);
y = data(1:end,2);

x_odd = 1./data(1:2:end,1);
y_odd = data(1:2:end,2);
x_even = 1./data(2:2:end,1);
y_even = data(2:2:end,2);

p_odd = polyfitZero(x_odd, y_odd, 2)
p_even  = polyfitZero(x_even, y_even, 2)

x_cont = linspace(0,0.5);

f_odd = polyval(p_odd, x_cont);
f_even = polyval(p_even, x_cont);

figure
plot(x_odd,y_odd+1,'ob')
hold on 
plot(x_even,y_even,'or')
hold on
plot(x_cont,f_odd+1,'b')
plot(x_cont,f_even,'r')
hold off
T = table(x_odd,y_odd,polyval(p_odd,x_odd),y_odd-polyval(p_odd,x_odd),'VariableNames',{'X','Y','Fit','FitError'});
end