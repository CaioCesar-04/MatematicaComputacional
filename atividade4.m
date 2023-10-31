function atividade4()
  clc
  pontoOtimo=[-2.903534;
              -2.903534];
  x0=[-1;
      -1];
  tol=1e-3;
  iter=1000;
  alfa=0;
  flag=1
  
  if flag==0
    alfa=0.03;
    [x0,cont,todosX,todosFx] = Gradiente(x0,iter,tol,alfa);
    e=euclidiana(x0,pontoOtimo);
    fprintf("Ponto: %f\n",x0);
    fprintf("Quantidade de iteracoes: %f\n",cont);
    fprintf("Distancia euclidiana: %f",e);
    plotaGraficoConvergenciaGradiente(todosX,todosFx);
  else
    alfa=1.5;
    [x0,cont,todosX,todosFx] = Newton(x0,iter,tol,alfa);
    e=euclidiana(x0,pontoOtimo);
    fprintf("Ponto: %f\n",x0);
    fprintf("Quantidade de iteracoes: %f\n",cont);
    fprintf("Distancia euclidiana: %f",e);
    plotaGraficoConvergenciaNewton(todosX,todosFx);
  endif
endfunction

function [x0,cont,todosX,todosFx] = Gradiente(x0,iter,tol,alfa)
  todosX=zeros(iter,2);
  todosFx=zeros(iter,2);
  todosX(1,:)=x0;
  todosFx(1,:)=funcao(x0);
  for cont=1:iter
    x1=x0-(alfa*gradiente(x0));
    todosX(cont+1,:)=x1;
    todosFx(cont+1,:)=funcao(x1);
    if(max(abs(x1-x0)))<=tol
      x0=x1;
      break;
    endif
    x0=x1;
   endfor
    todosX=todosX(1:cont,:);
    todosFx=todosFx(1:cont,:);
endfunction

function [x0,cont,todosX,todosFx] = Newton(x0,iter,tol,alfa)
  todosX=zeros(iter,2);
  todosFx=zeros(iter,2);
  todosX(1,:)=x0;
  todosFx(1,:)=funcao(x0);
  for cont=1:iter
    x1=x0-alfa*inv(hessiana(x0))*gradiente(x0);
    todosX(cont+1,:)=x1;
    todosFx(cont+1,:)=funcao(x1);
    if(max(abs(x1-x0)))<=tol
      x0=x1;
      break;
    endif
    x0=x1;
  endfor
  todosX=todosX(1:cont,:);
  todosFx=todosFx(1:cont,:);
endfunction


function f=funcao(x0)
  x=x0(1);
  y=x0(2);
  f=0.5+((x.^4-16.*x^2+5.*x+y.^4-16.*y^2+5.*y)/2);
  endfunction
function e=euclidiana(x0,pontoOtimo)
  e=sqrt((x0(1)-pontoOtimo(1))^2 + (x0(2)-pontoOtimo(2))^2);
endfunction

function [g] = gradiente(x0)
  x=x0(1);
  y=x0(2);
  g = [2.*x^3-16.*x+(5/2);
       2.*y^3-16.*y+(5/2)];
endfunction

function h = hessiana(x0)
  x=x0(1);
  y=x0(2);
    h = [ 6.*x^2-16, 0;
           0,6.*y^2-16];
endfunction

function plotaGraficoConvergenciaGradiente(todosX,todosFx)
  numIter=size(todosX,1);
  clf;
  figure(1);
  subplot(211);
  plot(1:numIter,todosX(:,1),'color','k','linewidth',4);
  hold on;
  plot(1:numIter,todosX(:,2),'color','b','linewidth',2);
  hold off;
  title("Grafico de convergencia do Ponto no metodo Gradiente");
  xlabel("Iteracoes");
  ylabel("X");
  set(gca, 'fontsize', 12);
  grid('on');
  subplot(212);
  plot(1:numIter,todosFx(:,1),'color','k','linewidth',4);
  title("Grafico de convergencia em relacao F(x) no metodo Gradiente");
  xlabel("Iteracoes");
  ylabel("F(x)");
  set(gca, 'fontsize', 12);
  grid('on');
endfunction

function plotaGraficoConvergenciaNewton(todosX,todosFx)
  numIter=size(todosX,1);
  clf;
  figure(1);
  subplot(211);
  plot(1:numIter,todosX(:,1),'color','k','linewidth',2);
  hold on;
  plot(1:numIter,todosX(:,2),'color','b','linewidth',2);
  hold off;
  title("Grafico de convergencia do Ponto no metodo Newton");
  xlabel("Iteracoes");
  ylabel("X");
  set(gca, 'fontsize', 12);
  grid('on');
  subplot(212);
  plot(1:numIter,todosFx(:,1),'color','k','linewidth',2);
  title("Grafico de convergencia em relacao F(x) no metodo Newton");
  xlabel("Iteracoes");
  ylabel("F(x)");
  set(gca, 'fontsize', 12);
  grid('on');
endfunction

