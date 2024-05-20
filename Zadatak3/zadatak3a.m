%Tablica istinitosti
%Port: S A B     
s  = [ 0 0 0;       
       0 0 1;
       0 1 0;
       0 1 1;
       1 0 0;
       1 0 1;
       1 1 0;
       1 1 1];
%Port: Out   
t = [0; 0; 1; 1; 0; 1; 0; 1;];

%Uvecavamo trening skup
ss_MUX = [s; s; s; s; s];
tt_MUX = [t; t; t; t; t];
ss_MUX = logical(ss_MUX);
tt_MUX = logical(tt_MUX);





