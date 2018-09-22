function [ res ] = function_model_for_surfc( x1, x2, in, noisy_out )
%FUNCTION_MODEL_FOR_SURFC Summary of this function goes here
%   Detailed explanation goes here

for i=1:length(x1)
    for j=1:length(x1)
        res(i,j) =  sum((x1(i,j).*in + x2(i,j) - noisy_out).^2);
%         res(i,j) =  x1(i,j)^2 + x2(i,j)^2 + 2;
    end
end


end

