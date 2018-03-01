function [xl, n_p] = reconstructLinear(xn, tn, ux, lx, n, t)

N = length(t);
xl = zeros(1, N);

n_p = [];
if n(1) > 1
    xl(1:n(1)) = linspace((ux(1)+lx(1))/2, xn(1), n(1));
end
for nn = 1:length(tn)-1
    %if xn(nn) ~= xn(nn+1)
    if abs(xn(nn) - xn(nn+1)) > 0.01
        n_p = [n_p n(nn)];
        xl(n(nn):n(nn+1)) = linspace(xn(nn), xn(nn+1), n(nn+1)-n(nn)+1);
    else
        n_mid = round((n(nn)+n(nn+1))/2);
        n_p = [n_p n(nn) n_mid];
        xl_mid = (ux(n_mid)+lx(n_mid))/2;
        xl(n(nn):n_mid) = linspace(xn(nn), xl_mid, n_mid-n(nn)+1);
        xl(n_mid:n(nn+1)) = linspace(xl_mid, xn(nn+1), n(nn+1)-n_mid+1);
    end
end
if n(end) ~= N
    xl(n(end):N) = linspace(xn(end), (ux(end)+lx(end))/2, N-n(end)+1);
end
n_p = [n_p n(end)];
xl = xl(:);