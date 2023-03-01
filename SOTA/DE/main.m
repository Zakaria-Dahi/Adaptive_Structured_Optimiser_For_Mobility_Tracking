%% Differential Evolution Algorithm used in Differential Evolution For Solving the Mobile Location Management
% Initialisation :  Performed according a probability of 50% = 0.5
% Mutation : it uses 0.5 as a probabilyt for the mutation
% Mutation Scheme :  it uses a DE/Rand/1/bin scheme
% Crossover : it uses 0.15 as crossover probability

%NB: I treat the whole population then I update it. I do not update the 
%individuals on the fly because It was not stated in the original paper (see title above)
%so I took reference on the original paper of 
%"Differential Evolution – A Simple and Efficient heuristic for Global Optimization over Continuous Spaces"

%% Author : Zakaria Abd El Moiz DAHI
%% University : Constantine 2, Algeria

clear all
%% --------------- Initialisation of POI Libs To Write Excel Files ----------------------------------------
% Add Java POI Libs to matlab javapath
javaaddpath('Jar/poi-3.8-20120326.jar');
javaaddpath('Jar/poi-ooxml-3.8-20120326.jar');
javaaddpath('Jar/poi-ooxml-schemas-3.8-20120326.jar');
javaaddpath('Jar/xmlbeans-2.3.0.jar');
javaaddpath('Jar/dom4j-1.6.1.jar');
javaaddpath('Jar/stax-api-1.0.1.jar');
%% -------------------- Starting the execution of the program ---------------------------------------------
for ind=[26,27]
%% -------------   Initialize the parameters of the experiments -------------------------------------------
%%%% -------------- The number of execution ------------------------------
global execution 
       execution = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
%%%% -------------- The number of evaluations ----------------------------
global fitness_eval 
       fitness_eval = [175000 175000 175000 175000 175000 175000 175000 175000 175000 175000 175000 175000 175000 175000 175000 175000 175000 175000 175000 175000 175000 175000 175000 175000 175000 175000 175000];
%% ------ Number of individuals contained in the population --------------
global  indiv
        indiv = 175;
%% Save the dimension of the individual (it corresponds to the size of the network)
global Dimension
       Network_size = size(Instance(ind));
       Dimension = Network_size(1);
%% Number of itterations 
global iter
       iter = fitness_eval(ind)/indiv;
%% Number of execution 
global Nexe
       Nexe = execution(ind);
%% Instances and neighbourhood of the network
global network 
       network = Instance(ind);
global neighbourhoud
       if ind == 1 || ind == 2 || ind == 3 || ind == 13 || ind == 16 ||  ind == 17
           neighbourhoud = neighbour(4);
       end
       if ind == 4 || ind == 5 || ind == 6 || ind == 14
           neighbourhoud = neighbour(6);
       end
       if ind == 7 || ind == 8 || ind == 9 || ind == 15
           neighbourhoud = neighbour(8);
       end
       if ind == 10 || ind == 11 || ind == 12
           neighbourhoud = neighbour(10);
       end
       if ind == 18 
          neighbourhoud =   neighbour(19);
       end
       if ind == 19
          neighbourhoud =   neighbour(63);
       end
       if ind == 20 
          neighbourhoud =   neighbour(99);
       end
       if ind == 21 
          neighbourhoud =   neighbour(144);
       end
       if ind == 22 
          neighbourhoud =   neighbour(196);
       end
       if ind == 23 
          neighbourhoud =   neighbour(256);
       end
       if ind == 24
          neighbourhoud =   neighbour(324);
       end
       if ind == 25
          neighbourhoud =   neighbour(400);
       end
       if ind == 26 
          neighbourhoud =   neighbour(900);
       end
       if ind == 27
          neighbourhoud =   neighbour(900);
       end
