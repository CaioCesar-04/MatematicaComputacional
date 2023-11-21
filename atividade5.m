function atividade5()
clc;
xval=14;
m=9;
n=10;
x=[6,7,11,15,17,21,23,29,37,39];
y=[26,21,29,14,21,15,7,13,0,3];
if n>=m+1
   [a]=quadrados(x,y,m,n);
   A=a(:,1:(end-1));
   b=a(:,end);
   coef=inv(A)*b;
   f=polinomio(xval,coef);
   [r,r2]=coeficientesR(x,y,coef);
   plotGrafico(x,y,f,xval,coef)
   fprintf("A ordem:%i\n",m);
   fprintf("O valor do polinomio em x=14:%.6f\n",f);
   fprintf("O valor de r2:%f\n",r2);
   fprintf("O valor de r:%f\n",r);
   fprintf("O valor do polinomio:");
   for i=1:m+1
     fprintf("%.6f*x^%i+",coef(i),i-1);
   endfor
endif

endfunction

function [a]=quadrados(x,y,m,n)

for i=1:m+1
  for j=1:i
    k=i+j-2;
    soma=0;
    for l=1:n
      soma=soma+x(l)^k;
    endfor
    a(i,j)=soma;
    a(j,i)=soma;
  endfor
  soma=0;
  for l=1:n
    soma=soma+y(l)*x(l)^(i-1);
  endfor
  a(i,m+2)=soma;
endfor
 
endfunction
function [r,r2]=coeficientesR(x,y,coef)
    st=0;
    sr=0;
    for cont = 1:length(x)
      sr=sr+(y(cont)-polinomio(x(cont),coef))^2;
      st=st+(y(cont)-mean(y))^2;
    endfor
    r2=(st-sr)/st;
    r=sqrt(r2);
endfunction

function y=polinomio(xval,coef)
  y=0;
  for i=1:numel(coef)
    y=y+coef(i)*xval^(i-1)
  endfor
endfunction
  
function plotGrafico(x,y,f,xval,coef)
  aux1=x(1):0.1:x(end);
  aux2=zeros(size(aux1));
  for cont=1:numel(aux1)
    aux2(cont)=polinomio(aux1(cont),coef);
  endfor
  figure(1);
  plot(aux1,aux2,'linewidth',2,'color','r');
  hold on 
  plot(x,y,'o','markerfacecolor','k','color','k');
  hold on
  plot(xval,f,'*','markerfacecolor','k','color','b')
  hold off
  set(gca,'fontsize',12);
  
endfunction
