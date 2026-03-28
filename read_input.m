function [Xo Yo Zo Uo Vo Wo] = read_input(filename,sat_id)
% READ_INPUT reads the data from the 'filename' input and assigns the data
% to the respective components in the initial postion (Xo,Yo,Zo) in meters, 
% and initial velocity components (Uo, Vo, Wo) in meters per second.
% Call format: [Xo, Yo, Zo, Uo, Vo, Wo] = read_input(inputfile, sat_id)

input_data = importdata(filename,',',2);

[row,col] = size(input_data.data);
if sat_id < 1 || sat_id > row 
    Xo = NaN;
    Yo = NaN;
    Zo = NaN;
    Uo = NaN;
    Vo = NaN;
    Wo = NaN;
    disp('Error: Satellite ID is Invalid')
else
    Xo = input_data.data(sat_id,2);
    Yo = input_data.data(sat_id,3);
    Zo = input_data.data(sat_id,4);
    Uo = input_data.data(sat_id,5);
    Vo = input_data.data(sat_id,6);
    Wo = input_data.data(sat_id,7);
end


end % read_input function 

