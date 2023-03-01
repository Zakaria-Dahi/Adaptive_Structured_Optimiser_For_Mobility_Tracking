% -- Synchronous Cellular Genetic Algorithm with static Narrow grid Using a Back Evolution of Pm --------
% Note: this code has been checked the 25/10/2017 at 13:04
clear all
%% -------- Initialisation of POI Libs -------------------------------------
% Add Java POI Libs to matlab javapath
javaaddpath('Jar/poi-3.8-20120326.jar');
javaaddpath('Jar/poi-ooxml-3.8-20120326.jar');
javaaddpath('Jar/poi-ooxml-schemas-3.8-20120326.jar');
javaaddpath('Jar/xmlbeans-2.3.0.jar');
javaaddpath('Jar/dom4j-1.6.1.jar');
javaaddpath('Jar/stax-api-1.0.1.jar');
%% -------------------- Starting the execution of the program --------------
for ind=1:12
%% -------------   Initialize the parameters of the experiments ------------
%% Save the best fitnesses reported by the state-of-the-art algorithm 
global state_of_the_art 
       state_of_the_art = [98535  97156 95038 173701 182331  174519 307695 287149  264204  385927 357368  370868];
%%%% -------------- The number of execution ------------------------------
global execution 
       execution = [1 1 1 1 1 1 1 1 1 1 1 1];
%% ------ Number of individuals contained in the population --------------
global  indiv
        indiv = 400;
%% Save the dimension of the individual (it corresponds to the size of the network)
global Dimension
       Network_size = size(Instance(ind));
       Dimension = Network_size(1);
%% Number of itterations 
global iter
       iter = 437;
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
%% -------- Prameters  of the dynamic cellular Genetic Algorithm  ------
   pcr = 1;  % By default I set it to 1 as recomended by Professor Alba
   pm = rand;  % choosed as default value to start because the paper did not mention it.
   global grid_x
          grid_x = 100;
   global grid_y 
          grid_y = 4;
%% variable to save for each execution  ----------------------
     % Fitness of the best individual reach after the end of all the ietteration 
     global ALL_EXECUTION
            ALL_EXECUTION = [];
     % Save all the execution Time per run 
     global ALL_TIME
            ALL_TIME = [];
     % save all the best fitnesses through the generations
     global ALL_FITNESSES
            ALL_FITNESSES = [];
     % save all the itterations where the fitness value where extracted
     global ALL_ITTERATIONS
            ALL_ITTERATIONS = [];
     % Mean of all the fitness reached  
     global moy
            moy =0;
     % Standard deviation of the fitness reached 
     global ecart 
            ecart = 0;
     % save all the information relative to the experiment 
     global vect_one 
            vect_one = [];
     global vect_two
            vect_two = [];
     % save to best individual all along the NEXE execution 
     global FITNESS_GBEST
            FITNESS_GBEST = 1000000000000000000000000000000000000;
     % save the best individual all along the Nexe exveution 
     global GBEST_ALL
            GBEST_ALL = [];
     %%% To save the number of execution needed to obtain the best result obtained by the state-of-the-art algorithms 
     global iter_needed 
            iter_needed = zeros(1,Nexe);
     %%% To save the time needed to obtain the best result obtained by the state-of-the-art algorithms 
     global time_needed 
            time_needed = zeros(1,Nexe);
%% ------------- Start of the execution loop -------------------------------
for exe=1:Nexe
%% ----- Change the seed of the Mersenne Twister Random Generator ----------
rng shuffle
% ------------------------------------------------------------------------
ti = 0;
tic
%% --- To reset The number Of Fitness Evolution ----------
it = 0;
%% variable used during the calcul ---------------------------------------
     % Vector conaiting the fitness of all individuals of the population 
     global fit
            fit = [];
     % Vector containing the best individual so far 
     global gbest
            gbest = [];
     % contain the index of the best individual so far 
     global indbest_one 
     % The population 
     global population
            population = [];
     % To save the itteration and the corresponding fitness value of this itteration (fitness evauation)
     ALL_FITNESSES = [];
     ALL_ITTERATIONS = [];
	 %%% To save the probability of mutation used during the execution -------------------
	 mutation_evo = [pm];
