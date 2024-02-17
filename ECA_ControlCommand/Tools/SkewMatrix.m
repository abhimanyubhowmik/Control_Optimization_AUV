function skew_matrix = SkewMatrix(input_matrix)
% Create the anti-symmetric matrix of the input vector
%
% :usage: skew_matrix = Fonct_Skew_Matrix(input_matrix)
%
% :param input_matrix: matrix to skew
%
% :returns:
%   * skew_matrix - skew of the input matrix

skew_matrix =    [   0       -input_matrix(3)   input_matrix(2)
    input_matrix(3)    0       -input_matrix(1)
    -input_matrix(2)   input_matrix(1)    0];
end