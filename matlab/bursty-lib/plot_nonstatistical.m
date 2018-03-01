h1 = subplot(3, 1, [1 2]);
iP = 1;

n_c = find(abs(diff(ux)) > D/2);
n_c = [n_c'; n_c'+1];
n_c = [1; n_c(:); length(t)];
uxc = ux(n_c);
lxc = lx(n_c);
t_c = t(n_c);
%fill([t fliplr(t)], [lx; flipud(ux)]', 0.8*[1 1 1], 'EdgeColor','none');
fill([t_c fliplr(t_c)], [lxc; flipud(uxc)]', 0.8*[1 1 1], 'EdgeColor','none');

hold on;
%set(gca, 'ColorOrderIndex', 1);
h = plot(t, Y(:,:,iP), ...
         t, x, ...         
         t([1,end]), lvl(:,[1,end]), 'k-', tn, xn, 'r.');%, t, ux, t, lx);%, ...
hold off;

legend(h([Alen+1 1:Alen]), {'$x(t)$ (original)' kGuessAlgDesc{1} kRecoveryAlgDesc{2:end}}, ...
         'Location', 'Best', 'Interpreter', 'latex');
lvl_id = Alen+2;
set(h(lvl_id:lvl_id+size(lvl, 1)-1), 'Color', 0.8*[1 1 1]);

xlabel('$t$', 'Interpreter', 'latex');
ylabel('$x(t)$', 'Interpreter', 'latex');
%title(sprintf('Number of samples: %d', length(xn)));

xlim([0 N]);
ylim(1.1*[min(x), max(x)]);
%ylim([0,0.4]);

h2 = subplot(3, 1, 3);
plot(t, abs(Y(:,:,iP)-x*ones(1, Alen)));%, t, t*0+D/2, 'k:', t, t*0-D/2, 'k:');
grid minor
%hold on;
%text(2, 0.05, '$\Delta$', 'FontSize', 12, 'Interpreter', 'latex');
%hold off;
%legend(kRecoveryAlg{1:end}, 'Location', 'NorthEast');
xlabel('$t$', 'Interpreter', 'latex');
ylabel('$|e(t)|$', 'Interpreter', 'latex');
ylim([0,0.1]);
  

linkaxes([h1 h2], 'x');
%xlim([0 N/2]);

set(gcf,'color','w');

%{
EE = squeeze(E(1,1,1,:,1));
bar(1:length(kRecoveryAlg), EE);
set(gca,'XTickLabel', kRecoveryAlg);
set(gca,'FontSize',7)
grid minor;
%}
