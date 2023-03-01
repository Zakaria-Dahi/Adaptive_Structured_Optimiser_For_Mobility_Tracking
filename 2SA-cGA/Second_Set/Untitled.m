grid_x = 9;
grid_y = 4;
% ----------- Select the First Parentat position i,j ---------
chosen = 14;
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
neighbourhood