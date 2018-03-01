
colormap jet;
Results = zeros(Glen, Alen*3);

figure(1);
for iD = 1:Dlen
    for iG = 1:Glen
        iResults = 1;
        for iA = 1:Alen
            for iP = 1:length(kParam{iA})
                %{
                fprintf('Error %.4f, ',     mean(E(:,iD,iG,iA,iP)));
                fprintf('algorithm %s, ',   kRecoveryAlg{iA});
                fprintf('param=%f, ',       kParam{iA}{iP});
                fprintf('guess "%s", ',     kGuessAlg{iG});
                fprintf('delta=%f.\n',      DD(iD));
                %}
                Results(iG, iResults) = mean(E(:,iD,iG,iA,iP));
                iResults = iResults + 1;     
            end
        end % Alg loop
    end % initial guess loop
    subplot(1, 3, iD);
    bar(Results);
    set(gca,'XTickLabel',{'PW constant', 'PW linear', 'Warped BL    ', 'Smooth Warped BL'});
    title(sprintf('$\\Delta=%.2f$', DD(iD)), 'Interpreter', 'latex');
    hold on;
    plot([0.5 2.5], DD(iD)*[1 1], 'r--');
    hold off;
    grid on;
    grid minor;
    
    hl = legend('Guess', ...
           sprintf('I-POCS,  $M=%d$', kParam{2}{1}), ...
           sprintf('I-POCS,  $M=%d$', kParam{2}{2}), ...
           sprintf('I-POCS,  $M=%d$', kParam{2}{3}), ...
           'OS-POCS, $\varepsilon=10^{-2}$', ...
           'OS-POCS, $\varepsilon=10^{-3}$', ...
           'OS-POCS, $\varepsilon=10^{-4}$');
    set(hl, 'Location', 'South');
    set(hl, 'Interpreter', 'latex');
    ylim([0 1.1]*DD(iD));
    
    %{
    subplot(2, 3, iD+3);
    hist(Nsamp(:,iD));
    grid on;
    grid minor;
    %}
end % delta loop


figure(2);
%set(gca, 'ColorOrderIndex', 1);

hold off;
hold on;
h = [];
styles = {':', '-.', '--'};
for iD = 1:Dlen
    set(gca, 'ColorOrderIndex', iD);
    [~, Order(:,iD)] = sort(Nsamp(:,iD));
    iG = 2;
    iA = 2;
    iP = 2;        
    EE(:,iD) = squeeze(E(Order(:,iD),iD,iG,iA,iP));
    h = [h plot(Nsamp(Order(:,iD),iD), EE(:,iD), '.', [1 1e3], DD(iD)*[1 1])];
    set(h(end-1), 'Color', get(h(end), 'Color'));
    set(h(end), 'LineStyle', styles{iD});    
end % delta loop   
hold off;
legend(h([2, 4, 6]), ['\Delta=' num2str(DD(1))], ...
       ['\Delta=' num2str(DD(2))], ...
       ['\Delta=' num2str(DD(3))]);  
ylabel('Error');   
xlabel('Number of samples');
set(gca,'xscale','log');
set(gca,'yscale','log');
grid on;
grid minor;
ylim([5e-3 1e0]);
xlim([1e1 5e2]);

set(gcf,'color','w');