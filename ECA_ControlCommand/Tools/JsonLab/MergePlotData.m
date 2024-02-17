function plot_data = MergePlotData(plot_data_1, plot_data_2)
% Merge deux structures de PlotData ensemble
%
% :usage: plot_data = MergePlotData(plot_data_1, plot_data_2)
%
% :param plot_data_1: Structure de PlotData
% :param plot_data_2: Structure de PlotData
%
% :returns:
%   * plot_data - structure de PlotData mergé des deux entrées

%% Verification entrées sont structure
Verify.IsA(plot_data_1,'struct');
Verify.IsA(plot_data_2,'struct');

%% Merge
list_of_fields = unique([fieldnames(plot_data_1); fieldnames(plot_data_2)]);

for i = 1:length(list_of_fields)
    field = list_of_fields{i};
    
    % Si un des fields n'éxiste pas dans l'autre, on le recopie simplement
    if ~isfield(plot_data_2,field)
        plot_data.(field) = plot_data_1.(field);
    elseif  ~isfield(plot_data_1,field)
        plot_data.(field) = plot_data_2.(field);
    else
        % Sanity check
        Verify.IsA(plot_data_1.(field),'PlotData');
        Verify.IsA(plot_data_2.(field),'PlotData');
        
        % On recopie la PlotData de plot_data_1 et on change X et Y
        plot_data.(field) = PlotData([],[],field);
        plot_data.(field).Copy(plot_data_1.(field));
        
        plot_data.(field).X = [plot_data_1.(field).X; plot_data_2.(field).X];
        plot_data.(field).Y = [plot_data_1.(field).Y; plot_data_2.(field).Y];
        
        [~,x_sort]=sort(plot_data.(field).X);
        plot_data.(field).Y = plot_data.(field).Y(x_sort);
    end
end
end