%% ------------ Generate the intial population ---------------------
population = single(Ini_Pop(indiv,Dimension));
% ------------------------------------------------------------------
%% ------ Compute the initial fitnesses for the initial population -------
for w=1:indiv
    result  = RC_Function(population(w,:),Dimension,network,neighbourhoud);
    fit = [fit , result];
end
% ------------------------------------------------------------------------
%% -- calculate the best individual (it's index , it's fitness and ..) ---
[bestFit_one,indbest_one] = min(fit);
gbest = population(indbest_one,:);
ALL_FITNESSES = [ALL_FITNESSES min(fit)]; 
ALL_ITTERATIONS = [ALL_ITTERATIONS indiv];
% -------------------------------------------------------------------------
for it=2:iter % --------- itteration loop  --------------------------------
%% -- Encreasing The Mutation Probability ---------------------------------
pm = (2 + ((Dimension-2)/(iter-1))*it)^(-1);
mutation_evo = [mutation_evo pm];
% --------------- Create the auxiliary population  ------------------------
futur_population = population;
futur_fit = fit;
% -------------------------------------------------------------------------
for i=0:(grid_y - 1)
    for j=1:grid_x
        % ----------- Select the First Parentat position i,j ---------
        parent_1 = (i * grid_x) + j;
        chosen = parent_1;
        parent_1 = population(chosen,:);
        fit_parent_1 = fit(chosen);
        % ----------- Select the second parent -----------------------
        y = floor(chosen/grid_x);
        x = chosen - (y * grid_x);
        neighbourhood = [];
        if y == 0
            %% ------ First element of the grid ---------
            if x == 1 
                x1 = x + 1;
                y1 = y;
                x2 = x;
                y2 = y+1;
                x3 = x;
                y3 = grid_y - 1;
                x4 = grid_x;
                y4 = y;
                candidate1 = (y1 * grid_x) + x1;
                candidate2 = (y2 * grid_x) + x2;
                candidate3 = (y3 * grid_x) + x3;
                candidate4 = (y4 * grid_x) + x4;
                neighbourhood = [candidate2 candidate1 candidate3 candidate4];
            else 
               %% ----------- First line of the grid -----------------------
                x1 = x + 1;
                y1 = y;
                x2 = x;
                y2 = y+1;
                x3 = x;
                y3 = grid_y - 1;
                x4 = x - 1;
                y4 = y;
                candidate1 = (y1 * grid_x) + x1;
                candidate2 = (y2 * grid_x) + x2;
                candidate3 = (y3 * grid_x) + x3;
                candidate4 = (y4 * grid_x) + x4;
                neighbourhood = [candidate4 candidate1 candidate2  candidate3];               
            end
        else
             if x == 0
                if y == 1
                   %% ------------ the last element of the first line -------------
                   x1 = grid_x - 1;
                   y1 = 0;
                   x2 = 0;
                   y2 = 2;
                   x3 = 1;
                   y3 = 0;
                   x4 = 0;
                   y4 = grid_y;
                   candidate1 = (y1 * grid_x) + x1;
                   candidate2 = (y2 * grid_x) + x2;
                   candidate3 = (y3 * grid_x) + x3;
                   candidate4 = (y4 * grid_x) + x4;
                   neighbourhood = [candidate3 candidate1 candidate2 candidate4]; 
                else
                   if y == grid_y
                      %% ------------ the last element of the last line -------------
                      x1 = 1;
                      y1 = grid_y - 1;
                      x2 = 0;
                      y2 = grid_y - 1;
                      x3 = grid_x - 1;
                      y3 = grid_y - 1;
                      x4 = 0;
                      y4 = 1;
                      candidate1 = (y1 * grid_x) + x1;
                      candidate2 = (y2 * grid_x) + x2;
                      candidate3 = (y3 * grid_x) + x3;
                      candidate4 = (y4 * grid_x) + x4;
                      neighbourhood = [candidate4 candidate1 candidate2 candidate3]; 
                   else
                      %% ------------ the last element of the rest line -------------
                      x1 = 0;
                      y1 = y - 1;
                      x2 = 1;
                      y2 = y - 1;
                      x3 = grid_x - 1;
                      y3 = y - 1;
                      x4 = 0;
                      y4 = y + 1;
                      candidate1 = (y1 * grid_x) + x1;
                      candidate2 = (y2 * grid_x) + x2;
                      candidate3 = (y3 * grid_x) + x3;
                      candidate4 = (y4 * grid_x) + x4;
                      neighbourhood = [candidate1 candidate2 candidate3 candidate4];                      
                   end
                end
             else
                 if x == 1
                    if y == (grid_y - 1)
                       %% --------------- first element of the last line -----------
                        x1 = 1;
                        y1 = 0;
                        x2 = 1;
                        y2 = y - 1;
                        x3 = x + 1;
                        y3 = y;
                        x4 = 0;
                        y4 = y + 1;
                        candidate1 = (y1 * grid_x) + x1;
                        candidate2 = (y2 * grid_x) + x2;
                        candidate3 = (y3 * grid_x) + x3;
                        candidate4 = (y4 * grid_x) + x4;
                        neighbourhood = [candidate1 candidate2 candidate3 candidate4];                 
                    else
                       %% --------------- first element of the remaining lines ----------- 
                        x1 = 1;
                        y1 = y - 1;
                        x2 = 1;
                        y2 = y + 1;
                        x3 = x + 1;
                        y3 = y;
                        x4 = 0;
                        y4 = y + 1;
                        candidate1 = (y1 * grid_x) + x1;
                        candidate2 = (y2 * grid_x) + x2;
                        candidate3 = (y3 * grid_x) + x3;
                        candidate4 = (y4 * grid_x) + x4;
                        neighbourhood = [candidate1 candidate2 candidate3 candidate4];                          
                    end
                 else
                    if  y  == (grid_y - 1)
                       %% --------------- other element of the last line ----------- 
                        x1 = x;
                        y1 = y - 1;
                        x2 = x - 1;
                        y2 = y;
                        x3 = x + 1;
                        y3 = y;
                        x4 = x;
                        y4 = 0;
                        candidate1 = (y1 * grid_x) + x1;
                        candidate2 = (y2 * grid_x) + x2;
                        candidate3 = (y3 * grid_x) + x3;
                        candidate4 = (y4 * grid_x) + x4;
                        neighbourhood = [candidate1 candidate2 candidate3 candidate4];                     
                    else
                       %% --------------- other element of the remaining lines ----------- 
                        x1 = x - 1;
                        y1 = y ;
                        x2 = x + 1;
                        y2 = y;
                        x3 = x;
                        y3 = y + 1;
                        x4 = x;
                        y4 = y - 1;
                        candidate1 = (y1 * grid_x) + x1;
                        candidate2 = (y2 * grid_x) + x2;
                        candidate3 = (y3 * grid_x) + x3;
                        candidate4 = (y4 * grid_x) + x4;
                        neighbourhood = [candidate4 candidate1 candidate2 candidate3];                        
                    end
                 end
              end
        end
        % ------ Perform the binary tournament on the neighbourhoud --------- 
        fit_list = []; 
        for k=1:length(neighbourhood) 
            fit_list = [fit_list fit(neighbourhood(k))]; 
        end
        % ------ extract the best individual from the neighbourhood----------
        [chosen_value,ind_chosen] = min(fit_list); 
        indice = neighbourhood(ind_chosen); 
        parent_2 = population(indice,:); 
        fit_parent_2 = fit(indice);
        %% ----------------- Perform DPX1 crossover -------------------------
        if rand <= pcr 
            cross_point_one = randi(Dimension); 
            cross_point_two = randi(Dimension);  
            % -- condition to avoid the first point is after the second -----
            if cross_point_one > cross_point_two 
                a = cross_point_one; 
                cross_point_one = cross_point_two; 
                cross_point_two = a; 
            end
            c1 = [parent_1(1:cross_point_one) parent_2((cross_point_one+1):cross_point_two) parent_1((cross_point_two + 1):Dimension)];
            c2 = [parent_2(1:cross_point_one) parent_1((cross_point_one+1):cross_point_two) parent_2((cross_point_two + 1):Dimension)];
        else
            c1 = parent_1;
            c2 = parent_2;
        end
        %% --- find the best parent ----
             % ---- this step is useless since we do'nt compare to the best parent but to the best individual in the whole population: like the original DPX1 -
        if fit_parent_2 > fit_parent_1
            best_parent = parent_1;
        else
            best_parent = parent_2;
        end
        % ------- compute the child that has the bigger part of the best ---
        sub_1 = abs(c1 - gbest);
        sub_2 = abs(c2 - gbest);
        pos_1 = find(sub_1 == 0);
        pos_2 = find(sub_2 == 0);
        test_1 = length(pos_1);
        test_2 = length(pos_2);
        if test_1 > test_2
            child = c1;
        else
            child = c2;
        end
        %% ---- Apply Bit-Flip Mutation On the resulted child --------------
        vect_bit_flip = rand(1,Dimension); 
        test_bit_flip = repmat(pm,1,Dimension);
        vect_bit_flip = (vect_bit_flip <= test_bit_flip);  
        child = xor(child,vect_bit_flip); 
        % ----- In order to avoid having non feasible solutions ------------
        if isequal(child,zeros(1,Dimension)) == 1
            child(randi(Dimension)) = 1;
        end
        %% ---------- Evaluation of the Produced Offsprings ----------------
        child_fit = RC_Function(child,Dimension,network,neighbourhoud); 
        %% ---------- Update the population using binary tournament --------
        if child_fit <= fit_parent_1
           futur_population(chosen,:) = child;
           futur_fit(chosen) = child_fit;
        end
    end