%% ---- Saving the type and the dimension of the network used -------------
global instance 
      if ind == 1
          instance =  'Network_1_4x4';
      end
      if ind == 2
          instance =  'Network_2_4x4';       
      end
      if ind == 3
          instance =  'Network_3_4x4';         
      end
      if ind == 4
          instance =  'Network_1_6x6';         
      end
      if ind == 5
          instance =  'Network_2_6x6';         
      end
      if ind == 6
          instance =  'Network_3_6x6';         
      end
      if ind == 7
          instance =  'Network_1_8x8';         
      end
      if ind == 8
          instance =  'Network_2_8x8';
      end
      if ind == 9
          instance =  'Network_3_8x8';          
      end
      if ind == 10
          instance =  'Network_1_10x10';         
      end
      if ind == 11
          instance =  'Network_2_10x10';          
      end      
      if ind == 12
          instance =  'Network_3_10x10';
      end
      if ind == 13
          instance =  'Network_4_4x4';         
      end
      if ind == 14
          instance =  'Network_4_6x6';          
      end      
      if ind == 15
          instance =  'Network_4_8x8';
      end
      if ind == 16
          instance =  'Network_5_4x4';
      end
      if ind == 17
          instance =  'Network_6_4x4';
      end
      if ind == 18
          instance =  'Network_19_Cells';
      end
      if ind == 19
          instance =  'Network_7x9_Cells';
      end
      if ind == 20
          instance =  'Network_9x11_Cells';
      end
      if ind == 21
          instance =  'Network_12x12_Cells';
      end
      if ind == 22
          instance =  'Network_14x14_Cells';
      end
      if ind == 23
          instance =  'Network_16x16_Cells';
      end
      if ind == 24
          instance =  'Network_18x18_Cells';
      end
      if ind == 25
          instance =  'Network_20x20_Cells';
      end
      if ind == 26
          instance =  'Network_1_30x30_Cells';
      end
      if ind == 27
          instance =  'Network_2_30x30_Cells';
      end
%% Prameters of the Differential Evolution Algorithm  ----------------------
   % Defines the probability according which the genes in the initial population are set to reporting and non-reporting cells.
   global Prob
          Prob = 0.5;
   % Defines the probability of crossover
   global Cr 
          Cr = 0.15;
   % Defines the probability of Mutation
   global F
          F = 0.5;
%% variable to save for each execution  ----------------------
     %%%%   Fitness of the best individual reach after the end of all the ietteration 
     global ALL_EXECUTION
            ALL_EXECUTION = [];
     %%%% Save all the execution Time per run 
     global ALL_TIME
            ALL_TIME = [];
     %%%%% save all the best fitnesses through the generations
     global ALL_FITNESSES
            ALL_FITNESSES = [];
     %%%%% save all the itterations where the fitness value where extracted
     global ALL_ITTERATIONS
            ALL_ITTERATIONS = [];
     %%%% Mean of all the fitness reached  
     global moy
            moy =0;
     %%%% Standard deviation of the fitness reached 
     global ecart 
            ecart = 0;
     %%%% to save all the information relative to the experiment 
     global vect_one 
            vect_one = [];
     global vect_two
            vect_two = [];
     %%%% to save to best individual all along the NEXE execution 
     global FITNESS_GBEST
            FITNESS_GBEST = 1000000000000000000000000000000000000; %% It is made like this to be sure that no intial fitness is higher enough to keep it
     %%%% to save the best individual all along the Nexe exveution 
     global GBEST_ALL
            GBEST_ALL = [];
%% ------------------------------------------------------------------------
for exe=1:Nexe
%% ----- Change the seed of the Mersenne Twister Random Generator ---------
rng shuffle
% ------------------------------------------------------------------------
ti = 0;
tic
%% variable used during the calcul ---------------------------------------
     %%% Vector conaiting the fitness of all individuals of the population 
     global fit
            fit = [];
     %%% Vector containing the best individual so far 
     global gbest
            gbest = [];
     %%%% The population 
     global population
            population = [];
     %%%% Save The Produced Population 
     global population_offsrings
            population_offsrings = [];    
     %%%% Save The Fitness of the Produced Population 
     global fit_offsrings
            fit_offsrings = [];           
     %%% To save the itteration and the corresponding fitness value of this itteration (fitness evauation)
     ALL_FITNESSES = [];
     ALL_ITTERATIONS = [];
