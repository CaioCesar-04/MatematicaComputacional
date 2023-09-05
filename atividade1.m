%Encontre a raiz de 𝑓(𝑥) = 𝑥^3 − 2𝑥^2 + 𝑥 − 0,275 no intervalo 1,0 ≤ 𝑥 ≤ 1,5 utilizando o Método da Bissecção
%com, no máximo, 1000 iterações. Quantas iterações foram necessárias até a convergência?
%Resposta: 1,437 para uma tolerância de 10^−5
function atividade1()
  clc;
  xl=1.0;
  xu=1.5;
  contMax=1000;
  tolerancia=1e-5;
  [xr,xTotalIter,fxTotalIter] = bissecao(xl,xu,contMax,tolerancia);
  fprintf("A raiz é: %.5f",xr);
  plotaGraficoConvergencia(xTotalIter,fxTotalIter);
  plotaGrafico(xl,xu,xTotalIter,fxTotalIter);


endfunction

function [xr,xTotalIter,fxTotalIter]=bissecao(xl,xu,contMax,tolerancia)
  xrold=NaN;
  xTotalIter=zeros(contMax,1);
  fxTotalIter=zeros(contMax,1);
## Verifica se o intervalo esta na forma f(xl)f(xu) < 0
  if funcao(xl)*funcao(xu) < 0

    for cont=1:contMax
    ##  Calculo da estimativa da raiz
        xr=(xl+xu)/2;
##      Armazena o calor de x em todas as interacoes
        xTotalIter(cont)=xr;
    ##  Calculo para descobrir a metade(direita ou esquerda) onde a raiz está de acordo com as comparações
        fxTotalIter(cont)=funcao(xr);
        result=funcao(xl) * funcao(xr);
        if result<0
          xu=xr;
        elseif result>0
            xl=xr;
        else
##            reduz o vetor para o tamanho correto de acordo com a quantidade interações
            xTotalIter= xTotalIter(1:cont);
            fxTotalIter=fxTotalIter(1:cont);
            break
        endif
##      Detecta convergencia
        if abs(xr-xrold)<= tolerancia
              xTotalIter= xTotalIter(1:cont);
              fxTotalIter=fxTotalIter(1:cont);
              break
        endif
        xrold=xr;
     endfor

     fprintf("A quantidade de interacoes foi: %5.5f",cont);
   else
     fprintf("O intervalo nao esta na forma de f (xl)f(xu) < 0");

   endif

endfunction

function plotaGrafico(xl,xu,xTotalIter,fxTotalIter)
##  Calcula o intervalo de xl a xu
  intervalo= xl:0.1:xu;
  y=zeros(size(intervalo));
  i=1;
  for xx=intervalo
    y(i)=funcao(xx);
    i=i+1;
  endfor
  for iter = 1:length(fxTotalIter)
    figure(1);
    plot(intervalo, y, 'linewidth', 3, 'linestyle', '-', 'color', 'black');
    hold on;
    plot(xTotalIter(iter), fxTotalIter(iter), 'marker', 'o', 'markersize', 10, 'linewidth', 3, 'color', 'red', 'markerfacecolor', 'red');
    hold off;
    set(gca, 'fontsize', 20);
    grid on;
    title(sprintf('Iteracoes: %i; f(%.6f) = %.6f', iter, xTotalIter(iter), fxTotalIter(iter)));
    legend("f(x)= x^3 - 2*x^2 + x - 0.275","Ponto da raiz da função");
    pause(0.3);
  end
endfunction

function plotaGraficoConvergencia(xTotalIter,fxTotalIter)
  numIter=size(xTotalIter,1);
  clf;
  figure(2);
  subplot(211);

  plot(1:numIter,xTotalIter,'color','k','linewidth',2);
  title("Grafico de convergencia em relacao xr");
  xlabel("Iteracoes");
  ylabel("xr");
  set(gca, 'fontsize', 12);
  grid('on');
  subplot(212);
  plot(1:numIter,fxTotalIter,'color','k','linewidth',2);
  title("Grafico de convergencia em relacao F(xr)");
  xlabel("Iteracoes");
  ylabel("F(xr)");
  set(gca, 'fontsize', 12);
  grid('on');
endfunction



function z = funcao(x)
  z = x^3 - 2*x^2 + x - 0.275;
end


