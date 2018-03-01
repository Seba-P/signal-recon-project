function T = tsh(sinc_pos, evaluate_at)
% TSH(sinc_pos, evaluate_at) - time shifts matrix

if size(evaluate_at, 2) > 1
    evaluate_at = evaluate_at.';
end

T = zeros(length(evaluate_at), length(sinc_pos));
for i = 1:length(sinc_pos)
    T(:,i) = evaluate_at-sinc_pos(i);
end