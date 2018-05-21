%
%THIS IS A WIZARD GENERATED FILE. DO NOT EDIT THIS FILE!
%
%---------------------------------------------------------------------------------------------------------
%This is a filter with fixed coefficients.
%This Model Only Support Single Channel Input Data.
%Please input:
%data vector: 		stimulation(1:n)

%    This Model Only Support FIR_WIDTH to 51 Bits

%FILTER PARAMETER
%Input Data Width: 16
%Interpolation Factor: 1
%Decimation Factor: 1
%FIR Width (Full Calculation Width Before Output Width Adjust) :16
%-----------------------------------------------------------------------------------------------------------
%MegaWizard Scaled Coefficient Values

function  output = soc_system_fir_filter_mlab(stimulation, bank);
 coef_matrix_in= [13,11,-2,5,-2,0,-5,-4,-8,-7,-7,-5,-3,0,4,8,10,12,13,11,8,3,-2,-8,-13,-18,-20,-20,-16,-11,-3,5,14,22,28,30,29,23,13,1,-11,-24,-35,-42,-44,-40,-30,-16,1,20,38,52,60,61,53,38,17,-7,-33,-57,-75,-84,-82,-70,-47,-16,18,53,84,105,115,109,89,55,12,-35,-82,-121,-147,-155,-144,-112,-64,-3,62,124,174,205,212,190,142,71,-14,-105,-189,-255,-293,-295,-258,-183,-78,48,180,300,393,443,439,375,253,82,-121,-336,-537,-694,-782,-776,-662,-431,-85,360,883,1453,2030,2575,3049,3416,3648,3727,3648,3416,3049,2575,2030,1453,883,360,-85,-431,-662,-776,-782,-694,-537,-336,-121,82,253,375,439,443,393,300,180,48,-78,-183,-258,-295,-293,-255,-189,-105,-14,71,142,190,212,205,174,124,62,-3,-64,-112,-144,-155,-147,-121,-82,-35,12,55,89,109,115,105,84,53,18,-16,-47,-70,-82,-84,-75,-57,-33,-7,17,38,53,61,60,52,38,20,1,-16,-30,-40,-44,-42,-35,-24,-11,1,13,23,29,30,28,22,14,5,-3,-11,-16,-20,-20,-18,-13,-8,-2,3,8,11,13,12,10,8,4,0,-3,-5,-7,-7,-8,-4,-5,0,-2,5,-2,11,13];
 INTER_FACTOR  = 1;
 DECI_FACTOR  =  1;
 MSB_RM  = 9;
 MSB_TYPE  = 1;
 LSB_RM  = 15;
 LSB_TYPE  = 0;
 FIR_WIDTH  = 16 + MSB_RM + LSB_RM;
 OUT_WIDTH  = 16 ;  %16
 DATA_WIDTH = 16;

  
 % check size of inputs. 
 DY = size(stimulation, 2);
 CY = size(coef_matrix_in, 2);
 if CY ~= DY * INTER_FACTOR
    fprintf('WARNING : coef_matrix size and input data size does not match\n');
 end 

 %fill coef_matrix to length of data with the latest coef set 
 if CY < DY * INTER_FACTOR
     coef_matrix = coef_matrix_in(bank + 1, :);
   end 
	  
 % check if input is integer 
       	int_sti=round(stimulation); 
	    T = (int_sti ~= stimulation); 
	    if (max(T)~=0) 
	        fprintf('WARNING : Integer Input Expected: Rounding Fractional Input to Nearest Integer...\n'); 
	    end 
	     
	    %Input overflow check 
        %set max/min for signed 
        maxdat = 2^(DATA_WIDTH-1)-1; 
        mindat = -maxdat-1; 

	    %Saturating Input Value 
	    a=find(int_sti>maxdat); 
	    b=find(int_sti<mindat); 
	    if (~isempty(a)|~isempty(b)) 
	 	    fprintf('WARNING : Input Amplitude Exceeds MAXIMUM/MINIMUM allowable values - saturating input values...\n'); 
	            lena = length (a); 
	            lenb = length (b); 
	            for i =1:lena 
	        	    fprintf('%d > %d \n', int_sti(a(i)), maxdat); 
			        int_sti(a(i)) = maxdat; 
		        end 
		    for i =1:lenb 
			    fprintf('%d < %d \n', int_sti(b(i)), mindat); 
			    int_sti(b(i)) = mindat; 
		    end 
	    end 
         
	    % Add interpolation 
   	    inter_sti = zeros(1, INTER_FACTOR * length(int_sti)); 
	    inter_sti(1:INTER_FACTOR:INTER_FACTOR * length(int_sti)) = int_sti; 
 
         
        for i = 1 : DY *INTER_FACTOR 
    	    coef_current = coef_matrix(i,:); 
            output_temp(i) = simp_adaptive (inter_sti, coef_current, i); 
        end 

	% Truncate output 
	len1 = length(output_temp); 
	 
	    switch  LSB_TYPE 
	    case 0 
	        %truncate 
            out_dec = bi_trunc_lsb(output_temp,LSB_RM,FIR_WIDTH); 
	    case 1 
	        %round 
            out_dec = bi_round(output_temp,LSB_RM, FIR_WIDTH); 
	    end 
         
 	    switch  MSB_TYPE 
	    case 0 
	        %truncate 
            out_dec = bi_trunc_msb(out_dec,MSB_RM,FIR_WIDTH-LSB_RM); 
	    case 1 
	        %round 
            out_dec = bi_satu(out_dec,MSB_RM, FIR_WIDTH-LSB_RM); 
	    end 
 	    
    	% choose decimation output in phase=DECI_FACTOR-1  
     	if(DECI_FACTOR == 1) 
     		output = out_dec; 
