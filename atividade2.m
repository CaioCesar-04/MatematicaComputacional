function atividade2()
  clc
  iteracoes = 1000;
  x0 = [1;1];
  tol = 1e-5;
  [todosX,todosY,cont]= newtonraphson(iteracoes,x0,tol);
 
  fprintf("A quantidade de interacoes foi: %5.5f\n",cont);
  fprintf("A raiz foi: %5.5f e %5.5f",todosX(cont,1),todosX(cont,2));
  fprintf(todosY(cont,1),todosY(cont,2));
endfunction

function [todosX,todosY,cont]= newtonraphson(iteracoes,x0,tol)
  todosX = zeros(iteracoes,2);
  todosY=zeros(iteracoes,2);
  
  for cont = 1:iteracoes
    x1 = x0 - inv(jacobiano(x0))*sistema(x0);
    todosY(cont,:)=sistema(x0);

    todosX(cont,:) = x1;
    if max(abs(x1-x0)) <= tol
      break
    endif
    x0=x1;
   
  endfor

  todosX = todosX(1:cont,:);
  todosY = todosY(1:cont,:)
  plot(todosX)
  plot(todosY)
 
endfunction

function y = sistema(x0) 
  x1 = x0(1);
  x2 = x0(2);
  y = [x1^3+4*x2^5-0.25;
       8.*x1.^2+16.*x2-8.*x1.*x2-5];
endfunction

function j = jacobiano(x0)
  x1 = x0(1);
  x2 = x0(2);
  j = [3.*x1^2 , 20.*x2^4;
        16.*x1-8.*x2, 16-8.*x1 ]; 
endfunction