%% ------------ Generate the intial population ---------------------
population = single(Ini_Pop(indiv,Dimension,Prob));
% ------------------------------------------------------------------
%% --- Compute the initial fitnesses for the initial population ----
for w=1:indiv
    result  = RC_Function(population(w,:),Dimension,network,neighbourhoud);
    fit = [fit , result];
end
% ------------------------------------------------------------------------
%% -- calculate the best individual (it's index , it's fitness and ..) ---
[bestFit,indbest] = min(fit);
gbest = population(indbest,:);
ALL_FITNESSES = [ALL_FITNESSES min(fit)]; 
ALL_ITTERATIONS = [ALL_ITTERATIONS indiv];
%% -----------------------------------------------------------------------
for it=2:iter % --------- itteration loop  --------------------------
%% -------------- Initialise the Newly Produced Offsprings/Fitnesses
population_offsrings = single(zeros(indiv,Dimension));  
fit_offsrings = []; 
%% ************************ Apply The Evolution Differential Mechanism ****************************
for w=1:indiv
             %% ------------ Perform the mutation of the DE according to DE/rand/1/bin ------------
             parents = randi(indiv,1,3);
             testing = find(parents == w);
             % ----- verify that wedid not select the individual itself --------
             while isempty(testing) == 0
                 parents = randi(indiv,1,3);
                 testing = find(parents == w);
             end
             % ------------------------ Find if there is replicate  ------------
             uniqueX = unique(parents); 
             % ----- verify that they are not all the same element -------------
             while length(uniqueX) == 1
                 parents = randi(indiv,1,3);
                 testing = find(parents == w);
                 % ----- verify that wedid not select the individual itself -----
                 while isempty(testing) == 0
                     parents = randi(indiv,1,3);
                     testing = find(parents == w);
                 end
                 % ------------------------ Find if there is replicate  ---------
                 uniqueX = unique(parents);
             end
             countOfX = hist(parents,uniqueX);
             indexToRepeatedValue = (countOfX~=1);
             repeatedValues = uniqueX(indexToRepeatedValue);
             numberOfAppearancesOfRepeatedValues = countOfX(indexToRepeatedValue);
             %  -------- If the test fails reselect three new individuals ----------
             while isempty(numberOfAppearancesOfRepeatedValues) == 0 
                 parents = randi(indiv,1,3);
                 testing = find(parents == w);
                 % ----- verify that wedid not select the individual itself ---------
                 while isempty(testing) == 0
                     parents = randi(indiv,1,3);
                     testing = find(parents == w);
                 end
                 uniqueX = unique(parents);
                 %  -------- If the test fails reselect three new individuals ----
                 while length(uniqueX) == 1
                     parents = randi(indiv,1,3);
                     testing = find(parents == w);
                     % ----- verify that wedid not select the individual itself --
                     while isempty(testing) == 0
                         parents = randi(indiv,1,3);
                         testing = find(parents == w);
                     end
                     % ------------------------ Find if there is replicate  ------
                     uniqueX = unique(parents);
                 end
                 countOfX = hist(parents,uniqueX);
                 indexToRepeatedValue = (countOfX~=1);
                 repeatedValues = uniqueX(indexToRepeatedValue);
                 numberOfAppearancesOfRepeatedValues = countOfX(indexToRepeatedValue);
             end
             % -------------- Create the first Mutatnt Individual -------------------
                      population_offsrings(w,:) =  population(parents(1),:) + F *(population(parents(2),:) - population(parents(3),:));
             %% ----------- Map the real-valued solution into binary coded one -----------
                   zeros_ind = find(population_offsrings(w,:) < 0.5);
                   ones_ind  = find(population_offsrings(w,:) >= 0.5);
                   population_offsrings(w,ones_ind) = 1;
                   population_offsrings(w,zeros_ind) = 0;
             %% ------------ Perform the Crossover -------------------------------------------------------------------------
                   test = (rand(1,Dimension) <= Cr);
                   if isempty(find(test == 0)) == 0
                       population_offsrings(w,find(test == 0)) =  population(w,find(test == 0));
                   end
             %% ---------- Test if the newly produced offspring is a feasible solution -------------------------------------
             if isequal(population_offsrings(w,:),zeros(1,Dimension)) == 1
                 population_offsrings(w,:) =  population(w,:);
             end