else
    output = out_dec(1:DECI_FACTOR:len1);
end

function[output, outindex] = simp_adaptive (int_sti, coef_current, data_index)

	%Simulation is the whole input sequence 
	%coef_current is the current coefficient set 
	%data_index gives the last data to use 
    % output is the sum of input and coef multiplication
	%outindex is the next data_index 
    
    coef_length = length(coef_current);
	data_length = length(int_sti); 
	 
	if (data_index > data_length) 
		fprintf('ERROR: DATA INDEX IS LARGER THAN DATA LENGTH!!!\n'); 
        return
	end 
    min_index = max(data_index - data_length, 1);
    max_index = min(data_index, coef_length);
	 
	outindex= data_index+1; 
    output = int_sti(data_index + 1 - (min_index:max_index)) * coef_current(min_index:max_index).';
 
function output = bi_round(data_in,LSB_RM,ORI_WIDTH)
	% LSB_RM is the bit to lose in LSB 
	% ORI_WIDTH is the original data width

	data = round (data_in / 2^LSB_RM);

	output = bi_satu(data,0,ORI_WIDTH - LSB_RM); 
	 
function output = bi_trunc_lsb(data_in,LSB_RM,ORI_WIDTH)
	% LSB_RM is the bit to lose in LSB 
	% ORI_WIDTH is the original data width 
	%2's complement system 
	output = bitshift((2^ORI_WIDTH*(data_in<0)) + (2^LSB_RM)*floor(data_in/(2^LSB_RM)), -LSB_RM) - (2^(ORI_WIDTH-LSB_RM)) *(data_in<0); 
	 
function output = bi_trunc_msb(data_in,MSB_RM,ORI_WIDTH)
	% MSB_RM is the bit to lose in LSB 
	% ORI_WIDTH is the original data width 
	%2's complement system 
	data = 2^ORI_WIDTH * (data_in < 0)+ data_in; 
	erase_num = 2^(ORI_WIDTH - MSB_RM) - 1; 
	data = bitand(data, erase_num); 
	output = data - 2^(ORI_WIDTH - MSB_RM)*(bitget(data,ORI_WIDTH - MSB_RM)); 
	 
function output = bi_satu(data_in,MSB_RM,ORI_WIDTH)
	% MSB_RM is the bit to lose in LSB 
	% ORI_WIDTH is the original data width 
	%2's complement system 
	maxdat = 2^(ORI_WIDTH - MSB_RM - 1)-1; 
	mindat = 2^(ORI_WIDTH - MSB_RM - 1)*(-1); 
    data_in(data_in > maxdat) = maxdat;
    data_in(data_in < mindat) = mindat;
	output = data_in; 
