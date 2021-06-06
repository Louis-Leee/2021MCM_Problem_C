clear all;
n=300; 
h=0.08441;
s=-0.07848;
t=0.08785;
w=0.08332;
load 555.dat
x=X555(:,1);y=X555(:,2);z=X555(:,3);
[X, Y, Z1]=griddata(x,y,z,linspace(min(x),max(x),n)',linspace(min(y),max(y)',n),'cubic');
 A=max(max(Z1));B=min(min(Z1));%A=A(1,1);B=B(1,1);
 Z=(Z1-B)./(A-B);
 Z=Z.*1000;
figure(1)

surf(X,Y,Z);
shading flat
n1=Z1./max(max(Z1));
n1(n1<0)=1;n1(n1>0.7)=1;
n1=1-n1;
nnd=n1;
T1=h.*(nnd);
% T=T1;
  T=mapminmax(T1,0,1);
 
%   pspread=0.85; 
pgrowth=0.0; 
ul=[n,1:n-1]; 
dr=[2:n,1];  
hang=[225 ];
lie=[90  ];
veg=2*ones(n); 
veg(hang,lie)=1 ;
for i=1:120
% e(i,1)=length(find(veg==0)); 
e(i,1)=1;g(i,1)=0;
if(e(i,1)>81000) 
break 
else 
    tt=mod(i,12);%一年的第几yue
  pspread=0.8+(normpdf(tt,6,4))
%    pspread=0.67+abs(0.1*sin(2*3.1416/720*(tt+100)))
h1=veg;  
h2=h1;  
h3=h2; 
h4=h3;  
h1(n,1:n)=0;  
h2(1:n,n)=0; 
h3(1:n,1)=0; 
h4(1,1:n)=0;  
sum=(h1(ul,:)==1)+(h2(:,ul)==1)+(h3(:,dr)==1)+(h4(dr,:)==1); 
sum1=((sum==1).*(1-(1-pspread))); 
sum2=((sum==2).*(1-(1-pspread)^2)); 
sum3=((sum==3).*(1-(1-pspread)^3));  
sum4=((sum==4).*(1-(1-pspread)^4)); 
% sum1=((sum==1).*sqrt(pspread)); 
% sum2=((sum==2).*sqrt(pspread)); 
% sum3=((sum==3).*sqrt(pspread));  
% sum4=((sum==4).*sqrt(pspread)); 
s=sum1+sum2+sum3+sum4;
veg=2*(veg==2)+4*(veg==4)-((veg==2)&((sum>0)&(rand(n,n)<s.*T)))+4*((veg==0|veg==1)&rand(n,n)<pgrowth);  
e(i,1)=length(find(veg==0));g(i,1)=length(find(veg==4));
[xx,yy]=find(veg==1);
zz=diag(Z(xx(:,1),yy(:,1)));
ini=diag(Z(hang,lie));
hold on;
xx=X(1,xx);
yy=Y(yy,1);
plot3(lie,hang,ini,'b.');
hold on;
plot3(yy,xx,zz,'r.');
[xxx,yyy]=find(veg==4);
zzz=diag(Z(xxx(:,1),yyy(:,1)));
xxx=X(1,xxx);
yyy=Y(yyy,1);

hold on;
plot3(yyy,xxx,zzz,'g.');

ylabel('y');
zlabel('Altitude');

drawnow
title(i)
end


end
% end
xlabel('Longitude');
ylabel('Latitude');
zlabel('Altitude');
figure(2)
surf(X,Y,T);%姒傜巼鍒嗗竷鍥?
xlabel('Longitude');
ylabel('Latitude');
title('Spread rate');
 shading interp;
%  figure(3)
 
%  contour(X,Y,T,10)%鐢?10鏉＄瓑楂樼嚎
%  colorbar;  
%  hold on;
%  plot(XX,YY,'g.')
set(get(colorbar,'Title'),'string','Altitude(m)');  
grid on; 
figure(4)
 contour(X,Y,Z,10)%鐢?10鏉＄瓑楂樼嚎
 hold on;
 [xx1,yy1]=find(veg==0);
 xx1=X(1,xx1);
yy1=Y(yy1,1);
 plot(yy1,xx1,'r.');
 hold on;
 [xxx,yyy]=find(veg==4);
xxx=X(1,xxx);
yyy=Y(yyy,1);

hold on;
plot(yyy,xxx,'g.');
%  plot(XX,YY,'g.');
 colorbar;  
set(get(colorbar,'Title'),'string','Altitude(m)');  
grid on; 
figure(5);
k=1:120;
plot(k,e);