end
%% *************** Evaluate the newly produced offsprings **********************************
for w=1:indiv
    result = RC_Function(population_offsrings(w,:),Dimension,network,neighbourhoud);
    fit_offsrings = [fit_offsrings,result];
end
%% *****************************  Update the population **************************************
for w=1:indiv
    if fit(w) > fit_offsrings(w)
       fit(w) =  fit_offsrings(w);
       population(w,:) = population_offsrings(w,:);
    end
end
%% ------------calculate the new best individual --------------------
[bestFit,indbest] = min(fit);
gbest = population(indbest,:);
fitness_best = fit(indbest);
ALL_FITNESSES = [ALL_FITNESSES fitness_best]
ALL_ITTERATIONS = [ALL_ITTERATIONS (it*indiv)];
end %-------------- end of the loop t=1:iter-------------------------------
if FITNESS_GBEST > fitness_best
FITNESS_GBEST = fitness_best;
GBEST_ALL = gbest;
end
ALL_EXECUTION = [ALL_EXECUTION fitness_best];
oo = toc;
ti = ti + oo;
ALL_TIME = [ALL_TIME ti];
end %% ----------- end of the loop of execution ---------------------------
%% ----  Writing the result -----------------------------------------------
moy =  mean(ALL_EXECUTION);
ecart = std (ALL_EXECUTION);
datte = mat2cell(date);
timee =  num2str(sum(ALL_TIME));
timme =  mat2cell(timee);
%% ---- Writing on Excel File ---------------------------------------------------------------------------------------------
vect_one = [datte Nexe it indiv Dimension instance timme mean(ALL_TIME) std(ALL_TIME)  min(ALL_EXECUTION) max(ALL_EXECUTION) moy ecart];

headers = {'date', 'Nbr_Execution','Nbr_Fitness_Evaluations','Nbr_Individual','Dimension (cells)','Instance','Execution_Time','Mean','Std','Best','Worst','Mean','Std'};
name = strcat(instance,'.xls');
xlwrite(name,[headers;vect_one],1);
%% --- Recording the results obtained by the best individual  -------------------------------
datee =  num2str(date);
result = Gbest_Show(GBEST_ALL,Dimension,network,neighbourhoud);
vect_two = [datte result(1) result(2) result(3)];
headers = {'date','Fitness','Update Location Cost','Paging Cost'};
xlwrite(name,[headers;vect_two],2);
%% ---- Recording The Reporting Cells ID ------------------------------------------------------
vect_two = [cell2mat(result(4))];
headers = {'Reporting Cell'};
xlwrite(name,vect_two',3);
%% ---- Recording the ID of Non Reporting Cells -----------------------------------------------
vect_two = [cell2mat(result(5))];
headers = {'Non Reporting Cell'};
xlwrite(name,vect_two',4);
xlwrite(name,ALL_EXECUTION,6);
xlwrite(name,ALL_TIME,7);
xlwrite(name,transpose(ALL_FITNESSES),8);
xlwrite(name,transpose(ALL_ITTERATIONS),9);
end
%% I added this command because Daniel told me that if i don't add it it will ot escape and display the results of the run 
exit;