end
%% ------------ Update the population --------------------------------
population = futur_population;
fit = futur_fit;
%% ------------calculate the new best individual --------------------
[bestFit,indbest] = min(fit);
gbest = population(indbest,:);
fitness_best = fit(indbest);
%% Recording the number of itterations needed to obtain results as good or better than State-of-the-art Algorithms
if fitness_best <= state_of_the_art(ind)
   if iter_needed(exe) == 0 
       iter_needed(exe)  = it;
	   time_needed(exe)  = toc;
   end
end
%% --------------------------------------------------------------------
ALL_FITNESSES = [ALL_FITNESSES fitness_best]; 
ALL_ITTERATIONS = [ALL_ITTERATIONS (it * indiv)];
% -------------------------------------------------------------------------
end %--------------end of the loop t=1:iter-------------------------------
if FITNESS_GBEST > fitness_best
FITNESS_GBEST = fitness_best;
GBEST_ALL = gbest;
end
ALL_EXECUTION = [ALL_EXECUTION fitness_best];
oo = toc;
ti = ti + oo;
ALL_TIME = [ALL_TIME ti];
end
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
vect_two = [cell2mat(result(4))'];
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
xlwrite(name,transpose(fit),10);
xlwrite(name,transpose(iter_needed),11);
xlwrite(name,transpose(time_needed),12);
xlwrite(name,transpose(mutation_evo),13);
end
%% I added this command because Daniel told me that if i don't add it it will ot escape and display the results of the run 
exit;
