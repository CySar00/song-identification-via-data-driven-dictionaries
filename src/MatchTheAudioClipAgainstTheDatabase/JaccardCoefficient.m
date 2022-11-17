function J= JaccardCoefficient(A,B)
 

 lengths = [length(A), length(B)];
 maxLength = max(lengths); 
 
 A1 = zeros(1, maxLength); 
 A1(1:length(A))=A; 
 
 B1 = zeros(1, maxLength); 
 B1(1:length(B))=B;

 
 J = 1 - sum(A1 & B1)/sum(A1 | B1)
end

