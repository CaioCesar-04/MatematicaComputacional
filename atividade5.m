function atividade5()
  clc;
xval=14;
m=2;
n=6;
x=[6,7,11,15,17,21,23,29,29,37,39];
y=[26,21,29,14,21,15,7,7,13,0,3];
if n>=m+1
   [a]=quadrados(x,y,m,n)
   A=a(:,1:(end-1));
   b=a(:,end);
   x=A\b;
   y=polinomio(xval,x)
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

function y=polinomio(xval,coef)
  y=0;
  for i=1:numel(coef)
    y=y+coef(i)*xval^(i-1);
  endfor
endfunction
